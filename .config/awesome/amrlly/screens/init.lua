local awful = require("awful")

local M = {}

function M.init()
	tag.connect_signal("request::default_layouts", function()
		awful.layout.append_default_layouts({
			awful.layout.suit.tile,
			awful.layout.suit.tile.bottom,
			awful.layout.suit.fair,
			awful.layout.suit.fair.horizontal,
			awful.layout.suit.magnifier,
			awful.layout.suit.tile.top,
			awful.layout.suit.tile.left,
			awful.layout.suit.floating,
		})
	end)

	screen.connect_signal("request::desktop_decoration", function(screen)
		awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8" }, screen, awful.layout.layouts[1])
	end)
end

return M
