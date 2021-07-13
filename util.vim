" ~/.vim/util.vim

function! SourceIfExist(scriptname)
  if filereadable(expand(a:scriptname))
    execute 'source' a:scriptname
    return 1
  else
    return 0
  endif
endfunction
