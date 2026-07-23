" ============================================================================
" nvim-42 — bare-Vim fallback (.vimrc)
" ----------------------------------------------------------------------------
" For the 42 cluster / any box where you only have plain `vim` and can't
" install plugins. No dependencies, no plugin manager — just sane defaults,
" the 42 C style, and a byte-correct 42 header (`<F1>`) that passes the Norm.
"
"   Install:  cp vimrc ~/.vimrc      (or: curl ... > ~/.vimrc)
"   Identity: export USER / MAIL in your shell so the header is *yours*.
" ============================================================================

set nocompatible
filetype plugin indent on
syntax on

" --- General -----------------------------------------------------------------
set encoding=utf-8
set number
set relativenumber
set ruler
set showcmd
set showmatch
set wildmenu
set laststatus=2
set mouse=a
set hidden
set scrolloff=8
set backspace=indent,eol,start
set clipboard=unnamed

" --- Search ------------------------------------------------------------------
set ignorecase
set smartcase
set incsearch
set hlsearch

" --- 42 C style: TABS, width 4 (the Norm requires tabs, not spaces) ----------
set tabstop=4
set shiftwidth=4
set noexpandtab
set autoindent
set smartindent

" Makefiles must keep real tabs on recipe lines.
autocmd FileType make setlocal noexpandtab

" Flag Norm-unfriendly bits: trailing whitespace + a column-80 marker.
set list
set listchars=tab:\ \ ,trail:·,nbsp:+
highlight ColorColumn ctermbg=236
set colorcolumn=80

" --- Leader + quick mappings -------------------------------------------------
let mapleader = " "
" clear search highlight
nnoremap <leader>h :nohlsearch<CR>
" build / norm from inside vim (needs make / norminette on $PATH)
nnoremap <leader>mm :!make<CR>
nnoremap <leader>mr :!make re<CR>
nnoremap <leader>mc :!make clean<CR>
nnoremap <leader>mn :!norminette %<CR>
nnoremap <leader>mb :!cc -Wall -Wextra -Werror % && ./a.out<CR>

" ============================================================================
" 42 HEADER  —  faithful port of the official Stdheader algorithm.
" Produces a byte-identical 80-column header, so norminette accepts it.
"   <F1>  or  :Stdheader   inserts (or, if present, is refreshed on save)
" ============================================================================

let s:asciiart = [
	\"        :::      ::::::::",
	\"      :+:      :+:    :+:",
	\"    +:+ +:+         +:+  ",
	\"  +#+  +:+       +#+     ",
	\"+#+#+#+#+#+   +#+        ",
	\"     #+#    #+#          ",
	\"    ###   ########.fr    " ]

let s:start  = '/*'
let s:end    = '*/'
let s:fill   = '*'
let s:length = 80
let s:margin = 5

function! s:Filename()
	let l:fn = expand("%:t")
	if strlen(l:fn) == 0
		let l:fn = "< new >"
	endif
	return l:fn
endfunction

function! s:User()
	let l:u = $USER
	return strlen(l:u) ? l:u : "marvin"
endfunction

function! s:Mail()
	let l:m = $MAIL
	return strlen(l:m) ? l:m : s:User() . "@student.42.fr"
endfunction

function! s:Textline(left, right)
	let l:left = strpart(a:left, 0, s:length - s:margin * 2 - strlen(a:right))
	return s:start
		\ . repeat(' ', s:margin - strlen(s:start))
		\ . l:left
		\ . repeat(' ', s:length - s:margin * 2 - strlen(l:left) - strlen(a:right))
		\ . a:right
		\ . repeat(' ', s:margin - strlen(s:end))
		\ . s:end
endfunction

function! s:Line(n)
	let l:d = strftime("%Y/%m/%d %H:%M:%S")
	if a:n == 0 || a:n == 10
		return s:start . ' ' . repeat(s:fill, s:length - 6) . ' ' . s:end
	elseif a:n == 1 || a:n == 9
		return s:Textline('', '')
	elseif a:n == 2
		return s:Textline('', s:asciiart[0])
	elseif a:n == 3
		return s:Textline(s:Filename(), s:asciiart[1])
	elseif a:n == 4
		return s:Textline('', s:asciiart[2])
	elseif a:n == 5
		return s:Textline('By: ' . s:User() . ' <' . s:Mail() . '>', s:asciiart[3])
	elseif a:n == 6
		return s:Textline('', s:asciiart[4])
	elseif a:n == 7
		return s:Textline('Created: ' . l:d . ' by ' . s:User(), s:asciiart[5])
	elseif a:n == 8
		return s:Textline('Updated: ' . l:d . ' by ' . s:User(), s:asciiart[6])
	endif
endfunction

" True if the buffer already starts with a 42 header.
function! s:HasHeader()
	return getline(1) =~ '^/\* \*\+ \*/$' && getline(11) =~ '^/\* \*\+ \*/$'
endfunction

function! s:Insert()
	let l:i = 0
	while l:i < 11
		call append(l:i, s:Line(l:i))
		let l:i += 1
	endwhile
	" blank line after the header for breathing room
	call append(11, '')
endfunction

" Refresh filename (line 4) + Updated (line 9) if a header is present.
function! s:Update()
	if s:HasHeader()
		call setline(4, s:Line(3))
		call setline(9, s:Line(8))
	endif
endfunction

function! Stdheader()
	if s:HasHeader()
		call s:Update()
	else
		call s:Insert()
	endif
endfunction

command! Stdheader call Stdheader()
nnoremap <F1> :Stdheader<CR>

" Keep the Updated line fresh on every save of a header'd file.
autocmd BufWritePre * call s:Update()
