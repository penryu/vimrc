" ~/.vim/vimrc
" Tim Hammerquist <penryu@gmail.com>

set nocompatible

set autoindent
set autoread
set autowrite
set background=dark
set backspace=eol,indent,start
set backupcopy=auto
set cmdheight=2
set colorcolumn=81,+1
set noconfirm
set display=uhex
set errorbells
set expandtab
set fileformats=unix,dos
set foldlevel=20 foldlevelstart=20
set foldmethod=indent
set nohlsearch
set ignorecase
set incsearch
set laststatus=2
set linebreak
set modeline modelines=3
set nonumber
set pumheight=7
set ruler
set scrolloff=3
set shiftwidth=2
set shortmess=aotI
set sidescroll=1
set sidescrolloff=21
set nosmartindent
set nosmarttab
set softtabstop=2
set splitbelow
set terse
set textwidth=72
set timeout nottimeout timeoutlen=1000 ttimeoutlen=100
set viminfo='7,r/Volumes,r/media,r/mnt,r/tmp
set virtualedit=block
set visualbell
set wildmenu


if has("syntax")
  syntax on
  if &t_Co > 2 || has("gui_running")
    if &t_Co >= 256
      colorscheme apprentice
    else
      colorscheme apprentice
    endif
  endif
endif

if has('autocmd')
  function! ResizeHook()
    let l:numbered_cols = 80 + &numberwidth
    if &columns >= l:numbered_cols
      set number
    else
      set nonumber
    endif
  endf
  "autocmd! VimEnter   * call ResizeHook()
  "autocmd! VimResized * call ResizeHook()

  filetype plugin indent on

  "" filetype settings
  autocmd! FileType c         setl sts=8 sw=8 noexpandtab
  autocmd! FileType gitcommit setl tw=72
  autocmd! FileType java      setl sts=4 sw=4
  autocmd! FileType mail      setl sts=4 sw=4 tw=70 com+=n:> noml
  autocmd! FileType perl      setl sts=4 sw=4
  autocmd! FileType python    setl sts=4 sw=4
  autocmd! FileType python    map <buffer> <Leader>f :call Flake8()<CR>

endif


command! XMLTidy %!tidy -q -i -xml
command! XMLLint %!xmllint --format - 2>&1

"let mapleader = "\\"
let mapleader = ","
" Y yanks to EOL, like C/D
nmap Y y$
" navigate open windows
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
" open prev/next buffer
nmap <C-p> :bprevious<CR>
nmap <C-n> :bnext<CR>

map       <C-v> "+gP
cmap      <C-v> <C-r>+
vnoremap  <C-c> "+y

" map to open file under cursor in new window
"map gf <C-W>f
" map to go to def of instance, then open file in new win
"map gc gdb<C-W>f
" Don't use Ex mode, use Q for formatting; see user_05.txt
"nmap Q gq
" execute current line as command-mode command; ex: :r ~/.signature
"nmap <silent> <F3> yy:execute @"<CR>
" Make p in Visual mode replace the selected text with the "" register.
"vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

cabbr <expr> %% expand('%:p:h')

call plug#begin('~/.vim/plugs')
  Plug 'jlanzarotta/bufexplorer'
    let g:bufExplorerSortBy='name'
    let g:bufExplorerSplitType=''
  Plug 'vim-airline/vim-airline'
    let g:airline_powerline_fonts=1
    let g:airline_skip_empty_sections=1
    let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
  Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme='distinguished'

  " clojure
  "Plug 'Olical/conjure', { 'tag': 'v1.3.0', 'do': 'bin/compile'  }
  Plug 'vim-scripts/paredit.vim'
    let g:paredit_smartjump = 1
  Plug 'tpope/vim-fireplace'
  " git
  Plug 'tpope/vim-fugitive'
  " go
  Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
    au FileType go call PareditInitBuffer()
  " js
  Plug 'pangloss/vim-javascript'
    let g:javascript_plugin_jsdoc = 1
  Plug 'elzr/vim-json'
  " nginx
  Plug 'chr4/nginx.vim'
  " plist
  Plug 'darfink/vim-plist'
    let g:plist_display_format = 'json'
    let g:plist_json_filetype = 'json'
  " rust
  Plug 'rust-lang/rust.vim'
call plug#end()

" highlights matching parens
runtime macros/matchit.vim
" load builtin manpage viewer
runtime ftplugin/man.vim

