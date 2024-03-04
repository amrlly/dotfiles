local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

local config = require("amrlly.config")

local M = { mt = {} }

function M.new(screen)
	return awful.widget.taglist({
		screen = screen,
		filter = awful.widget.taglist.filter.all,

		widget_template = {
			{
				{
					{
						id = "text_role",
						widget = wibox.widget.textbox,
					},
					id = "text_background_role",
					widget = wibox.container.background,
				},
				left = dpi(8),
				right = dpi(8),
				id = "index_role",
				widget = wibox.container.margin,
			},
			id = "background_role",
			widget = wibox.container.background,
		},

		layout = {
			spacing = dpi(4),
			layout = wibox.layout.fixed.horizontal,
		},

		buttons = {
			awful.button({}, 1, function(t)
				t:view_only()
			end),
			awful.button({ config.modkey }, 1, function(t)
				if client.focus then
					client.focus:move_to_tag(t)
				end
			end),
			awful.button({}, 3, awful.tag.viewtoggle),
			awful.button({ config.modkey }, 3, function(t)
				if client.focus then
					client.focus:toggle_tag(t)
				end
			end),
			awful.button({}, 4, function(t)
				awful.tag.viewprev(t.screen)
			end),
			awful.button({}, 5, function(t)
				awful.tag.viewnext(t.screen)
			end),
		},
	})
end

function M.mt:__call(...)
	return M.new(...)
end

return setmetatable(M, M.mt)
