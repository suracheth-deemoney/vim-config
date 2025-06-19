-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
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
    -- Import your plugins
    { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
    { "nvim-telescope/telescope.nvim", opts = { dependencies = { "nvim-lua/plenary.nvim" } } },
    { "nvim-treesitter/nvim-treesitter", opts = { build = ":TSUpdate" } },
    { "numToStr/Comment.nvim", opts = {} },
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
    { "andymass/vim-matchup" },
    { "chentoast/marks.nvim", event = "VeryLazy", opts = {} },
    { "EdenEast/nightfox.nvim" },
    { "vague2k/vague.nvim" },
    { "zapling/mason-lock.nvim" },

    -- Avante
    {
      "yetone/avante.nvim",
      build = "make", -- ⚠️ must add this line!
      -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
      event = "VeryLazy",
      version = false, -- Never set this value to "*"! Never!
      ---@module 'avante'
      ---@type avante.Config
      opts = {
        -- add any opts here
        provider = "claude",
      },
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",

        -- Optional dependencies
        "echasnovski/mini.pick", -- file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        -- "ibhagwan/fzf-lua", -- file_selector provider fzf
        "stevearc/dressing.nvim", -- input provider dressing
        -- "folke/snacks.nvim", -- input provider snacks
        -- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        -- "zbirenbaum/copilot.lua", -- providers='copilot'

        -- Support for image pasting
        {
          "HakonHarnes/img-clip.nvim",
          event = "VeryLazy",
          opts = {
            -- recommended settings
            default = {
              embed_image_as_base64 = false,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
              -- required for Windows users
              use_absolute_path = true,
            },
          },
        },

        -- Render markdown
        {
          "MeanderingProgrammer/render-markdown.nvim",
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        },
      },
    },
  },

  -- Other settings (see documentation for details)
  -- install = { colorscheme = { "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
})

