set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

set laststatus=3
set cmdheight=0

let g:user_emmet_mode='a'

" Go LSP Config bin executable
augroup LspGo
  au!
  autocmd User lsp_setup call lsp#register_server({
      \ 'name': 'go-lang',
      \ 'cmd': {server_info->['gopls']},
      \ 'whitelist': ['go'],
      \ })
  autocmd FileType go setlocal omnifunc=lsp#complete
  "autocmd FileType go nmap <buffer> gd <plug>(lsp-definition)
  "autocmd FileType go nmap <buffer> ,n <plug>(lsp-next-error)
  "autocmd FileType go nmap <buffer> ,p <plug>(lsp-previous-error)
augroup end

augroup folds_remember
    autocmd BufWinLeave *.md mkview
    autocmd BufWinEnter *.md silent! loadview
augroup END

augroup PHBSCF
    autocmd!
    autocmd BufWritePost *.php :lua require'phpcs'.cbf()
augroup END

"O#:Replace with your own gitlab 
let g:fugitive_gitlab_domains = ['https://gitlab.private.instance']

let g:diminactive_buftype_blacklist = ['nofile', 'nowrite', 'acwrite', 'quickfix', 'help']

let g:db_ui_auto_execute_table_helpers = 1

lua require('config')
