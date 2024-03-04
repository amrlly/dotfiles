local awful = require("awful")

local item = require("amrlly.widgets.menubar.item")

local M = { mt = {} }

function M.new(screen)
	local layoutbox = awful.widget.layoutbox({
		screen = screen,
		buttons = {
			awful.button({}, 1, function()
				awful.layout.inc(1)
			end),
			awful.button({}, 3, function()
				awful.layout.inc(-1)
			end),
			awful.button({}, 4, function()
				awful.layout.inc(-1)
			end),
			awful.button({}, 5, function()
				awful.layout.inc(1)
			end),
		},
	})

	return item(layoutbox, { clickable = true, style = { padding_x = 2, padding_y = 2 } })
end

function M.mt:__call(...)
	return M.new(...)
end

return setmetatable(M, M.mt)
