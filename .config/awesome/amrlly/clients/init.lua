local awful = require("awful")
local ruled = require("ruled")

local M = {}

function M.init()
	require("awful.autofocus")

	client.connect_signal("mouse::enter", function(c)
		c:activate({ context = "mouse_enter", raise = false })
	end)

	ruled.client.connect_signal("request::rules", function()
		ruled.client.append_rule({
			id = "global",
			rule = {},
			properties = {
				focus = awful.client.focus.filter,
				raise = true,
				screen = awful.screen.preferred,
				placement = awful.placement.no_overlap + awful.placement.no_offscreen,
			},
		})

		ruled.client.append_rule({
			id = "floating",
			rule_any = { role = { "AlarmWindow", "ConfigManager", "pop-up" } },
			properties = { floating = true },
		})

		ruled.client.append_rule({
			id = "titlebars",
			rule_any = { type = { "normal", "dialog" } },
		})
	end)
end

return M
