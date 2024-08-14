local M = {}

local entry_display = require("telescope.pickers.entry_display")

local symbol_to_icon_map = {
	["class"] = { icon = " ", hi = "TelescopeResultClass" },
	["type"] = { icon = " ", hi = "TelescopeResultClass" },
	["struct"] = { icon = " ", hi = "TelescopeResultStruct" },
	["enum"] = { icon = " ", hi = "TelescopeResultClass" },
	["union"] = { icon = " ", hi = "TelescopeResultClass" },
	["interface"] = { icon = " ", hi = "TelescopeResultMethod" },
	["method"] = { icon = " ", hi = "TelescopeResultMethod" },
	["function"] = { icon = "ƒ ", hi = "TelescopeResultFunction" },
	["constant"] = { icon = " ", hi = "TelescopeResultConstant" },
	["field"] = { icon = " ", hi = "TelescopeResultField" },
	["property"] = { icon = " ", hi = "TelescopeResultField" },
}

local displayer = entry_display.create({
	separator = " ",
	items = {
		{ width = 2 },
		{ width = nil },
		{ remaining = true },
	},
})

function M.maker()
	local entry_maker = require("telescope.make_entry").gen_from_lsp_symbols({})
	return function(line)
		local originalEntryTable = entry_maker(line)
		originalEntryTable.display = function(entry)
			local kind_and_higr = symbol_to_icon_map[entry.symbol_type:lower()]
				or { icon = " ", hi = "TelescopeResultsNormal" }
			local dot_idx = entry.symbol_name:reverse():find("%.") or entry.symbol_name:reverse():find("::")
			local symbol, qualifiier

			if dot_idx == nil then
				symbol = entry.symbol_name
				qualifiier = require("telescope.utils").transform_path({}, entry.filename)
			else
				symbol = entry.symbol_name:sub(1 - dot_idx)
				qualifiier = entry.symbol_name:sub(1, #entry.symbol_name - #symbol - 1)
			end

			return displayer({
				{ kind_and_higr.icon, kind_and_higr.hi },
				{ symbol },
				{ qualifiier, "TelescopeResultsComment" },
			})
		end

		return originalEntryTable
	end
end

return M
