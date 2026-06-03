return {
	"rmagatti/auto-session",
	lazy = false,
	opts = {
		suppressed_dirs = { "~/", "/tmp" },
		auto_restore = false, -- on restore manuellement via le dashboard
		auto_save = true, -- sauvegarde automatique en quittant
	},
}
