"vnoremap  <C-c> "+y
"cmap      <C-v> <C-r>+
"map       <C-v> "+gP

"     function! ToggleConcealLevel()
"         if &conceallevel == 0
"             setlocal conceallevel=2
"         else
"             setlocal conceallevel=0
"         endif
"     endfunction
"     nnoremap <silent> <C-c><C-y> :call ToggleConcealLevel()<CR>
" syntax keyword pyStatement lambda conceal cchar=λ

" These plugins are infrequently or rarely used,
" but I don't want to forget about them.

" execute current line as command-mode command; ex: :r ~/.signature
"nmap <silent> <F3> yy:execute @"<CR>
" Make p in Visual mode replace the selected text with the "" register.
"vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" NERDTree init
" Start nerdtree when no file to open
"autocmd StdinReadPre * let s:std_in=1
" Start NERDTree and put the cursor back in the other window.
"autocmd VimEnter * NERDTree | wincmd p
" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
"autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 | let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" Plug 'jlanzarotta/bufexplorer'
"     let g:bufExplorerSortBy='name'
"     let g:bufExplorerSplitType=''

" https://github.com/tpope/vim-speeddating
" Plug 'tpope/vim-speeddating'  " jit

" https://github.com/vim-scripts/utl.vim
" Plug 'vim-scripts/utl.vim'  " mark
