-- ~/.config/nvim/lua/plugins/lspconfig.lua
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },

  config = function()
    local cmp = require('cmp')
    local cmp_lsp = require('cmp_nvim_lsp')
    local lspconfig = require('lspconfig')
    local util = lspconfig.util

    -- Enhance LSP capabilities for nvim-cmp
    local capabilities = vim.tbl_deep_extend(
      'force',
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    -- Mason setup
    require('fidget').setup({})
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls' },
      handlers = {
        -- 1. Custom rust_analyzer handler with fallback root_dir
        ['rust_analyzer'] = function()
          lspconfig.rust_analyzer.setup {
            capabilities = capabilities,
            root_dir = function(fname)
              -- look for Cargo.toml, then git root, else fallback to file's dir
              return util.root_pattern('Cargo.toml')(fname)
                  or util.find_git_ancestor(fname)
                  or util.path.dirname(fname)
            end,
            single_file_support = true,
            settings = {
              ["rust-analyzer"] = {
              },
            },
          }
        end,

        -- 2. Default handler for other servers
        function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
          }
        end,
      },
    })

    -- nvim-cmp setup
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    cmp.setup {
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
        end,
      },
      window = {
        completion = cmp.config.window.bordered({ -- completion popup
          border = "rounded",                     -- can be 'single', 'double', 'rounded', 'solid', 'shadow', or custom table
          --          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
        documentation = cmp.config.window.bordered({ -- documentation popup
          border = "rounded",
          --         winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
      }, {
        { name = 'buffer' },
      }),
    }

    -- Diagnostics configuration
    vim.diagnostic.config {
      underline = true,
      virtual_text = true,
      signs = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = 'minimal',
        border = 'single',
        source = 'always',
        header = '',
        prefix = '',
      },
    }
    local mason_root = require("mason.settings").current.install_root_dir
    vim.lsp.config("roslyn", {})
  end,
}
