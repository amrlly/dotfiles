local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local wibox = require("wibox")
local gears = require("gears")

local M = { mt = {} }

function M.new(widget, params)
	params = params or {}
	params.clickable = params.clickable or false

	params.style = params.style or {}
	params.style.padding_x = params.style.padding_x or 4
	params.style.padding_y = params.style.padding_y or 4
	params.style.corners = params.style.corners or 4

	local margin = wibox.widget({
		widget,
		top = dpi(params.style.padding_y),
		bottom = dpi(params.style.padding_y),
		left = dpi(params.style.padding_x),
		right = dpi(params.style.padding_x),
		widget = wibox.container.margin,
	})

	local background = wibox.widget({
		margin,
		fg = beautiful.menubar_item_fg,
		bg = beautiful.menubar_item_bg,
		shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, dpi(params.style.corners))
		end,
		widget = wibox.container.background,
	})

	if params.clickable then
		background:connect_signal("button::press", function()
			background:set_fg(beautiful.menubar_button_fg_click)
			background:set_bg(beautiful.menubar_button_bg_click)
		end)
		background:connect_signal("button::release", function()
			background:set_fg(beautiful.menubar_button_fg_hover)
			background:set_bg(beautiful.menubar_button_bg_hover)
		end)
		background:connect_signal("mouse::enter", function()
			background.fg = beautiful.menubar_button_fg_hover
			background.bg = beautiful.menubar_button_bg_hover
		end)
		background:connect_signal("mouse::leave", function()
			background.fg = beautiful.menubar_button_fg
			background.bg = beautiful.menubar_button_bg
		end)
	end

	return background
end

function M.mt:__call(...)
	return M.new(...)
end

return setmetatable(M, M.mt)
