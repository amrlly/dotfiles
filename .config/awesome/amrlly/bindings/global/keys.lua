local awful = require("awful")
local menubar = require("menubar")

local config = require("amrlly.config")
local contextmenu = require("amrlly.widgets.contextmenu")

return {
	-- Awesome
	awful.key({ config.keys.mod, "Shift", "Control" }, "r", function()
		awesome.restart()
	end, { description = "Reload", group = "Awesome" }),

	awful.key({ config.keys.mod, "Shift", "Control" }, "q", function()
		awesome.quit()
	end, { description = "Quit", group = "Awesome" }),

	awful.key({ config.keys.mod }, "w", function()
		contextmenu:toggle()
	end, { description = "Show main menu", group = "Awesome" }),

	-- Launcher
	awful.key({ config.keys.mod }, "r", function()
		menubar.refresh()
	end, { description = "Refresh menubar", group = "Launcher" }),

	awful.key({ config.keys.mod }, "p", function()
		menubar.show()
	end, { description = "Show the menubar", group = "Launcher" }),

	-- Applications
	awful.key({ config.keys.mod }, "Return", function()
		awful.spawn("alacritty")
	end, { description = "Open a terminal", group = "Applications" }),

	-- Tags
	awful.key({ config.keys.mod }, "Left", awful.tag.viewprev, { description = "View previous", group = "Tag" }),
	awful.key({ config.keys.mod }, "Right", awful.tag.viewnext, { description = "View next", group = "Tag" }),
	awful.key({ config.keys.mod }, "Escape", awful.tag.history.restore, { description = "Go back", group = "Tag" }),

	-- Client
	awful.key(
		{ config.keys.mod },
		"u",
		awful.client.urgent.jumpto,
		{ description = "Jump to urgent client", group = "Focus" }
	),

	awful.key({ config.keys.mod }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "Focus next by index", group = "Focus" }),

	awful.key({ config.keys.mod }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "Focus previous by index", group = "Focus" }),

	awful.key({ config.keys.mod, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "Focus the next screen", group = "Focus" }),

	awful.key({ config.keys.mod, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "Focus the previous screen", group = "Focus" }),

	awful.key({ config.keys.mod }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "Go back", group = "Focus" }),

	awful.key({ config.keys.mod, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:emit_signal("request::activate", "key.unminimize", { raise = true })
		end
	end, { description = "Restore minimized", group = "Focus" }),

	-- Layout
	awful.key({ config.keys.mod, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "Swap with next client by index", group = "Layout" }),

	awful.key({ config.keys.mod, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "Swap with previous client by index", group = "Layout" }),

	awful.key({ config.keys.mod }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "Increase master width factor", group = "Layout" }),

	awful.key({ config.keys.mod }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "Decrease master width factor", group = "Layout" }),

	awful.key({ config.keys.mod, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "Increase the number of master clients", group = "Layout" }),

	awful.key({ config.keys.mod, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "Decrease the number of master clients", group = "Layout" }),

	awful.key({ config.keys.mod, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "Increase the number of columns", group = "Layout" }),

	awful.key({ config.keys.mod, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "Decrease the number of columns", group = "Layout" }),

	awful.key({ config.keys.mod }, "space", function()
		awful.layout.inc(1)
	end, { description = "Select next", group = "Layout" }),

	awful.key({ config.keys.mod, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "Select previous", group = "Layout" }),

	-- Per tag
	awful.key({
		modifiers = { config.keys.mod },
		keygroup = "numrow",
		description = "Only view tag",
		group = "Tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	}),

	awful.key({
		modifiers = { config.keys.mod, "Control" },
		keygroup = "numrow",
		description = "Toggle tag",
		group = "Tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
	}),

	awful.key({
		modifiers = { config.keys.mod, "Shift" },
		keygroup = "numrow",
		description = "Move focused client to tag",
		group = "Tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
	}),

	awful.key({
		modifiers = { config.keys.mod, "Control", "Shift" },
		keygroup = "numrow",
		description = "Toggle focused client on tag",
		group = "Tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end,
	}),

	awful.key({
		modifiers = { config.keys.mod },
		keygroup = "numpad",
		description = "Select layout directly",
		group = "Tag",
		on_press = function(index)
			local t = awful.screen.focused().selected_tag
			if t then
				t.layout = t.layouts[index] or t.layout
			end
		end,
	}),
}
