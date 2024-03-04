local menubar = require("amrlly.widgets.menubar")

local M = {}

function M.init()
	screen.connect_signal("request::desktop_decoration", function(screen)
		menubar(screen)
	end)
end

return M
