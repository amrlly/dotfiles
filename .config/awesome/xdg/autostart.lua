local M = {}

local awful = require("awful")
local dirs = require("xdg.dirs")

function M.init()
	local name = "awesome.started"
	local autostart_dir = dirs.config_home .. "/autostart"


	awful.spawn.easy_async("xrdb -query", function(out)
		if out:match(name) then
			return;
		end

		awful.spawn.with_shell("echo '" .. name .. ":true' | xrdb -merge")
		awful.spawn.with_shell("dex --environment Awesome --autostart --search-paths " .. autostart_dir)
	end)
end

return M
