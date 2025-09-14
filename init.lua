local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.wo.relativenumber = true
vim.wo.cursorline = true

local mygroup = vim.api.nvim_create_augroup('vimrc', { clear = true })
vim.api.nvim_create_autocmd({'BufWinLeave'}, {
    pattern = {'*.*'},
    group = mygroup,
    command = 'mkview | filetype detect',
})
vim.api.nvim_create_autocmd({'BufWinEnter'}, {
    pattern = {'*.*'},
    group = mygroup,
    command = 'silent! loadview | filetype detect',
})


require("vim-options")
require("lazy").setup("plugins")
