return {
	keys = {
		mod = "Mod4",
	},

	dirs = {
		wallpapers = os.getenv("XDG_WALLPAPERS_DIR") or nil,
	},

	programs = {
		terminal = os.getenv("TERMINAL") or "xterm",
		editor = os.getenv("EDITOR") or "nano",
		pager = os.getenv("PAGER") or "less",
	},
}
