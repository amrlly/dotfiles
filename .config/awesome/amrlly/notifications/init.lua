local naughty = require("naughty")
local awful = require("awful")
local ruled = require("ruled")

local M = {}

function M.init()
	naughty.connect_signal("request::display", function(n)
		naughty.layout.box({ notification = n })
	end)

	ruled.notification.connect_signal("request::rules", function()
		ruled.notification.append_rule({
			rule = {},
			properties = {
				screen = awful.screen.preferred,
				implicit_timeout = 5,
			},
		})
	end)
end

return M
