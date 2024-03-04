local wibox = require("wibox")

local M = { mt = {}, instance = nil }

function M.new()
	if M.instance then
		return M.instance
	end

	local widget = wibox.widget.systray()

	M.instance = widget
	return M.instance
end

function M.mt:__call()
	return M.new()
end

return setmetatable(M, M.mt)
