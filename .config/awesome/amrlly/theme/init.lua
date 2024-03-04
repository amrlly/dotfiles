local beautiful = require("beautiful")
local assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local shape = require("gears.shape")

local path = gfs.get_configuration_dir() .. "/amrlly/theme"

local M = {}

-- Colors
local color = {}

color.bg_1 = "#2e3440"
color.bg_2 = "#3b4252"
color.bg_3 = "#434c5e"
color.bg_4 = "#4c566a"

color.fg_1 = "#89909e"
color.fg_2 = "#b3b9c6"
color.fg_3 = "#d8dee9"
color.fg_4 = "#e5e9f0"

color.ac_1 = "#8fbcbb"
color.ac_2 = "#88c0d0"
color.ac_3 = "#81a1c1"
color.ac_4 = "#5e81ac"

color.error = "#bf616a"
color.danger = "#d08770"
color.warn = "#ebcb8b"
color.success = "#a3be8c"
color.other = "#b48ead"

-- General
M.font = "RobotoMono Nerd Font Mono 11"
M.icon_theme = nil

-- Clients
M.useless_gap = dpi(4)
M.corner_radius = dpi(4)
M.border_width = dpi(1.5)
M.border_color_normal = color.bg_1
M.border_color_active = color.bg_4

-- Menubar stuff
M.menubar_bg = color.bg_1

M.menubar_item_bg = color.bg_2
M.menubar_item_fg = color.fg_2
M.menubar_item_shape = function(cr, w, h)
	shape.rounded_rect(cr, w, h, dpi(4))
end

M.menubar_button_bg = M.menubar_item_bg
M.menubar_button_fg = M.menubar_item_fg
M.menubar_button_bg_hover = color.bg_3
M.menubar_button_fg_hover = color.ac_2
M.menubar_button_bg_click = color.bg_2
M.menubar_button_fg_click = color.ac_1
M.menubar_button_shape = function(cr, w, h)
	shape.rounded_rect(cr, w, h, dpi(4))
end

M.menubar_separator_bg = color.bg_3

M.launcher_icon = assets.awesome_icon(48, color.fg_1, color.bg_2)
M.launcher_icon_hover = assets.awesome_icon(48, color.ac_2, color.bg_3)
M.launcher_icon_click = assets.awesome_icon(48, color.ac_1, color.bg_2)

M.bg_systray = M.menubar_bg
M.systray_max_rows = 1
M.systray_icon_spacing = dpi(8)

M.taglist_fg_hover = color.ac_2
M.taglist_bg_hover = color.bg_3
M.taglist_fg_empty = color.fg_1
M.taglist_bg_empty = color.bg_2
M.taglist_fg_occupied = color.fg_2
M.taglist_bg_occupied = color.bg_2
M.taglist_fg_volatile = color.fg_2
M.taglist_bg_volatile = color.bg_2
M.taglist_fg_urgent = color.fg_4
M.taglist_bg_urgent = color.ac_1
M.taglist_fg_focus = color.fg_4
M.taglist_bg_focus = color.bg_4
M.taglist_shape = function(cr, w, h)
	shape.rounded_rect(cr, w, h, dpi(4))
end

M.tasklist_fg_normal = color.fg_3
M.tasklist_bg_normal = color.bg_2
M.tasklist_fg_focus = color.ac_2
M.tasklist_bg_focus = color.bg_3
M.tasklist_fg_urgent = color.fg_4
M.tasklist_bg_urgent = color.ac_1
M.tasklist_fg_minimize = color.fg_1
M.tasklist_bg_minimize = color.bg_2
M.tasklist_plain_task_name = true
M.tasklist_shape = function(cr, w, h)
	shape.rounded_rect(cr, w, h, dpi(4))
end

M.layout_fairh = path .. "/assets/layouts/fairhw.png"
M.layout_fairv = path .. "/assets/layouts/fairvw.png"
M.layout_floating = path .. "/assets/layouts/floatingw.png"
M.layout_magnifier = path .. "/assets/layouts/magnifierw.png"
M.layout_max = path .. "/assets/layouts/maxw.png"
M.layout_fullscreen = path .. "/assets/layouts/fullscreenw.png"
M.layout_tilebottom = path .. "/assets/layouts/tilebottomw.png"
M.layout_tileleft = path .. "/assets/layouts/tileleftw.png"
M.layout_tile = path .. "/assets/layouts/tilew.png"
M.layout_tiletop = path .. "/assets/layouts/tiletopw.png"
M.layout_spiral = path .. "/assets/layouts/spiralw.png"
M.layout_dwindle = path .. "/assets/layouts/dwindlew.png"
M.layout_cornernw = path .. "/assets/layouts/cornernww.png"
M.layout_cornerne = path .. "/assets/layouts/cornernew.png"
M.layout_cornersw = path .. "/assets/layouts/cornersww.png"
M.layout_cornerse = path .. "/assets/layouts/cornersew.png"

function M.init()
	beautiful.init(M)
end

return M
