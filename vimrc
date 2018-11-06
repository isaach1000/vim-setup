silent! py3 pass

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'fatih/vim-go'
Plugin 'flazz/vim-colorschemes'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/a.vim'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
Plugin 'zig-lang/zig.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'jparise/vim-graphql'
Plugin 'elubow/cql-vim'
Plugin 'cespare/vim-toml'
Plugin 'wakatime/vim-wakatime'

call vundle#end()

syntax on

" Spellcheck
set spell spelllang=en_us

" Enable mouse
set mouse=a

" Filetype-dependent settings
filetype plugin indent on

" General settings
set shiftwidth=4
set tabstop=4
set expandtab
set smarttab autoindent
set backspace=indent,eol,start
set ruler
set number
set showcmd
set incsearch

" Custom leader key
let mapleader = "\\"

" Below gets rid of flash on error
set vb t_vb = ""

" Highlight matches
" set hlsearch

" Show trailing spaces
autocmd BufWinEnter * match ErrorMsg '\s\+$'

colorscheme evening

" 80 characters per line
set colorcolumn=81
hi ColorColumn ctermbg=1 guibg=Red

" Set working directory to directory of file
set autochdir

" Autocomplete behavior
set completeopt+=longest

" Completion should not search included files because takes too long
set complete-=i

" Wildcard behavior
set wildmode=longest,list
set wildmenu

" vim-airline settings
set laststatus=2
let g:airline_detect_paste = 1  " Show PASTE if in paste mode
let g:airline#extensions#tabline#enabled = 1  " Show airline for tabs too

" a.vim
let g:alternateNoDefaultAlternate = 1

" vim-easytags settings
" Where to look for tags files
set tags=~/.vimtags
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" Tagbar settings
" Open/close tagbar with \b
nnoremap <silent> <leader>b :TagbarToggle<CR>

" Go tags
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

" Zig tags
let g:tagbar_type_zig = {
	\ 'ctagstype' : 'zig',
	\ 'kinds'     : [
		\ 's:structs',
		\ 'u:unions',
		\ 'e:enums',
		\ 'v:variables',
		\ 'm:members',
        \ 'f:functions',
        \ 'r:errors'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 'e' : 'enum',
		\ 'u' : 'union',
		\ 's' : 'struct',
        \ 'r' : 'error'
	\ },
	\ 'scope2kind' : {
		\ 'enum' : 'e',
		\ 'union' : 'u',
		\ 'struct' : 's',
		\ 'error' : 'r'
	\ },
	\ 'ctagsbin'  : '~/proj/zig/ztags/zig-cache/ztags',
	\ 'ctagsargs' : ''
\ }

" clang-format
if has('gui_macvim')
    let g:clang_format_path="/usr/local/opt/clang-format/bin/clang-format"
else
    let g:clang_format_path="/usr/bin/clang-format"
endif
function FormatFile()
  let l:lines="all"
  py3file ~/proj/config/vim-setup/vimpy/clang-format.py
endfunction
autocmd BufWritePre *.h,*.c,*.cpp,*.proto call FormatFile()

" clang-rename
let g:clang_rename_path="/usr/lib/llvm-7/bin/clang-rename"
function Rename()
  py3file ~/proj/config/vim-setup/vimpy/clang-rename.py
endfunction

" vim-easytags settings
" Where to look for tags files
set tags=~/.vimtags
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" YouCompleteMe settings
let g:ycm_extra_conf_globlist = ['~/proj/*']
let g:ycm_server_python_interpreter = 'python3'
let g:ycm_python_binary_path = 'python3'

" ack.vim
let g:ackprg = 'ag --nogroup --nocolor --column'

" vim-localvimrc
let g:localvimrc_whitelist=['/home/ihier/proj', '/Users/isaachier/proj/']

" nerdcommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

" Disable gocode proposals from source.
let g:go_gocode_propose_source = 0

if has('gui_macvim')
	highlight Cursor guifg=white guibg=steelblue
    highlight iCursor guifg=white guibg=steelblue
	set guicursor=n-v-c:block-Cursor
	set guicursor+=i:ver100-iCursor
endif
