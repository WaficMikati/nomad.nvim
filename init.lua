-- vim.opt.runtimepath:append(vim.fn.stdpath('config') .. '/nomadvim')

require("nomadvim.config.options")
require("nomadvim.config.keymaps")
require("nomadvim.config.lazy")

require('nomadvim.plugins.nvim-treesitter')
require('nomadvim.plugins.colorschemes')
require('nomadvim.plugins.nvim-lspconfig')
