return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" }, -- Removed opts, as cmp-path has no setup
      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
          {
            "rafamadriz/friendly-snippets",
            config = function()
              require("luasnip.loaders.from_vscode").lazy_load({
                include = { "javascriptreact", "typescriptreact" },
              })
              require("luasnip").filetype_extend("javascriptreact", { "react" })
              require("luasnip").filetype_extend("typescriptreact", { "react" })
            end,
          },
        },
      },
      { "saadparwaiz1/cmp_luasnip" },
      { "onsails/lspkind.nvim" },
      {
        "windwp/nvim-autopairs",
        config = function()
          local autopairs = require("nvim-autopairs")
          autopairs.setup({
            check_ts = true,
            ts_config = {
              javascript = { "jsx", "javascriptreact" },
              typescript = { "tsx", "typescriptreact" },
            },
          })
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          require("cmp").event:on(
            "confirm_done",
            cmp_autopairs.on_confirm_done()
          )
        end,
      },
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      cmp.setup({
        enabled = function()
          return vim.g.cmp_enabled ~= false
        end,
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Insert,
                  select = false,
                })
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm({ select = false }),
          }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 },
          { name = "luasnip", priority = 750, option = { show_autosnippets = true } },
          { name = "buffer", priority = 500 },
          {
            name = "path",
            priority = 250,
            option = {
              get_cwd = function()
                return vim.fn.getcwd() -- Use project root for path completions
              end,
            },
          },
        }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            preset = "codicons",
            maxwidth = 50,
            ellipsis_char = "...",
            before = function(entry, vim_item)
              if entry.source.name == "nvim_lsp" then
                vim_item.kind = vim_item.kind or "Text"
                vim_item.menu = string.format("[%s]", entry.source.name)
              end
              vim_item.dup = 0
              return vim_item
            end,
          }),
        },
        preselect = cmp.PreselectMode.None,
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" }, { name = "cmdline" } }),
      })
    end,
  },
  {
    "hrsh7th/cmp-cmdline",
    event = "CmdlineEnter",
  },
}
