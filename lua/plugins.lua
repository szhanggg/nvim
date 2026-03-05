vim.pack.add({
    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1") },
})

require('blink.cmp').setup({
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    signature = { enabled = true },
    keymap = {
        preset = "default",
        ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-n>"] = { "select_and_accept" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_down", "fallback" },
        ["<C-f>"] = { "scroll_documentation_up", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
        -- ["<C-e>"] = { "hide" },
    },

    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
    },

    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        }
    },

    cmdline = {
        keymap = {
            preset = 'inherit',
            ['<CR>'] = { 'accept_and_enter', 'fallback' },
        },
    },

    sources = { default = { "lsp" } }
})

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
            ["default"] = function(selected, opts)
                local entry = selected[1]
                if entry:match("^oil%-ssh://") then
                    require("oil").open(entry)
                else
                    fzf.actions.file_edit(selected, opts)
                end
            end,
        }
    },
    oldfiles = {
        stat_file = false,
    }
})

vim.pack.add{"https://github.com/NeogitOrg/neogit"}

vim.pack.add{"https://github.com/nvim-lualine/lualine.nvim"}

require("lualine").setup({})

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

vim.pack.add{"https://github.com/vyfor/cord.nvim"}
