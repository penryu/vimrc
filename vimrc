" ~/.vim/vimrc
" Tim Hammerquist <penryu@gmail.com>

set nocompatible

set autoindent
set autoread
set background=dark
set backspace=eol,indent,start
set nobackup backupcopy=auto nowritebackup
set clipboard+=unnamed
set cmdheight=2
set colorcolumn=81,+1
set conceallevel=2
set noconfirm
set cursorline
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
set shiftwidth=4
set shortmess=acotI
set sidescroll=1
set sidescrolloff=21
set signcolumn=yes
set nosmartindent
set nosmarttab
set softtabstop=4
set splitbelow
set terse
set textwidth=80
set timeout nottimeout timeoutlen=1000 ttimeoutlen=100
set updatetime=300
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
    autocmd! FileType gitcommit setl tw=72
    autocmd! FileType go        setl sts=0 sw=0 ts=4 noexpandtab
    autocmd! FileType mail      setl tw=70 com+=n:> noml
    autocmd! FileType markdown  setl conceallevel=0 spell
    autocmd! FileType perl      setl ep=perltidy\ -st
    autocmd! FileType vim       setl sts=2 sw=2

    " add gutter when buffer is large enough
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

    " add color column (margin indicator) only if modifiable
    function! ModifiableHook()
        if !&modifiable
            set colorcolumn=""
        else
            set colorcolumn=81,+1
        endif
    endfunction
    autocmd! BufEnter *         call ModifiableHook()
endif

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

Plug 'jceb/vim-orgmode'
    let g:org_agenda_files=['~/Dropbox/org/inbox.org']

Plug 'majutsushi/tagbar'
    let g:tagbar_left=v:true
    nmap <Leader>tb :TagbarToggle<CR>

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
    let g:airline_powerline_fonts=v:true
    let g:airline_skip_empty_sections=v:true
    let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
    let g:airline_theme='distinguished'

"Plug 'neoclide/coc.nvim', {'branch': 'master'}
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

Plug 'dense-analysis/ale'
Plug 'inkarkat/vim-SyntaxRange'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-speeddating'
Plug 'sheerun/vim-polyglot'
Plug 'machakann/vim-sandwich'
Plug 'vim-scripts/utl.vim'

" clojure
Plug 'Olical/conjure', { 'tag': 'v2.1.2', 'do': 'bin/compile' }
    let g:ale_linters = {'clojure': ['clj-kondo']}
    let g:conjure_log_auto_close = v:true
    let g:conjure_log_blacklist = ["eval", "load-file", "ret", "ret-multiline", "up"]
    let g:conjure_log_direction = "horizontal"
    let g:conjure_log_size_large = 42
    let g:conjure_log_size_small = 15
    call add(g:coc_global_extensions, 'coc-conjure')

Plug 'vim-scripts/paredit.vim'
    let g:paredit_smartjump = v:true

" go
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
    au FileType go call PareditInitBuffer()

" java/kotlin
Plug 'udalov/kotlin-vim'
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
    call add(g:coc_global_extensions, 'coc-tslint')
    call add(g:coc_global_extensions, 'coc-tsserver')

" python
    call add(g:coc_global_extensions, 'coc-python')

" rust
Plug 'rust-lang/rust.vim'

call plug#end()

" highlights matching parens
runtime macros/matchit.vim
" load builtin manpage viewer
runtime ftplugin/man.vim

