local naughty = require("naughty")
local awful = require("awful")
local debug = require("gears.debug")
local gfs = require("gears.filesystem")

local M = {}

function M.report_errors()
	naughty.connect_signal("request::display_error", function(message, startup)
		naughty.notification({
			urgency = "critical",
			title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
			message = message,
		})
	end)
end

function M.autostart()
	local name = "awesome.started"
	local autostart_dir = gfs.get_xdg_config_home() .. "/autostart"

	awful.spawn.easy_async("xrdb -query", function(out)
		if out:match(name) then
			return
		end

		awful.spawn.with_shell("echo '" .. name .. ":true' | xrdb -merge")
		awful.spawn.with_shell("dex --environment Awesome --autostart --search-paths " .. autostart_dir)
	end)
end

function M.dump(v)
	naughty.notification({ text = debug.dump_return(v) })
end

return M
