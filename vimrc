" ~/.vim/vimrc
" Tim Hammerquist <penryu@gmail.com>

" Set mapleaders; must be set before plugins are loaded to take effect
let mapleader = ","
let maplocalleader = "\\"

source ~/.vim/util.vim
source ~/.vim/pluginit.vim

" backupcopy=yes when file change detection doesn't work
set nobackup backupcopy=yes nowritebackup
set clipboard+=unnamed
set cmdheight=2
set colorcolumn=81,+1
set cursorline
set directory=.
set expandtab
set nohlsearch
set ignorecase
set linebreak
set number
set scrolloff=3
set shiftwidth=2
set shortmess=acotI
set sidescrolloff=21
set softtabstop=2
set splitbelow splitright
set termguicolors
set terse
set textwidth=80
set timeout nottimeout timeoutlen=300 ttimeoutlen=10
set updatetime=300
set viminfo='7,r/Volumes,r/media,r/mnt,r/tmp

function! LocalHighlights() abort
    highlight Comment guifg=#888888
endfunction
autocmd ColorScheme apprentice call LocalHighlights()
colorscheme apprentice

autocmd! FileType mail      setl textwidth=69
autocmd! FileType markdown  setl spell
autocmd! FileType perl      setl shiftwidth=4 softtabstop=4
autocmd! FileType python    setl shiftwidth=4 softtabstop=4 textwidth=79
autocmd! FileType tex       setl spell

" Check for changes to files outside of Vim
" https://unix.stackexchange.com/a/383044
autocmd! FocusGained,BufEnter,CursorHold,CursorHoldI *
      \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
autocmd! FileChangedShellPost *
      \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" add color column (margin indicator) only if modifiable
function! ModifiableHook()
    if !&modifiable
        set colorcolumn&
        set nonumber
    endif
endfunction
autocmd! BufEnter * call ModifiableHook()

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

cabbr <expr> %% expand('%:p:h')

command Tabn tab split | next

call SourceIfExist("~/.vim/vimrc.local")
