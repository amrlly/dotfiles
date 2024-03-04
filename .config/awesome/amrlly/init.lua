pcall(require, "luarocks.loader")

local utils = require("amrlly.utils")
utils.report_errors()
utils.autostart()

local theme = require("amrlly.theme")
theme.init()

local bindings = require("amrlly.bindings")
bindings.init()

local screens = require("amrlly.screens")
screens.init()

local clients = require("amrlly.clients")
clients.init()

local notifications = require("amrlly.notifications")
notifications.init()

local widgets = require("amrlly.widgets")
widgets.init()
