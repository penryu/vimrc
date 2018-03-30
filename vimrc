" ~/.vim/vimrc
" Tim Hammerquist <penryu@gmail.com>

"""""
" options
"
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
set ignorecase
set incsearch
set laststatus=2
set linebreak
set modeline
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
set suffixes=.ps,.swp
set tabstop=8
set tags=.tags,tags
set terse
set textwidth=72
set timeout nottimeout timeoutlen=1000 ttimeoutlen=100
set viminfo='10,/10,:30,f0,r/Volumes,r/tmp
set virtualedit=block
set visualbell
set wildchar=<Tab>
set wildignore=.a,.dvi,.ps,.so,.tar
set wildmenu
set nowrap


"""""
" more config
"
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
  autocmd! VimEnter   * call ResizeHook()
  autocmd! VimResized * call ResizeHook()
endif

if has('autocmd')
  filetype plugin indent on

  "" filetype settings
  autocmd! FileType c         setl sw=8 sts=8 ts=8 noexpandtab
  autocmd! FileType gitcommit setl tw=72
  autocmd! FileType help      setl nonu ss=0 siso=0
  autocmd! FileType java      setl sw=2 sts=2 cpt=],i fdl=20 fdm=indent
      \ inc=^\s*import inex=substitute(v:fname,'\\.','/','g') pa+=src/**
  autocmd! FileType mail      setl sw=2 sts=2 tw=70 com+=n:> fo+=tcql lbr noml wrap
  autocmd! FileType man       setl nonu ss=0 siso=0
  autocmd! FileType perl      setl sw=4 sts=4
  autocmd! FileType python    setl sw=4 sts=4 ts=4 expandtab fdm=indent
  autocmd! FileType python    map <buffer> <Leader>f :call Flake8()<CR>
  autocmd! FileType ruby      setl sw=2 sts=2 fdm=indent
  autocmd! FileType xml       setl sw=2 sts=2 ts=2 expandtab

endif


"""""
" commands/maps/abbreviations
"

" pretty-print xml file
command! XMLTidy %!tidy -q -i -xml
command! XMLLint %!xmllint --format - 2>&1
" convert binary plist to xml
command! PLXml %!plutil -convert xml1 -o - %

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


"""""
" vim-plug
call plug#begin('~/.vim/plugs')
" bufexplorer
Plug 'jlanzarotta/bufexplorer'
" nginx
Plug 'chr4/nginx.vim'
" plist
Plug 'darfink/vim-plist'
call plug#end()

" highlights matching parens
packadd matchit

" load builtin manpage viewer
runtime ftplugin/man.vim
" local
"
"""""
" plugin config
"
" bufexplorer.vim
let g:bufExplorerSortBy='name'        " sort by buffer name
let g:bufExplorerSplitType=''         " split bufexplorer ('' or 'v')


"""""
" local configuration from ~/.vim/local/*.vim
"
runtime! local/*.vim
