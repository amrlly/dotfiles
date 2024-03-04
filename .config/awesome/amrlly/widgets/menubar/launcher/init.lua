local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")

local item = require("amrlly.widgets.menubar.item")

local M = { mt = {} }

function M.new()
	local menu = awful.menu({
		{
			"awesome",
			{
				{
					"restart",
					function()
						awesome.restart()
					end,
				},
				{
					"quit",
					function()
						awesome.quit()
					end,
				},
			},
		},
		{
			"power",
			{
				{ "lock", "xset dpms force standby" },
				{ "suspend", "systemctl suspend" },
				{ "reboot", "systemctl reboot" },
				{ "shutdown", "systemctl poweroff" },
			},
		},
	})

	local image = wibox.widget({
		image = beautiful.launcher_icon,
		clip_shape = beautiful.menubar_item_shape,
		widget = wibox.widget.imagebox,
	})

	local widget = item(image, { clickable = true, style = { padding_x = 2, padding_y = 2 } })

	widget:connect_signal("button::press", function()
		menu:toggle()
		image.image = beautiful.launcher_icon_click
	end)
	widget:connect_signal("button::release", function()
		image.image = beautiful.launcher_icon_hover
	end)
	widget:connect_signal("mouse::enter", function()
		image.image = beautiful.launcher_icon_hover
	end)
	widget:connect_signal("mouse::leave", function()
		image.image = beautiful.launcher_icon
	end)

	return widget
end

function M.mt:__call()
	return M.new()
end

return setmetatable(M, M.mt)
