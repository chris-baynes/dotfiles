execute pathogen#infect()
syntax on
filetype plugin indent on

set number

set hlsearch

set pastetoggle=<F2>

set ignorecase
set smartcase

"set smarttab

set noswapfile

let mapleader=","

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
imap <C-h> <Esc><C-w>h
imap <C-j> <Esc><C-w>j
imap <C-k> <Esc><C-w>k
imap <C-l> <Esc><C-w>l

set splitbelow
set splitright

set cursorline

fun! StripTrailingWhitespace()
    " Only strip if the b:noStripeWhitespace variable isn't set
    if !exists('b:noStripWhitespace')
        return
    endif
    %s/\s\+$//e
endfun

autocmd BufWritePre * call StripTrailingWhitespace()
autocmd FileType ruby,javascript,perl,coffee let b:noStripWhitespace=1
autocmd BufRead,BufNewFile *.rabl set filetype=ruby

" save
nmap <c-s> :w<CR>
imap <c-s> <Esc>:w<CR>
vmap <c-s> <Esc>:w<CR>

" insert single character and go back to normal mode
nmap <silent> s "=nr2char(getchar())<cr>P

" switch to last buffer
nmap <c-a> :b#<CR>

" alias common macro
nmap <Space> @q

"nerdtree style explore mode
let g:netrw_liststyle = 3

"vim-go 
let g:go_fmt_command = "goimports"
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>s <Plug>(go-implements)

" file type tabs & whitespace
autocmd Filetype ruby setlocal shiftwidth=2 tabstop=2 sts=2 et
autocmd Filetype coffee setlocal shiftwidth=2 tabstop=2 sts=2 et
autocmd Filetype php setlocal shiftwidth=4 tabstop=4 sts=4 et
autocmd Filetype go setlocal shiftwidth=2 tabstop=2

" ctrlP
let g:ctrlp_cmd = 'CtrlPMixed'
" disable mru
let g:ctrlp_mruf_max = 0

set grepprg=ag\ --nogroup\ --nocolor
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
