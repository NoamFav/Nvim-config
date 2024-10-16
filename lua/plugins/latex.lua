return {
    {
        'lervag/vimtex',
        config = function()
            -- Vimtex settings
            vim.g.vimtex_view_method = 'skim'  -- Choose your PDF viewer (zathura, skim, etc.)
            vim.g.vimtex_compiler_method = 'latexmk' -- Auto compile using latexmk
            vim.g.vimtex_compiler_latexmk = {
                build_dir = 'build',
                continuous = 1,
                options = {
                    '-pdf',
                    '-shell-escape',
                    '-verbose',
                    '-file-line-error',
                    '-synctex=1',
                    '-interaction=nonstopmode'
                },
            }

            -- Optionally disable conceal feature if it gets in the way
            vim.g.vimtex_syntax_conceal = 0
        end,
    }
}
