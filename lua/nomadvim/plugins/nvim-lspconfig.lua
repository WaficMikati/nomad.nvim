return {
    -- nvim-lspconfig
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- mason.nvim and mason-lspconfig.nvim for managing LSP servers
            {"williamboman/mason.nvim"},
            {"williamboman/mason-lspconfig.nvim"}
        },
        config = function()
            -- Set up mason.nvim
            require("mason").setup() -- Set up mason-lspconfig to automatically install LSP servers
            require("mason-lspconfig").setup(
                {
                    ensure_installed = {"html", "cssls", "ts_ls"} -- Servers for HTML, CSS, JS/JSX
                }
            ) -- Configure LSP servers
            local lspconfig = require("lspconfig")
            -- HTML LSP
            lspconfig.html.setup({})
            -- CSS LSP
            lspconfig.cssls.setup({})
            -- TypeScript/JavaScript/JSX LSP
            lspconfig.ts_ls.setup(
                {
                    init_options = {preferences = {importModuleSpecifierPreference = "non-relative"}},
                    filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"}
                }
            )
        end
    }
}

