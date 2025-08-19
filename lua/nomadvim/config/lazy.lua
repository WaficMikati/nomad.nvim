-- Bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Set up Lazy.nvim
require('lazy').setup({
    -- Your plugins will be defined in plugins/*.lua
    { import = 'nomadvim.plugins' },
}, {
    checker = { enabled = true }, -- Auto-check for plugin updates
})
