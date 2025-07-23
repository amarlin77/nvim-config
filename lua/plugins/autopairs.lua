return {
  {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = function()
    local autopairs = require('nvim-autopairs')

    -- This calls the setup function with default options
    autopairs.setup({})

    local Rule = require('nvim-autopairs.rule')

    -- CORRECT: Pass a flat table of Rule objects
    autopairs.add_rules({
      -- Rule("$$", "$$", "tex")
      --   :with_move(function(opts)
      --     return opts.next_char == opts.char
      --   end),
      Rule("$", "$", "tex")
        :with_move(function(opts)
          return opts.next_char == opts.char
        end),
      -- You could add another Rule here with a comma, like:
      -- Rule("$$", "$$", "tex")
    })
  end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  }
}
