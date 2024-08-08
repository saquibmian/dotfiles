return {
	format = { enabled = false },
	schemas = {
		{
			description = "ESLint config",
			fileMatch = { ".eslintrc.json", ".eslintrc" },
			url = "http://json.schemastore.org/eslintrc",
		},
		{
			description = "Package config",
			fileMatch = { "package.json" },
			url = "https://json.schemastore.org/package",
		},
		{
			description = "Tasks config",
			fileMatch = { "*tasks*.json" },
			url = "https://json.schemastore.org/task.json",
		},
	},
}
