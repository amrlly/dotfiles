local awful = require("awful")

local item = require("amrlly.widgets.menubar.item")

local M = { mt = {}, instance = nil }

function M.style_text(textbox)
	if textbox._is_styling then
		return
	end
	textbox._is_styling = true
	textbox.text = string.upper(textbox.text)
	textbox._is_styling = nil
end

function M.new()
	if M.instance then
		return M.instance
	end

	local kbd = awful.widget.keyboardlayout()
	local textbox = kbd.widget
	local buttons = kbd.buttons
	kbd.buttons = {}

	local widget = item(kbd, { clickable = true, style = { padding_x = 2 } })
	widget.buttons = buttons

	M.style_text(textbox)
	textbox:connect_signal("property::text", M.style_text)

	M.instance = widget
	return M.instance
end

function M.mt:__call()
	return M.new()
end

return setmetatable(M, M.mt)
