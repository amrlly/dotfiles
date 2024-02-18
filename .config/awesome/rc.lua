pcall(require("luarocks.loader"))

local lfs = require("lfs")
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local menubar = require("menubar")
local naughty = require("naughty")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
local autostart = require("xdg.autostart")

--# Error handling

if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Startup went wrong",
		text = awesome.startup_errors,
	})
end

awesome.connect_signal("debug::error", function(err)
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "Something went wrong",
		text = tostring(err),
	})
end)

--# Essential

require("awful.autofocus")
autostart.init()

--# Theming

local theme = require("theme.theme")
beautiful.init(theme)

--# Variables

local modkey = "Mod4"
local terminal = os.getenv("TERMINAL")

menubar.utils.terminal = terminal

--# Widgets

local awesome_menu = {
	{ "restart", function() awesome.restart() end },
	{ "quit",    function() awesome.quit() end },
}

local main_menu = awful.menu({
	items = {
		{ "awesome",       awesome_menu, beautiful.awesome_icon },
		{ "open terminal", terminal },
	},
})

local launcher = awful.widget.launcher({
	image = beautiful.awesome_icon,
	menu = main_menu,
})

local keyboard_layout = awful.widget.keyboardlayout()

local text_clock = wibox.widget.textclock()

--# Buttons

local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t) t:view_only() end),
	awful.button({ modkey }, 1, function(t)
		if not client.focus then
			return
		end
		client.focus:move_to_tag(t)
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if not client.focus then
			return
		end
		client.focus:toggle_tag(t)
	end),
	awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", { raise = true })
		end
	end),
	awful.button({}, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
	awful.button({}, 4, function() awful.client.focus.byidx(1) end),
	awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
)

local root_buttons = gears.table.join(
	awful.button({}, 3, function() main_menu:toggle() end),
	awful.button({}, 4, awful.tag.viewnext),
	awful.button({}, 5, awful.tag.viewprev)
)

local client_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
	end),
	awful.button({ modkey }, 1, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function(c)
		c:emit_signal("request::activate", "mouse_click", { raise = true })
		awful.mouse.client.resize(c)
	end)
)

--# Keys

local root_keys = gears.table.join(
	awful.key(
		{ modkey }, "s",
		hotkeys_popup.show_help,
		{ description = "Show help", group = "Awesome" }
	),
	awful.key(
		{ modkey, "Shift", "Control" }, "r",
		function() awesome.restart() end,
		{ description = "Reload", group = "Awesome" }
	),
	awful.key(
		{ modkey, "Shift", "Control" }, "q",
		function() awesome.quit() end,
		{ description = "Quit", group = "Awesome" }
	),
	awful.key(
		{ modkey, }, "w",
		function() main_menu:show() end,
		{ description = "Show main menu", group = "Awesome" }
	),

	-- Applications
	awful.key(
		{ modkey }, "Return",
		function() awful.spawn("alacritty") end,
		{ description = "Open a terminal", group = "Applications" }
	),

	-- Tags
	awful.key(
		{ modkey, }, "Left",
		awful.tag.viewprev,
		{ description = "View previous", group = "Tag" }
	),
	awful.key(
		{ modkey, }, "Right",
		awful.tag.viewnext,
		{ description = "View next", group = "Tag" }
	),
	awful.key(
		{ modkey, }, "Escape",
		awful.tag.history.restore,
		{ description = "Go back", group = "Tag" }
	),

	-- Clients
	awful.key(
		{ modkey, }, "u",
		awful.client.urgent.jumpto,
		{ description = "Jump to urgent client", group = "Client" }
	),
	awful.key(
		{ modkey, }, "j",
		function() awful.client.focus.byidx(1) end,
		{ description = "Focus next by index", group = "Client" }
	),
	awful.key(
		{ modkey, }, "k",
		function() awful.client.focus.byidx(-1) end,
		{ description = "Focus previous by index", group = "Client" }
	),
	awful.key(
		{ modkey, "Shift" }, "j",
		function() awful.client.swap.byidx(1) end,
		{ description = "Swap with next client by index", group = "Client" }
	),
	awful.key(
		{ modkey, "Shift" }, "k",
		function() awful.client.swap.byidx(-1) end,
		{ description = "Swap with previous client by index", group = "Client" }
	),
	awful.key(
		{ modkey, }, "Tab",
		function()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		{ description = "Go back", group = "Client" }),
	awful.key(
		{ modkey, "Control" }, "n",
		function()
			local c = awful.client.restore()
			-- Focus restored client
			if c then
				c:emit_signal("request::activate", "key.unminimize", { raise = true })
			end
		end,
		{ description = "Restore minimized", group = "Client" }
	),

	-- Layout
	awful.key(
		{ modkey, }, "l",
		function() awful.tag.incmwfact(0.05) end,
		{ description = "Increase master width factor", group = "Layout" }
	),
	awful.key(
		{ modkey, }, "h",
		function() awful.tag.incmwfact(-0.05) end,
		{ description = "Decrease master width factor", group = "Layout" }
	),
	awful.key(
		{ modkey, "Shift" }, "h",
		function() awful.tag.incnmaster(1, nil, true) end,
		{ description = "Increase the number of master clients", group = "Layout" }
	),
	awful.key(
		{ modkey, "Shift" }, "l",
		function() awful.tag.incnmaster(-1, nil, true) end,
		{ description = "Decrease the number of master clients", group = "Layout" }
	),
	awful.key(
		{ modkey, "Control" }, "h",
		function() awful.tag.incncol(1, nil, true) end,
		{ description = "Increase the number of columns", group = "Layout" }
	),
	awful.key(
		{ modkey, "Control" }, "l",
		function() awful.tag.incncol(-1, nil, true) end,
		{ description = "Decrease the number of columns", group = "Layout" }
	),
	awful.key(
		{ modkey, }, "space",
		function() awful.layout.inc(1) end,
		{ description = "Select next", group = "Layout" }
	),
	awful.key(
		{ modkey, "Shift" }, "space",
		function() awful.layout.inc(-1) end,
		{ description = "Select previous", group = "Layout" }
	),

	-- Screen
	awful.key(
		{ modkey, "Control" }, "j",
		function() awful.screen.focus_relative(1) end,
		{ description = "Focus the next screen", group = "Screen" }
	),
	awful.key(
		{ modkey, "Control" }, "k",
		function() awful.screen.focus_relative(-1) end,
		{ description = "Focus the previous screen", group = "Screen" }
	),

	-- Launcher
	awful.key(
		{ modkey }, "r",
		function() awful.screen.focused().widgets.prompt:run() end,
		{ description = "Run a command", group = "Launcher" }
	),
	awful.key(
		{ modkey }, "x",
		function()
			awful.prompt.run({
				prompt       = "Code: ",
				textbox      = awful.screen.focused().widgets.prompt.widget,
				exe_callback = awful.util.eval,
				history_path = awful.util.get_cache_dir() .. "/history_eval"
			})
		end,
		{ description = "Execute Lua code", group = "Launcher" }
	),
	awful.key(
		{ modkey }, "p",
		function() menubar.show() end,
		{ description = "Show the menubar", group = "Launcher" }
	)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	root_keys = gears.table.join(root_keys,
		awful.key(
			{ modkey }, "#" .. i + 9,
			function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			{ description = "View tag #" .. i, group = "Tag" }
		),
		awful.key(
			{ modkey, "Control" }, "#" .. i + 9,
			function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end,
			{ description = "Toggle tag #" .. i, group = "Tag" }
		),
		awful.key(
			{ modkey, "Shift" }, "#" .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end,
			{ description = "Move focused client to tag #" .. i, group = "Tag" }
		),
		awful.key(
			{ modkey, "Control", "Shift" }, "#" .. i + 9,
			function()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end,
			{ description = "Toggle focused client on tag #" .. i, group = "Tag" }
		)
	)
end

local client_keys = gears.table.join(
	awful.key(
		{ modkey }, "f",
		function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		{ description = "Toggle fullscreen", group = "Client" }
	),
	awful.key(
		{ modkey, "Shift" }, "c",
		function(c) c:kill() end,
		{ description = "Close", group = "Client" }
	),

	awful.key(
		{ modkey, "Control" }, "space",
		awful.client.floating.toggle,
		{ description = "Toggle floating", group = "Client" }
	),
	awful.key(
		{ modkey, "Control" }, "Return",
		function(c) c:swap(awful.client.getmaster()) end,
		{ description = "Move to master", group = "Client" }
	),
	awful.key(
		{ modkey }, "o",
		function(c) c:move_to_screen() end,
		{ description = "Move to screen", group = "Client" }
	),
	awful.key(
		{ modkey }, "t",
		function(c) c.ontop = not c.ontop end,
		{ description = "Toggle keep on top", group = "Client" }
	),
	awful.key(
		{ modkey, }, "n",
		function(c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.
			c.minimized = true
		end,
		{ description = "Minimize", group = "Client" }
	),
	awful.key(
		{ modkey }, "m",
		function(c)
			c.maximized = not c.maximized
			c:raise()
		end,
		{ description = "(Un)maximize", group = "Client" }
	),
	awful.key(
		{ modkey, "Control" }, "m",
		function(c)
			c.maximized_vertical = not c.maximized_vertical
			c:raise()
		end,
		{ description = "(Un)maximize vertically", group = "Client" }
	),
	awful.key(
		{ modkey, "Shift" }, "m",
		function(c)
			c.maximized_horizontal = not c.maximized_horizontal
			c:raise()
		end,
		{ description = "(Un)maximize horizontally", group = "Client" }
	)
)

--# Layouts

awful.layout.layouts = {
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.magnifier,
	awful.layout.suit.floating,
}

--# Root

root.keys(root_keys)
root.buttons(root_buttons)

--# Rules

awful.rules.rules = {
	-- All
	{
		rule = {},
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = client_keys,
			buttons = client_buttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap + awful.placement.no_offscreen
		}
	},
	-- Floating
	{
		rule_any = {
			instance = {
				"DTA", -- Firefox addon DownThemAll.
				"copyq", -- Includes session name in class.
				"pinentry",
			},
			class = {
				"Arandr",
				"Blueman-manager",
				"Gpick",
				"Kruler",
				"MessageWin", -- kalarm.
				"Sxiv",
				"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
				"Wpa_gui",
				"veromix",
				"xtightvncviewer" },

			-- Note that the name property shown in xprop might be set slightly after creation of the client
			-- and the name shown there might not match defined rules here.
			name = {
				"Event Tester", -- xev.
			},
			role = {
				"AlarmWindow", -- Thunderbird's calendar.
				"ConfigManager", -- Thunderbird's about:config.
				"pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
			}
		},
		properties = { floating = true }
	},
}

--# Screen

local wallpapers = {}

for dir in lfs.dir("/home/amrlly/pictures/wallpapers/") do
	if dir == "." or dir == ".." then
		goto continue
	end

	table.insert(wallpapers, "/home/amrlly/pictures/wallpapers/" .. dir)

	::continue::
end

math.randomseed(os.time(), os.time())
local idx = math.random(1, #(wallpapers))
local wallpaper = wallpapers[idx]

naughty.notify({text = tostring(idx)})

local function connect_wallpaper(s)
	local function update(s)
		gears.wallpaper.maximized(wallpaper, s, true)
	end

	s:connect_signal("property::geometry", update)
	update(s)
end

awful.screen.connect_for_each_screen(function(s)
	connect_wallpaper(s)

	s.widgets = {}

	s.widgets.tags = awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

	s.widgets.prompt = awful.widget.prompt()

	s.widgets.layoutbox = awful.widget.layoutbox(s)
	s.widgets.layoutbox:buttons(
		gears.table.join(
			awful.button({}, 1, function() awful.layout.inc(1, s) end),
			awful.button({}, 3, function() awful.layout.inc(-1, s) end),
			awful.button({}, 4, function() awful.layout.inc(1, s) end),
			awful.button({}, 5, function() awful.layout.inc(-1, s) end)
		)
	)

	s.widgets.taglist = awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = taglist_buttons
	})

	s.widgets.tasklist = awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		buttons = tasklist_buttons
	})

	s.widgets.wibar = awful.wibar({ position = "top", screen = s })
	s.widgets.wibar:setup({
		layout = wibox.layout.align:horizontal(),
		{
			layout = wibox.layout.fixed.horizontal,
			launcher,
			s.widgets.taglist,
			s.widgets.prompt,
		},
		s.widgets.tasklist,
		{
			layout = wibox.layout.fixed.horizontal,
			wibox.widget.systray(),
			keyboard_layout,
			text_clock,
			s.widgets.layoutbox,
		},
	})
end)

--# Client

local function shape_client(c, mode)
	if mode then
		c.shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 8) end
		return
	end

	c.shape = gears.shape.rectangle
end

client.connect_signal("manage", function(c)
	shape_client(c, true)

	if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
	end
end)

client.connect_signal("property::fullscreen", function(c)
	shape_client(c, not c.fullscreen and not c.maximized)
end)

client.connect_signal("property::maximized", function(c)
	shape_client(c, not c.fullscreen and not c.maximized)
end)

--# Client borders

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

--# Sloopy focus

client.connect_signal("mouse::enter",
	function(c) c:emit_signal("request::activate", "mouse_enter", { raise = false }) end
)
