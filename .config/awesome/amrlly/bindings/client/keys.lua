local awful = require("awful")

local config = require("amrlly.config")

return {
	awful.key({ config.keys.mod }, "f", function(c)
		c.fullscreen = not c.fullscreen
		c:raise()
	end, {
		description = "Toggle fullscreen",
		group = "Client",
	}),

	awful.key({ config.keys.mod, "Shift" }, "c", function(c)
		c:kill()
	end, {
		description = "Close",
		group = "Client",
	}),

	awful.key({ config.keys.mod, "Control" }, "space", function(c)
		awful.client.floating.toggle(c)
	end, {
		description = "Toggle floating",
		group = "Client",
	}),

	awful.key({ config.keys.mod, "Control" }, "Return", function(c)
		c:swap(awful.client.getmaster())
	end, {
		description = "Move to master",
		group = "Client",
	}),

	awful.key({ config.keys.mod }, "o", function(c)
		c:move_to_screen()
	end, {
		description = "Move to screen",
		group = "Client",
	}),

	awful.key({ config.keys.mod }, "t", function(c)
		c.ontop = not c.ontop
	end, {
		description = "Toggle keep on top",
		group = "Client",
	}),

	awful.key({ config.keys.mod }, "n", function(c)
		c.minimized = true
	end, {
		description = "Minimize",
		group = "Client",
	}),

	awful.key({ config.keys.mod }, "m", function(c)
		c.maximized = not c.maximized
		c:raise()
	end, {
		description = "(Un)maximize",
		group = "Client",
	}),

	awful.key({ config.keys.mod, "Control" }, "m", function(c)
		c.maximized_vertical = not c.maximized_vertical
		c:raise()
	end, {
		description = "(Un)maximize vertically",
		group = "Client",
	}),

	awful.key({ config.keys.mod, "Shift" }, "m", function(c)
		c.maximized_horizontal = not c.maximized_horizontal
		c:raise()
	end, {
		description = "(Un)maximize horizontally",
		group = "Client",
	}),
}
