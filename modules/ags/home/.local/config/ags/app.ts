import app from "ags/gtk4/app"
import style from "./style.css"
import Launcher from "./widget/Launcher"

app.start({
	css: style,
	main() {
		Launcher()
	},
})
