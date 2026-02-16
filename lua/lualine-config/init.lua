local M = require("lualine.component"):extend()

M.processing = false
M.spinner_index = 1

local spinner_symbols = {
	"⠋",
	"⠙",
	"⠹",
	"⠸",
	"⠼",
	"⠴",
	"⠦",
	"⠧",
	"⠇",
	"⠏",
}
local spinner_symbols_len = 10

-- Initializer
function M:init(options)
	M.super.init(self, options)

	local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

	vim.api.nvim_create_autocmd({ "User" }, {
		pattern = "CodeCompanionRequest*",
		group = group,
		callback = function(request)
			if request.match == "CodeCompanionRequestStarted" then
				self.processing = true
			elseif request.match == "CodeCompanionRequestFinished" then
				self.processing = false
			end
		end,
	})
end

-- Function that runs every time statusline is updated
function M:update_status()
	if self.processing then
		self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
		return spinner_symbols[self.spinner_index]
	else
		return nil
	end
end

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		-- component_separators = { left = "", right = "" },
		component_separators = "",
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			"dashboard",
		},
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = {
			M,
			"filename",
			{
				function()
					local reg = vim.fn.reg_recording()
					if reg ~= "" then
						return "Recording @" .. reg
					end
					return ""
				end,
				color = { fg = "#e5c07b", gui = "bold" },
			},
		},
		lualine_x = {
			"lsp_status",
			"copilot",
			"fileformat",
			"filetype",
			{
				function()
					-- Check if MCPHub is loaded
					if not vim.g.loaded_mcphub then
						return "󰐻 -"
					end

					local count = vim.g.mcphub_servers_count or 0
					local status = vim.g.mcphub_status or "stopped"
					local executing = vim.g.mcphub_executing

					-- Show "-" when stopped
					if status == "stopped" then
						return "󰐻 -"
					end

					-- Show spinner when executing, starting, or restarting
					if executing or status == "starting" or status == "restarting" then
						local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
						local frame = math.floor(vim.loop.now() / 100) % #frames + 1
						return "󰐻 " .. frames[frame]
					end

					return "󰐻 " .. count
				end,
				color = function()
					if not vim.g.loaded_mcphub then
						return { fg = "#6c7086" } -- Gray for not loaded
					end

					local status = vim.g.mcphub_status or "stopped"
					if status == "ready" or status == "restarted" then
						return { fg = "#50fa7b" } -- Green for connected
					elseif status == "starting" or status == "restarting" then
						return { fg = "#ffb86c" } -- Orange for connecting
					else
						return { fg = "#ff5555" } -- Red for error/stopped
					end
				end,
			},
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = { "nvim-tree", "trouble", "mason", "toggleterm", "nvim-dap-ui", "avante", "fzf" },
})
