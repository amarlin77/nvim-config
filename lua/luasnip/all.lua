return {
  s({trig = "helloworld", snippetType="snippet", desc="A hello world snippet", wordTrig = true},
    {t("Just a hint of what's to come"),}
  ),
  s({trig = "keymap", snippetType="snippet", desc="vim keymap snippet"},
    fmta(
      [[
      vim.keymap.set("<>", "<>", function() <> end, opts)
      ]],
      { i(1, "Mode"),
        i(2, "mapping"),
        i(3, "function call")}
    )
  ),
}

