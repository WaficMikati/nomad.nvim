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

    -- Enable inline diagnostics with virtual text
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●", -- Icon for diagnostics
        source = "always", -- Show source (e.g., ts_ls, cssls)
        format = function(diagnostic)
          return string.format("%s: %s", diagnostic.source, diagnostic.message)
        end,
      },
      signs = true, -- Keep sign column
      update_in_insert = false, -- Avoid updates during typing
      severity_sort = true, -- Prioritize errors
    })

    local lspconfig = require("lspconfig")
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    lspconfig.html.setup({ capabilities = capabilities })
    lspconfig.cssls.setup({ capabilities = capabilities })
    lspconfig.ts_ls.setup({
      capabilities = capabilities,
      init_options = {
        preferences = {
          importModuleSpecifierPreference = "non-relative",
          includeCompletionsForModuleExports = true,
          includeAutomaticOptionalChainCompletions = true,
          providePrefixAndSuffixTextForRename = true,
        },
      },
      filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
      settings = {
        completions = {
          completeFunctionCalls = true,
        },
      },
    })
  end
}
