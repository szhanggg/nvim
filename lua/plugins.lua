vim.pack.add{"https://github.com/neovim/nvim-lspconfig"}

vim.pack.add({
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/stevearc/oil.nvim" },
})

require("oil").setup({
    default_file_explorer = true,
    columns = {
        "icon",
    },
    delete_to_trash = true,
    view_options = {
        show_hidden = true,
    },
})

vim.pack.add{"https://github.com/NMAC427/guess-indent.nvim"}

require('guess-indent').setup({})

vim.pack.add{"https://github.com/rebelot/kanagawa.nvim"}

require("kanagawa").setup({
    transparent = true,
})

vim.cmd("colorscheme kanagawa-dragon")

vim.pack.add{"https://github.com/ibhagwan/fzf-lua"}

local actions = require('fzf-lua.actions')
local fzf = require("fzf-lua")

fzf.setup({
    winopts = { backdrop = 85 },
    keymap = {
        builtin = {
            ["<C-f>"] = "preview-page-down",
            ["<C-b>"] = "preview-page-up",
            ["<C-p>"] = "toggle-preview",
        },
        fzf = {
            ["ctrl-a"] = "toggle-all",
            ["ctrl-t"] = "first",
            ["ctrl-g"] = "last",
            ["ctrl-d"] = "half-page-down",
            ["ctrl-u"] = "half-page-up",
        }
    },
    actions = {
        files = {
            ["ctrl-q"]  = actions.file_sel_to_qf,
            ["ctrl-n"]  = actions.toggle_ignore,
            ["ctrl-h"]  = actions.toggle_hidden,
            ["enter"]   = actions.file_edit_or_qf,
        }
    },
    oldfiles = {
        stat_file = true,
    }
})

vim.pack.add{"https://github.com/NeogitOrg/neogit"}

vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" },
})

vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        version = "main",
        data = { after = "TSUpdate" },
    },
})
