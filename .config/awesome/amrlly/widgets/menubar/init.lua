local dpi = require("beautiful.xresources").apply_dpi
local beautiful = require("beautiful")
local awful = require("awful")
local wibox = require("wibox")

local widgets = {
	launcher = require("amrlly.widgets.menubar.launcher"),
	tray = require("amrlly.widgets.menubar.tray"),
	keyboard = require("amrlly.widgets.menubar.keyboard"),
	clock = require("amrlly.widgets.menubar.clock"),
	tags = require("amrlly.widgets.menubar.tags"),
	tasks = require("amrlly.widgets.menubar.tasks"),
	layouts = require("amrlly.widgets.menubar.layouts"),
	separator = require("amrlly.widgets.menubar.separator"),
}

local M = { mt = {} }

function M.new(screen)
	screen.widgets = {}

	screen.widgets.tags = widgets.tags(screen)
	screen.widgets.tasks = widgets.tasks(screen)
	screen.widgets.layouts = widgets.layouts(screen)

	screen.widgets.wibox = awful.wibar({
		screen = screen,
		position = "top",
		height = dpi(32),
		bg = beautiful.menubar_bg,
		widget = wibox.container.margin({
			{
				widgets.launcher(),
				{
					screen.widgets.tags,
					left = dpi(8),
					draw_empty = false;
					widget = wibox.container.margin,
				},
				{
					widgets.separator(),
					right = dpi(8),
					left = dpi(8),
					draw_empty = false;
					widget = wibox.container.margin,
				},

				layout = wibox.layout.fixed.horizontal,
			},
			screen.widgets.tasks,
			{
				{
					widgets.separator(),
					right = dpi(8),
					left = dpi(8),
					draw_empty = false;
					widget = wibox.container.margin,
				},
				{
					widgets.tray(),
					right = dpi(8),
					draw_empty = false;
					widget = wibox.container.margin,
				},
				{
					widgets.keyboard(),
					right = dpi(4),
					draw_empty = false;
					widget = wibox.container.margin,
				},
				{
					widgets.clock(),
					right = dpi(4),
					draw_empty = false;
					widget = wibox.container.margin,
				},
				screen.widgets.layouts,

				layout = wibox.layout.fixed.horizontal,
			},

			layout = wibox.layout.align.horizontal,
		}, dpi(4), dpi(4), dpi(4), dpi(4)),
	})
end

function M.mt:__call(...)
	return M.new(...)
end

return setmetatable(M, M.mt)
