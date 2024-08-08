-- Shameless by from https://github.com/Allaman/nvim/blob/main/lua/core/plugins/lsp/settings/yaml.lua
return {
	schemaStore = {
		enable = true,
		url = "https://www.schemastore.org/api/json/catalog.json",
	},
	schemas = {
		kubernetes = "*.yaml",
		["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
		["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
		["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
		["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
		["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
		["https://gitlab.com/gitlab-org/gitlab/-/raw/master/app/assets/javascripts/editor/schema/ci.json"] = "*gitlab-ci*.{yml,yaml}",
		["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
		["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
	},
	format = { enabled = false },
	validate = false,
	completion = true,
	hover = true,
}
