  -- Syntax Highlighting & Language Support (Treesitter)
return { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate',
ensure_installed = "all",
highlight = {
	enable = true,
},
fold = {
    enable = true,
    config = function()
        vim.cmd('set foldmethod=expr')
        vim.cmd('set foldexpr=nvim_treesitter#foldexpr()')
        vim.o.foldlevel = 99 -- Automatically unfold everything on startup
    end
}
