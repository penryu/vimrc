" pluginit.vim
" Plugins and related settings, called from init.vim

" Open Plug window on right instead of left.
let g:plug_window = "vertical botright new"

call plug#begin('~/.vim/plugs')

Plug 'airblade/vim-gitgutter'
Plug 'blindFS/vim-taskwarrior'
    let g:task_rc_override = 'rc.defaultwidth=0'
Plug 'bronson/vim-trailing-whitespace'
Plug 'majutsushi/tagbar'
    let g:tagbar_width=25
    nmap <Leader>t :TagbarToggle<CR>
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-vinegar'
Plug 'kovisoft/paredit'
    let g:paredit_smartjump = v:true
    let g:paredit_leader = ","

Plug 'vim-airline/vim-airline'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
    let g:airline#parts#ffenc#skip_expected_string = 'utf-8[unix]'
    let g:airline_powerline_fonts = v:true
    let g:airline_skip_empty_sections = v:true
    " override default powerline symbols
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif
    let g:airline_symbols.colnr = ' ㏇'
Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme = 'owo'

Plug 'preservim/nerdtree', {'on': ['NERDTreeFocus','NERDTreeToggle']}
    let g:NERDTreeHijackNetrw = 0
    let g:NERDTreeWinSize=32
    nnoremap <Leader>N :NERDTreeToggle<CR>
    nnoremap <Leader>n :NERDTreeFocus<CR>
    " Exit Vim if NERDTree is the only window left.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'inkarkat/vim-SyntaxRange'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Tab to trigger completion with characters ahead and navigate.
    inoremap <silent><expr> <TAB>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1] =~# '\s'
    endfunction
    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()
    " Use <cr> to confirm completion.
    " `<C-g>u` means break undo chain at current position.
    inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
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
        elseif (coc#rpc#ready())
            call CocActionAsync('doHover')
        else
            execute '!' . &keywordprg . " " . expand('<cword>')
        endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)
    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)
    augroup mygroup
        autocmd!
        " Setup formatexpr specified filetype(s).
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        " Update signature help on jump placeholder.
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end
    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)
    " Remap for applying codeAction to the current buffer.
    nmap <leader>ac <Plug>(coc-codeaction)
    " Apply Autofix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)
    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from language server
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)
    " Remap <C-f> and <C-b> for scroll float windows/popups.
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    " Use CTRL-S for selection ranges.
    " Requires 'textDocument/selectionRange' support of language server.
    " Example: coc-tsserver, coc-python
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)
    " Add `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')
    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call CocAction('fold', <f-args>)
    " Add `:OR` command to organize import of current buffer.
    command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
    " Add native (Neo)Vim status line support.
    " See `:h coc-status` for integration with plugins with custom statusline:
    " Example: lightline.vim, vim-airline
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
    " Mappings for CocList
    " Show all diagnostics.
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands.
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
    let g:coc_global_extensions = ['coc-css', 'coc-html', 'coc-yaml']

Plug 'dense-analysis/ale', { 'for': ['clojure', 'sh'] }

" clojure
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-dispatch', { 'for': 'clojure' }
Plug 'radenling/vim-dispatch-neovim', { 'for': 'clojure' }
Plug 'clojure-vim/vim-jack-in', { 'for': 'clojure' }
Plug 'Olical/conjure', { 'tag': 'v4.21.0', 'for': 'clojure' }
    let g:ale_linters = {'clojure': ['clj-kondo']}
    call add(g:coc_global_extensions, 'coc-conjure')

" go
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
    autocmd FileType go call PareditInitBuffer()

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

if filereadable(expand("~/.vim/local/pluginit.vim"))
    source ~/.vim/local/pluginit.vim
endif

call plug#end()