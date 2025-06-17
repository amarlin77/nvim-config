return {
  {
    "hrsh7th/cmp-nvim-lsp"
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    event = "InsertEnter",
    config = function()
      require("luasnip.loaders.from_lua").lazy_load({paths = "./lua/luasnip/"})
      local ls = require("luasnip")
      ls.setup({
        update_events = {"TextChanged", "TextChangedI"},
        enable_autosnippets = true,
        store_selection_keys = "<Tab>",
      })
      vim.keymap.set({"i"}, "<C-k>", function() ls.expand() end, {silent = true, desc = "expand autocomplete"})
      vim.keymap.set({"i", "s"}, "<C-j>", function() ls.jump( 1) end, {silent = true, desc = "next autocomplete"})
      vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump(-1) end, {silent = true, desc = "previous autocomplete"})
      vim.keymap.set({"i", "s"}, "<C-E>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, {silent = true, desc = "select autocomplete"})
    end,
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "micangl/cmp-vimtex",
    ft = "tex",
    config = function()
      require('cmp_vimtex').setup({})
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",--autocomplete on the buffer
      "hrsh7th/cmp-path",--autocomplete path variables
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",--autocomplete from luasnip
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local luasnip = require("luasnip")
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({
                  select = false,
                })
              end
            else
              fallback()
            end
          end),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if #cmp.get_entries() == 1 then
                cmp.confirm({select =true})
              else
                cmp.select_next_item()
              end
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          -- ["<Esc>"] = cmp.mapping.abort(),
        }),      
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
          { name = "buffer" },
        }),
      })
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
      sources = {
          {name = 'buffer'}
        }
      })
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path', option = {trailing_slash = true}, }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
      cmp.setup.filetype("tex", {
        sources = {
          { name = 'vimtex'},
          { name = 'luasnip' },
          { name = 'buffer' },
        },
      })
    end
  }
}
