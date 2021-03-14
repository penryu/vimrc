" ~/.vim/vimrc
" Tim Hammerquist <penryu@gmail.com>

set nocompatible

set autoindent
set autoread
set background=dark
set backspace=eol,indent,start
" if react doesn't detect changes, backupcopy=yes
set nobackup backupcopy=yes nowritebackup
set clipboard+=unnamed
set cmdheight=2
set colorcolumn=81,+1
set conceallevel=0
set noconfirm
set cursorline
set display=uhex
set errorbells
set expandtab
set fileformats=unix,dos
set foldlevelstart=20
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
set shortmess=acotI
set sidescroll=1
set sidescrolloff=21
set signcolumn=yes
set nosmartindent
set nosmarttab
set softtabstop=2
set splitbelow
set termguicolors
set terse
set textwidth=80
set timeout nottimeout timeoutlen=300 ttimeoutlen=10
set updatetime=300
set viminfo='7,r/Volumes,r/media,r/mnt,r/tmp
set virtualedit=block
set visualbell
set wildmenu

let mapleader = ","
let maplocalleader = "\\"

if has("syntax")
    syntax on
    if &t_Co > 2 || has("gui_running")
        if &t_Co >= 256
            colorscheme apprentice
        else
            colorscheme apprentice
        endif
    endif

    function! ToggleConcealLevel()
        if &conceallevel == 0
            setlocal conceallevel=2
        else
            setlocal conceallevel=0
        endif
    endfunction
    nnoremap <silent> <C-c><C-y> :call ToggleConcealLevel()<CR>

    syntax keyword pyStatement lambda conceal cchar=λ
endif

if has('autocmd')
    filetype plugin indent on

    "" filetype settings
    autocmd! FileType gitcommit   setl tw=72
    autocmd! FileType go          setl sts=0 sw=0 ts=4 noexpandtab
    autocmd! FileType javascript  setl sts=2 sw=2 ts=8
    autocmd! FileType mail        setl tw=70 com+=n:> noml
    autocmd! FileType markdown    setl spell
    autocmd! FileType perl        setl sts=4 sw=4 ep=perltidy\ -st

    " https://unix.stackexchange.com/a/383044
    autocmd! FocusGained,BufEnter,CursorHold,CursorHoldI *
          \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
    autocmd! FileChangedShellPost *
          \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

    " add color column (margin indicator) only if modifiable
    function! ModifiableHook()
        if !&modifiable
            set colorcolumn=""
        else
            set colorcolumn=81,+1
        endif
    endfunction
    autocmd! BufEnter * call ModifiableHook()

    " NERDTree init
    autocmd StdinReadPre * let s:std_in=1
    " Start NERDTree and put the cursor back in the other window.
    autocmd VimEnter * NERDTree | wincmd p
    " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
    autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
    " Exit Vim if NERDTree is the only window left.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
endif

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

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
    let g:NERDTreeWinSize=32
    nnoremap <Leader>N :NERDTreeToggle<CR>
    nnoremap <Leader>n :NERDTreeFocus<CR>

Plug 'majutsushi/tagbar'
    let g:tagbar_width=25
    nmap <Leader>t :TagbarToggle<CR>

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
    let g:airline_powerline_fonts=v:true
    let g:airline_skip_empty_sections=v:true
    let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
    let g:airline_theme='distinguished'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = ['coc-css', 'coc-html', 'coc-yaml']
    if v:true
        " coc stuff - seems to need a lot of crap
        " Use tab for trigger completion with characters ahead and navigate.
        " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
        inoremap <silent><expr> <TAB>
                    \ pumvisible() ? "\<C-n>" :
                    \ <SID>check_back_space() ? "\<TAB>" :
                    \ coc#refresh()
        inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
        function! s:check_back_space() abort
            let col = col('.') - 1
            return !col || getline('.')[col - 1]  =~# '\s'
        endfunction
        " Use <c-space> to trigger completion.
        inoremap <silent><expr> <c-space> coc#refresh()
        " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
        " Coc only does snippet and additional edit on confirm.
        inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
        " Or use `complete_info` if your vim support it, like:
        " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
        " Use `[g` and `]g` to navigate diagnostics
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)
        " Remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gy <Plug>(coc-type-definition)
        nmap <silent> gi <Plug>(coc-implementation)
        nmap <silent> gr <Plug>(coc-references)
        " Use K to show documentation in preview window
        nnoremap <silent> K :call <SID>show_documentation()<CR>
        function! s:show_documentation()
            if (index(['vim','help'], &filetype) >= 0)
                execute 'h '.expand('<cword>')
            else
                call CocAction('doHover')
            endif
        endfunction
        " Highlight symbol under cursor on CursorHold
        autocmd CursorHold * silent call CocActionAsync('highlight')
        " Remap for rename current word
        nmap <leader>rn <Plug>(coc-rename)
        " Remap for format selected region
        xmap <leader>f  <Plug>(coc-format-selected)
        nmap <leader>f  <Plug>(coc-format-selected)
        augroup mygroup
            autocmd!
            " Setup formatexpr specified filetype(s).
            autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
            " Update signature help on jump placeholder
            autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
        augroup end
        " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
        xmap <leader>a  <Plug>(coc-codeaction-selected)
        nmap <leader>a  <Plug>(coc-codeaction-selected)
        " Remap for do codeAction of current line
        nmap <leader>ac  <Plug>(coc-codeaction)
        " Fix autofix problem of current line
        nmap <leader>qf  <Plug>(coc-fix-current)
        " Create mappings for function text object, requires document symbols feature of languageserver.
        xmap if <Plug>(coc-funcobj-i)
        xmap af <Plug>(coc-funcobj-a)
        omap if <Plug>(coc-funcobj-i)
        omap af <Plug>(coc-funcobj-a)
        " Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
        nmap <silent> <TAB> <Plug>(coc-range-select)
        xmap <silent> <TAB> <Plug>(coc-range-select)
        " Use `:Format` to format current buffer
        command! -nargs=0 Format :call CocAction('format')
        " Use `:Fold` to fold current buffer
        command! -nargs=? Fold :call     CocAction('fold', <f-args>)
        " use `:OR` for organize import of current buffer
        command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
        " Add status line support, for integration with other plugin, checkout `:h coc-status`
        set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
        " Using CocList
        nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
        nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
        nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
        nnoremap <silent> <space>j  :<C-u>CocNext<CR>
        nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
        nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
        " Find symbol of current document
        nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
        " Search workspace symbols
        nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    endif

Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'dense-analysis/ale'
Plug 'inkarkat/vim-SyntaxRange'
Plug 'machakann/vim-sandwich'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-speeddating'
Plug 'vim-scripts/utl.vim'

" clojure
Plug 'radenling/vim-dispatch-neovim'
Plug 'clojure-vim/vim-jack-in'
Plug 'Olical/conjure', { 'tag': 'v4.15.0'}
    let g:ale_linters = {'clojure': ['clj-kondo']}
    call add(g:coc_global_extensions, 'coc-conjure')

Plug 'vim-scripts/paredit.vim'
    let g:paredit_smartjump = v:true
    let g:paredit_leader = ","

" go
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
    au FileType go call PareditInitBuffer()

" java
    call add(g:coc_global_extensions, 'coc-java')

" js
Plug 'pangloss/vim-javascript'
    let g:javascript_plugin_jsdoc = v:true
    call add(g:coc_global_extensions, 'coc-eslint')
Plug 'elzr/vim-json'
    let g:vim_json_syntax_conceal = v:true
    call add(g:coc_global_extensions, 'coc-json')
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
    call add(g:coc_global_extensions, 'coc-tsserver')

" python
    call add(g:coc_global_extensions, 'coc-python')

" rust
Plug 'rust-lang/rust.vim'
    call add(g:coc_global_extensions, 'coc-rust-analyzer')

" scala
    call add(g:coc_global_extensions, 'coc-metals')

call plug#end()

" highlights matching parens
runtime macros/matchit.vim
" load builtin manpage viewer
runtime ftplugin/man.vim

