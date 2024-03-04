local awful = require("awful")

local config = require("amrlly.config")

return {
	awful.button({}, 1, function(c)
		c:activate({ context = "mouse_click" })
	end),

	awful.button({ config.keys.mod }, 1, function(c)
		c:activate({ context = "mouse_click", action = "mouse_move" })
	end),

	awful.button({ config.keys.mod }, 3, function(c)
		c:activate({ context = "mouse_click", action = "mouse_resize" })
	end),
}
