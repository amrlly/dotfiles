local wibox = require("wibox")

local item = require("amrlly.widgets.menubar.item")

local M = { mt = {} }

function M.new()
	local content = wibox.widget.textclock("%H:%M")
	local widget = item(content, { clickable = true, style = { padding_x = 8 } })

	return widget
end

function M.mt:__call()
	return M.new()
end

return setmetatable(M, M.mt)
