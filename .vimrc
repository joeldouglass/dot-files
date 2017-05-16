set encoding=utf-8
set path+=**
let g:slime_target = "conemu"

set complete-=i

set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=**\\node_modules

set wildmenu
set hidden
set relativenumber
set number
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set autoindent
set copyindent
set showmatch
set showcmd
set smartcase
set hlsearch
set title
set history=1000
set undolevels=1000
set visualbell
set noerrorbells
set nowrap
set mouse=a

set statusline=
set statusline+=\ %m%r
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=\ %f
set statusline+=%=L:\ %P/%L\ C:\ %c

let mapleader=","
let maplocalleader=" "

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>
nmap <silent> <leader>/ :nohlsearch<CR>

nnoremap gb :ls<CR>:b<Space>

" Move between windows
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l
noremap <C-H> <C-W>h

" Remap scrolling to be faster
noremap <C-E> 10<C-E>
noremap <C-Y> 10<C-Y>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

filetype plugin on
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'https://github.com/ctrlpvim/ctrlp.vim'
Plug 'https://github.com/scrooloose/nerdtree'
Plug 'https://github.com/pangloss/vim-javascript.git'
Plug 'https://github.com/moll/vim-node.git'
Plug 'https://github.com/editorconfig/editorconfig-vim.git'
Plug 'https://github.com/vim-syntastic/syntastic.git'
Plug 'scrooloose/nerdcommenter'
Plug 'jalvesaq/Nvim-R'
Plug 'tpope/vim-surround'
Plug 'jpalardy/vim-slime'
Plug 'mileszs/ack.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'qpkorr/vim-bufkill'
Plug 'ternjs/tern_for_vim'
Plug 'lrvick/Conque-Shell'
Plug 'tarruda/vim-conque-repl'
Plug 'tpope/vim-fugitive'

" Initialize plugin system
call plug#end()

" Ctrl-P Customizations
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|ico|git|svn))$'

let g:ctrlp_cmd = 'CtrlPLastMode'

" NERDTree Customizations
map <C-n> :NERDTreeToggle<CR>

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']

" Vim-Node
autocmd User Node
   \ if &filetype == "javascript" |
   \   nmap <buffer> <C-w>f <Plug>NodeVSplitGotoFile |
   \   nmap <buffer> <C-w><C-f> <Plug>NodeVSplitGotoFile |
   \ endif

" Silver searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

" TERN
let g:tern_map_keys=1
let g:tern_show_argument_hints='on_hold'

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'cool'
set laststatus=2

fun! TrimWhitespace()
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfun

command! TrimWhitespace call TrimWhitespace()

noremap <Leader>w :call TrimWhitespace()<CR>
