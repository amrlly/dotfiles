local awful = require("awful")

local config = require("amrlly.config")

return awful.menu({
	items = {
		{ "open terminal", config.programs.terminal },
	},
})
