set termguicolors         " Enable true color support
set t_ZH=[3m             " Enable italics
set t_ZR=[23m            " Disable italics

let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
let g:sonokai_better_performance = 1

colorscheme sonokai

let g:copilot_enabled = v:true
" Trigger completion
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")

" Use <C-K> to dismiss a suggestion
imap <silent><script><expr> <C-K> copilot#Dismiss()

" buffers
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <leader>bd :bdelete<CR>

nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprev<CR>
nnoremap <leader>to :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>

" QuickAction setup
nnoremap <leader>ca :CodeActionMenu<CR>

" Map <leader>pd to Page Down
nnoremap <leader>pd <PageDown>

" Map <leader>pu to Page Up
nnoremap <leader>pu <PageUp>

" Rename
nnoremap <leader>rn :Lspsaga rename<CR>

" Hover Documentation
nnoremap K :Lspsaga hover_doc<CR>

" nnoremap <leader>ca :lua vim.lsp.buf.code_action()<CR>

" Go to next diagnostic
nnoremap <leader>dn :lua vim.diagnostic.goto_next()<CR>

" Go to previous diagnostic
nnoremap <leader>dp :lua vim.diagnostic.goto_prev()<CR>

" Format the current buffer
nnoremap <leader>df :lua vim.lsp.buf.format()<CR>

" Show quick fix/code action options
nnoremap <leader>qf :lua vim.lsp.buf.code_action()<CR>

" Show diagnostics
nnoremap <leader>xx :Trouble diagnostics toggle<CR>
nnoremap <leader>xX :Trouble diagnostics toggle filter.buf=0<CR>
nnoremap <leader>cs :Trouble symbols toggle<CR>
nnoremap <leader>cc :Trouble close<CR>
nnoremap <leader>cl :Trouble lsp toggle focus=false win.position=right<CR>
nnoremap <leader>xL :Trouble loclist toggle<CR>
nnoremap <leader>xQ :Trouble qflist toggle<CR>

" Toggle NvimTree
nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>r :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>
nnoremap <leader>c :NvimTree

"Telescope setup
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fg :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>
nnoremap <leader>gf :Telescope git_files<CR>
nnoremap <leader>gs :Telescope grep_string<CR>
nnoremap <leader>fe :Telescope file_browser<CR>

" Maven shortcuts
nnoremap <leader>mm :!mvn clean install<CR>
nnoremap <leader>mp :!mvn clean package<CR>
nnoremap <leader>mc :!mvn clean<CR>
nnoremap <leader>mt :!mvn test<CR>
nnoremap <leader>me :!mvn exec:exec<CR>
nnoremap <leader>mf :!mvn javafx:run<CR>
nnoremap <leader>mj :!mvn javadoc:javadoc<CR>

nnoremap <Leader>s :SemanticHighlightToggle<cr>

" Toggle Tagbar
nnoremap <leader>tf :lua ToggleTagbarFocus()<CR>
let g:tagbar_autofocus = 1

" Tagbar configs
nnoremap <leader>tt :TagbarToggle<CR>:wincmd l<CR>

lua require("toggleterm").setup{}

nnoremap <C-t> :ToggleTerm<CR>

nnoremap <leader>rm :w<CR>:!matlab -nodisplay -nosplash -nodesktop -r "run('%:p'), exit"<CR>

" Open ai inline 
nnoremap <leader>ai :ChatGPT<CR>
nnoremap <leader>ac :ChatGPTCompleteCode<CR>
nnoremap <leader>ae :ChatGPTEditWithInstruction<CR>

" Basic Settings
set number
set relativenumber
set noswapfile
set nobackup
set nowritebackup
set updatetime=300
set termguicolors
set tabstop=4
set shiftwidth=4
set expandtab
set ignorecase
set smartcase

" Enable mouse support
set mouse=a
