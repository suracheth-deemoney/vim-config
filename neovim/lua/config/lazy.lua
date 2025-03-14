-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- import your plugins
		{ "nvim-lualine/lualine.nvim",        dependencies = { 'nvim-tree/nvim-web-devicons' } },
		{ "nvim-telescope/telescope.nvim",    opts = { dependencies = { "nvim-lua/plenary.nvim" } } },
		{ "nvim-treesitter/nvim-treesitter",  opts = { build = ":TSUpdate" } },
		{ "numToStr/Comment.nvim",            opts = {} },
		{ "lambdalisue/vim-fern" },
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/nvim-cmp" },
		{ "ms-jpq/coq_nvim" },
		{ "tpope/vim-fugitive" },
		{ "lewis6991/gitsigns.nvim" },
		{ "lukas-reineke/lsp-format.nvim" },
		{ "rose-pine/neovim",                 name = "rose-pine" },
		{ "andymass/vim-matchup"},
		{ "chentoast/marks.nvim", event = "VeryLazy", opts = {}},
		{ "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {}}

	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	-- install = { colorscheme = { "habamax" } },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
