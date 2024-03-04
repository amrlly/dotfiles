local awful = require("awful")

local contextmenu = require("amrlly.widgets.contextmenu")

return {
	awful.button({}, 3, function()
		contextmenu:toggle()
	end),
}
