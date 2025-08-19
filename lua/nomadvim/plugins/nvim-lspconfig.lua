return {
  "neovim/nvim-lspconfig",
  dependencies = {
    {"williamboman/mason.nvim"},
    {"williamboman/mason-lspconfig.nvim"}
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {"html", "cssls", "ts_ls"}
    })
    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities() -- Add this for nvim-cmp

    lspconfig.html.setup({ capabilities = capabilities })
    lspconfig.cssls.setup({ capabilities = capabilities })
    lspconfig.ts_ls.setup({
      capabilities = capabilities, -- Enable full LSP features
      init_options = { preferences = { importModuleSpecifierPreference = "non-relative" } },
      filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"}
    })
  end
}
