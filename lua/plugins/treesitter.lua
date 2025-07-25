return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "vimdoc", "lua",
        },

        sync_install = false,

        auto_install = true,

        indent = {
          enable = true
        },

        highlight = {
          enable = true,
          disable = function(lang, buf)
            if lang == "html" then
              print("disabled")
              return true
            end
            if lang == "latex" then
              print("diabled")
              return true
            end

            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              vim.notify("File larger than 100KB treestiter disabled for performance",
                vim.log.level.WARN,
                {title = "Treesitter"}
              )
              return true
            end
          end,
          additional_vim_regex_highlighting = { "markdown" },
        },
      })
      local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      treesitter_parser_config.templ = {
        install_info = {
          url = "https://github.com/vrischmann/tree-sitter-templ.git",
          files = {"src/parser.c", "src/scanner.c"},
          branch = "master",
        },
      }

      vim.treesitter.language.register("templ","templ")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    after = "nvim-treesitter",
    config = function()
      require'treesitter-context'.setup{
        enable = true,
        multiwindow=false,
        max_lines = 0, 
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = 'outer',
        mode = 'cursor',

        separator = nil,
        zindex = 20,
        on_attach = nil,
      }
    end
  },
    config = function(_, opts)
      require'plugins/setup_systemverilog'.setupTreesitter(opts)
    end
}
