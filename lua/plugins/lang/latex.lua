return {
	"lervag/vimtex",
	lazy = false,
	ft = { "tex", "latex" },
	init = function()
		vim.g.vimtex_view_method = "general"
		vim.g.vimtex_compiler_method = "latexmk"
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
