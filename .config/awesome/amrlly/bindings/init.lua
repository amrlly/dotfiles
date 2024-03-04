local awful = require("awful")

local M = {
	global = require("amrlly.bindings.global"),
	client = require("amrlly.bindings.client"),
}

function M.init()
	awful.keyboard.append_global_keybindings(M.global.keys)
	awful.mouse.append_global_mousebindings(M.global.buttons)

	client.connect_signal("request::default_keybindings", function()
		awful.keyboard.append_client_keybindings(M.client.keys)
	end)

	client.connect_signal("request::default_mousebindings", function()
		awful.mouse.append_client_mousebindings(M.client.buttons)
	end)
end

return M
