-- vim.opt.runtimepath:append(vim.fn.stdpath('config') .. '/nomadvim')
vim.g.cmp_enabled = true
vim.g.snippets_enabled = true
vim.g.autopairs_enabled = true
vim.g.diagnostics_virtual_text_enabled = true

require("nomadvim.config.options")
require("nomadvim.config.keymaps")
require("nomadvim.config.lazy")

require('nomadvim.plugins.nvim-treesitter')
require('nomadvim.plugins.colorschemes')
require('nomadvim.plugins.nvim-lspconfig')
