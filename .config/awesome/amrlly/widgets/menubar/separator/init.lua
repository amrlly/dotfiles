local dpi = require("beautiful.xresources").apply_dpi
local beautiful = require("beautiful")
local wibox = require("wibox")

local M = { mt = {} }

function M.new()
	return wibox.widget({
		color = beautiful.menubar_separator_bg,
		orientation = "vertical",
		thickness = dpi(1.5),
		forced_width = dpi(1.5),
		widget = wibox.widget.separator,
	})
end

function M.mt:__call()
	return M.new()
end

return setmetatable(M, M.mt)
