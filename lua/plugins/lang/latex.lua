return {
	"lervag/vimtex",
	lazy = false, -- vimtex does its own lazy-loading, fighting lazy.nvim over it breaks things
	ft = { "tex", "latex" },
	init = function()
		vim.g.vimtex_view_method = "general" -- whatever xdg-open/open hands it to, no Skim/Zathura-specific setup
		vim.g.vimtex_compiler_method = "latexmk"
		-- build_dir below keeps the .aux/.log spam out of the project root
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
