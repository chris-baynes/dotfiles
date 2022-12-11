execute pathogen#infect()
syntax on
filetype plugin indent on

set number

set encoding=utf8

set hlsearch
hi Search cterm=NONE ctermfg=lightgrey ctermbg=54
hi Visual cterm=NONE ctermfg=lightgrey ctermbg=25

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
" terminal mappings
"tnoremap <Esc> <C-\><C-n>
"tnoremap <C-h> <C-\><C-n><C-w>h
"tnoremap <C-j> <C-\><C-n><C-w>j
"tnoremap <C-k> <C-\><C-n><C-w>k
" don't override console clearing C-l
" tnoremap <C-l> <C-\><C-n><C-w>l

" open terminal
map <C-t> :term<CR>

set splitbelow
set splitright

" set cursorline
" lazy redraw so the cursorline is not slow
" set lazyredraw

fun! StripTrailingWhitespace()
    " Only strip if the b:noStripeWhitespace variable isn't set
    if !exists('b:noStripWhitespace')
        return
    endif
    %s/\s\+$//e
endfun

autocmd BufWritePre * call StripTrailingWhitespace()
autocmd BufRead,BufNewFile *.rabl set filetype=ruby
autocmd BufRead,BufNewFile *.cr set filetype=ruby
autocmd FileType ruby,javascript,perl,coffee let b:noStripWhitespace=1
" always enter terminal with insert mode
autocmd BufWinEnter,WinEnter term://* startinsert
" remote cursor line in terminal
autocmd BufNew term://* set nocursorline
" remove split lines between windows
set fillchars+=vert:\ 
" make split less obtrusive
hi VertSplit ctermfg=DarkGrey

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

" copy to system clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" search for visually selected text
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

"nerdtree style explore mode
let g:netrw_liststyle = 3

"rust
let g:racer_cmd = "/home/cdb/.cargo/bin/racer"
au FileType rust nmap gd <Plug>(rust-def)
au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap gx <Plug>(rust-def-vertical)
au FileType rust nmap gt <Plug>(rust-def-tab)
au FileType rust nmap <leader>gd <Plug>(rust-doc)

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
au FileType go nmap <Leader>f :GoDecls<CR>

" crystal
au FileType ruby nmap <Leader>s :w<CR>:!crystal spec<CR>

" defaults
set shiftwidth=2
set expandtab

" file type tabs & whitespace
autocmd Filetype ruby setlocal shiftwidth=2 tabstop=2 sts=2 et
autocmd Filetype yaml setlocal shiftwidth=2 tabstop=2 sts=2 et
autocmd Filetype html setlocal shiftwidth=2 tabstop=2 sts=2 et
autocmd Filetype css setlocal shiftwidth=2 tabstop=2 sts=2 et
autocmd Filetype javascript setlocal shiftwidth=2 tabstop=2 sts=2 et
autocmd Filetype coffee setlocal shiftwidth=2 tabstop=2 sts=2 et
autocmd Filetype php setlocal shiftwidth=4 tabstop=4 sts=4 et
autocmd Filetype json setlocal shiftwidth=4 tabstop=4 sts=4 et
autocmd Filetype go setlocal shiftwidth=2 tabstop=2
autocmd Filetype tsx setlocal shiftwidth=2 tabstop=2

" format json
nmap <leader>j :%!python -m json.tool<CR>

" ctrlP
let g:ctrlp_cmd = 'CtrlPCurWD'
let g:ctrlp_working_path_mode = 0
" let g:ctrlp_match_func = {'match' : 'matcher#cmatch'}
" disable mru
" let g:ctrlp_mruf_max = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|data\|log\|tmp$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }

" using Ag speeds things up, but result relevance ordering is terrible
" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" let g:ctrlp_user_command = 'find %s -depth -type f'
" let g:ctrlp_path_nolim = 1
" let g:ctrlp_max_files = 0
" let g:ctrlp_max_depth = 40
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']

