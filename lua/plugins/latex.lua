return {
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
  vim.g.vimtex_view_method = "general"
  vim.g.vimtex_compiler_method = "latexmk"
  -- Use Vimscript for complex configurations
  vim.cmd([[
    let g:vimtex_compiler_latexmk = {
      \ 'build_dir' : 'build',
      \ 'options' : [
      \   '-pdf',
      \   '-interaction=nonstopmode',
      \   '-synctex=1',
      \ ],
    \ }
  ]])
end,
}
