"O#:Replace with snippets
function SetSkeleton(skeletonExt)
    if !filereadable(expand("~/.vim/skeletons/skeleton." . a:skeletonExt))
        return
    endif
    echo "Setting skeleton for " . a:skeletonExt
    let template = readfile(expand("~/.vim/skeletons/skeleton." . a:skeletonExt)) 
    if (template != [])
        call setline(1, template)
        execute "%s/__FILENAME__/" . expand("%:t:r") . "/g"
        execute "%s/__FEAT__/" . expand("%:t:r") . "/g"
        normal! gg
    endif
endfunction

augroup skeletons
    autocmd!
    autocmd BufNewFile *.* call SetSkeleton(expand("%:e"))
augroup END
