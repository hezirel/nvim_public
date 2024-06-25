"Disble arrow keys
noremap <Up>    <Nop>
noremap <Down>  <Nop>
noremap <Left>  :tabp<CR>
noremap <Right> :tabn<CR>
noremap <M-b> :bp<CR>
noremap <M-f> :bn<CR>
noremap <M-Up> :tabnew %<CR>
noremap <M-Down> :tabn<CR>

"Splits switch mapping: Ctrl + HJKL
"nnoremap <silent><C-J> <C-W><C-J>
"nnoremap <silent><C-k> <C-W><k>
"nnoremap <silent><C-L> <C-W><C-L>
"nnoremap <silent><C-H> <C-W><C-H>
let g:tmux_navigator_no_mappings = 1

"O#:Move all keymaps to plugin specs
noremap <silent> <C-h> :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <C-j> :<C-U>TmuxNavigateDown<cr>
noremap <silent> <C-k> :<C-U>TmuxNavigateUp<cr>
noremap <silent> <C-l> :<C-U>TmuxNavigateRight<cr>
noremap <silent> <C-,> :<C-U>TmuxNavigatePrevious<cr>

" Copy document in system clipboard
nnoremap <silent><C-y> "*y
vnoremap <silent><C-y> "*y
cnoremap <silent><C-y> %y*<CR>

" no indent on paste
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
" display white space characters with F3
nnoremap <silent><F3> :set list! list?<CR>

tnoremap <Esc> <C-\><C-N>
tnoremap <C-t><C-e> <Esc>
nnoremap <silent><C-s> :silent w<CR>
cnoremap <C-b><C-n> :

nnoremap <silent><C-n> :NvimTreeToggle<CR>

inoremap <silent><C-t><C-n> O#:

inoremap <silent><C-t><C-t> <Esc>0i<C-R>=strftime('%Y-%m-%d / %H:%M')<CR><Esc>o	

let g:copilot_no_tab_map = v:true

let g:copilot_filetypes = {
    \'yml': v:true,
    \'yaml': v:true,
    \'json': v:true,
    \'toml': v:true,
    \'md': v:true,
    \'fish': v:true,
    \}

nnoremap <silent> K :lua vim.lsp.buf.hover()<CR>
let g:cmp_toggle = v:true

" Auto linting on file save for js
function LintIfFileExists()
    if !filereadable(expand("%:r")) | return | endif
    EslintFixAll
endfunction

"O#:Replace with null-ls formatter and linters
autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js,*.php call LintIfFileExists()
