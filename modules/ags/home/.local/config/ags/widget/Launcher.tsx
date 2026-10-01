import { For, createState } from "ags"
import { Astal, Gdk, Gtk } from "ags/gtk4"
import app from "ags/gtk4/app"
import { execAsync } from "ags/process"
import AstalApps from "gi://AstalApps"
import Graphene from "gi://Graphene"
import Pango from "gi://Pango"

const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor

const MAX_RESULTS = 8

export default function Launcher() {
	let win: Astal.Window
	let content: Gtk.Box
	let entry: Gtk.Entry

	const apps = new AstalApps.Apps()
	const [results, setResults] = createState<AstalApps.Application[]>([])

	function search(text: string) {
		setResults(text === "" ? [] : apps.fuzzy_query(text).slice(0, MAX_RESULTS))
	}

	// Launch through uwsm so each app gets its own systemd scope,
	// instead of becoming a child process of AGS.
	function launch(application?: AstalApps.Application) {
		if (!application) {
			return
		}

		win.visible = false

		if (application.entry) {
			execAsync(["uwsm", "app", "--", application.entry]).catch(console.error)
		} else {
			application.launch()
		}
	}

	// Escape closes; Alt + 1–9 launches the matching result.
	function onKey(_: Gtk.EventControllerKey, keyval: number, __: number, mod: number) {
		if (keyval === Gdk.KEY_Escape) {
			win.visible = false
			return true
		}

		if (mod & Gdk.ModifierType.ALT_MASK) {
			for (const i of [1, 2, 3, 4, 5, 6, 7, 8, 9] as const) {
				if (keyval === Gdk[`KEY_${i}`]) {
					launch(results.get()[i - 1])
					return true
				}
			}
		}

		return false
	}

	// Clicking outside the content box closes the launcher.
	function onClick(_: Gtk.GestureClick, __: number, x: number, y: number) {
		const [, rect] = content.compute_bounds(win)

		if (!rect.contains_point(new Graphene.Point({ x, y }))) {
			win.visible = false
		}
	}

	return (
		<window
			$={(self) => (win = self)}
			name="launcher"
			namespace="launcher"
			application={app}
			layer={Astal.Layer.OVERLAY}
			anchor={TOP | BOTTOM | LEFT | RIGHT}
			exclusivity={Astal.Exclusivity.IGNORE}
			keymode={Astal.Keymode.EXCLUSIVE}
			onNotifyVisible={({ visible }) => {
				if (visible) {
					apps.reload()
					entry.grab_focus()
				} else {
					entry.set_text("")
				}
			}}
		>
			<Gtk.EventControllerKey onKeyPressed={onKey} />
			<Gtk.GestureClick onPressed={onClick} />
			<box
				$={(self) => (content = self)}
				class="content"
				valign={Gtk.Align.START}
				halign={Gtk.Align.CENTER}
				orientation={Gtk.Orientation.VERTICAL}
			>
				<entry
					$={(self) => (entry = self)}
					placeholderText="Search applications"
					onNotifyText={({ text }) => search(text)}
					onActivate={() => launch(results.get()[0])}
				/>
				<box
					class="results"
					orientation={Gtk.Orientation.VERTICAL}
					visible={results((list) => list.length > 0)}
				>
					<For each={results}>
						{(application, index) => (
							<button onClicked={() => launch(application)}>
								<box spacing={12}>
									<image iconName={application.iconName} pixelSize={24} />
									<label
										class="name"
										label={application.name}
										hexpand
										halign={Gtk.Align.START}
										ellipsize={Pango.EllipsizeMode.END}
									/>
									<label
										class="shortcut"
										label={index((i) => `Alt+${i + 1}`)}
									/>
								</box>
							</button>
						)}
					</For>
				</box>
			</box>
		</window>
	)
}
