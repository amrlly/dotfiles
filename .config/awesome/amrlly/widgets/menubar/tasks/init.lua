local dpi = require("beautiful.xresources").apply_dpi
local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")

local M = { mt = {} }

function M.new(screen)
	return awful.widget.tasklist({
		screen = screen,
		filter = awful.widget.tasklist.filter.currenttags,
		style = {
			shape = beautiful.tasklist_shape,
		},
		layout = {
			spacing = dpi(8),
			layout = wibox.layout.flex.horizontal,
		},
		widget_template = {
			{
				{
					id = "icon_role",
					widget = wibox.widget.imagebox,
				},
				right = dpi(8),
				widget = wibox.container.margin,
			},
			{
				{
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					top = dpi(1.5),
					bottom = dpi(1.5),
					left = dpi(8),
					right = dpi(8),
					widget = wibox.container.margin,
				},
				id = "background_role",
				widget = wibox.container.background,
			},
			fill_space = true,
			layout = wibox.layout.fixed.horizontal,
		},
		buttons = {
			awful.button({}, 1, function(c)
				c:activate({ context = "tasklist", action = "toggle_minimization" })
			end),
			awful.button({}, 3, function()
				awful.menu.client_list({ theme = { width = 250 } })
			end),
			awful.button({}, 4, function()
				awful.client.focus.byidx(-1)
			end),
			awful.button({}, 5, function()
				awful.client.focus.byidx(1)
			end),
		},
	})
end

function M.mt:__call(...)
	return M.new(...)
end

return setmetatable(M, M.mt)
