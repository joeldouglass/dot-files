set encoding=utf-8
set nofsync

set path+=**

set complete-=i

set wildignore+=*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/tmp/*,*.swp,*.zip,*.exe
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=*/node_modules

set noesckeys
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

set timeoutlen=1000
set ttimeoutlen=10

set guifont=Droid\ Sans\ Mono\ Nerd\ Font\ Complete:h14

set autoread

set statusline=
set statusline+=\ %m%r
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%{ObsessionStatus()}
set statusline+=%*
set statusline+=\ %f
set statusline+=%=L:\ %P/%L\ C:\ %c

let mapleader=" "
let maplocalleader="\\"

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>
nmap <silent> <leader>/ :nohlsearch<CR>

" Disable ex mode
nnoremap Q <nop>

map <leader>* *N

" Time - Entry
map <leader>tn Go( <ESC>"=strftime("%a %m-%d-%Y %I:%M %p")<CR>Pa) 
map <leader>tt 0f)w"zy$G<ESC><leader>tn<C-R>z

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

" vimdiff diffget mappings.
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget LOCAL<CR>:diffupdate<CR>
nnoremap gdb :diffget BASE<CR>:diffupdate<CR>
nnoremap gdl :diffget REMOTE<CR>:diffupdate<CR>

noremap <leader>tc :tabclose<cr>

" Format Document
map <leader>f mzgg=G`z

" Save
noremap <C-S> :w<CR>
inoremap <C-S> <ESC>:w<CR>

" Macros
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" Quick switch buffer
function! SwitchBuffer()
  b#
endfunction

nmap ,m :call SwitchBuffer()<CR>

filetype plugin on
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd FileType md setlocal wrap

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'moll/vim-node'
Plug 'editorconfig/editorconfig-vim'
"Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'jalvesaq/Nvim-R'
Plug 'mileszs/ack.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'qpkorr/vim-bufkill'
Plug 'godlygeek/tabular'
Plug 'bkad/CamelCaseMotion'
Plug 'reasonml-editor/vim-reason'
Plug 'purescript-contrib/purescript-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'joeldouglass/vim-fugitive', { 'branch': 'add_tabbed_diff' }
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-obsession'
Plug 'tpope/tpope-vim-abolish'
Plug 'tpope/vim-unimpaired'
Plug 'chrisbra/csv.vim'
Plug 'reedes/vim-pencil'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'sharat87/roast.vim'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'dense-analysis/ale'


" Initialize plugin system
call plug#end()

" NERDTree
let NERDTreeShowHidden=1
" NERDTree Customizations
map ,n :NERDTreeToggle<CR>
let g:NERDTreeNodeDelimiter = "\u00a0"
let NERDTreeRespectWildIgnore=1

" FZF
nnoremap ,h :History<CR>
nnoremap ,b :Buffers<CR>
nnoremap ,f :Files<CR>

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_loc_list_height = 3

" Vim-Node
autocmd User Node
   \ if &filetype == "javascript" |
   \   nmap <buffer> <C-w>f <Plug>NodeVSplitGotoFile |
   \   nmap <buffer> <C-w><C-f> <Plug>NodeVSplitGotoFile |
   \ endif

" Silver searcher
let g:ackprg = 'ag --nogroup --nocolor --column'

" BufKill
let g:BufKillCreateMappings = 0

" TERN
let g:tern_map_keys=1
let g:tern_show_argument_hints='on_hold'

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'cool'
set laststatus=2

" CamelCaseMotion
map <leader>w <Plug>CamelCaseMotion_w
map <leader>b <Plug>CamelCaseMotion_b
map <leader>e <Plug>CamelCaseMotion_e
omap <silent> <leader>iw <Plug>CamelCaseMotion_iw
xmap <silent> <leader>iw <Plug>CamelCaseMotion_iw
omap <silent> <leader>ib <Plug>CamelCaseMotion_ib
xmap <silent> <leader>ib <Plug>CamelCaseMotion_ib
omap <silent> <leader>ie <Plug>CamelCaseMotion_ie
xmap <silent> <leader>ie <Plug>CamelCaseMotion_ie

" Ragtag
inoremap <M-o> <Esc>o
inoremap <C-j> <Down>
let g:ragtag_global_maps = 1

" Nvim R
let R_in_buffer = 0
let R_tmux_split = 1

" Reason formatting
" Wrap at the window width but not if it exceeds 120 characters.
let g:vimreason_extra_args_expr_reason = '"--print-width " . ' .  "min([120, winwidth('.')])"
autocmd FileType reason map <buffer> <C-A><C-F> :ReasonPrettyPrint<cr>

" Disable auto comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


fun! TrimWhitespace()
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfun

command! TrimWhitespace call TrimWhitespace()

noremap <Leader>tw :call TrimWhitespace()<CR>

autocmd BufWritePre *.js call TrimWhitespace()

fun! NoNum()
  set norelativenumber
  set nonumber
endfun

command! NoNum call NoNum()

fun! Num()
  set relativenumber
  set number
endfun

command! Num call Num()

" Fugitive
command -nargs=* Glg Git! graph <args>

" Pencil
let g:pencil#textwidth = 100

" For cygwin/mintty
" Cursor style for edit/insert (need this for SSH from windows)
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Special syntax mappings
au BufNewFile,BufRead .eslintrc set filetype=json
au BufNewFile,BufRead .eslintrc set syntax=json

" Color Scheme
syntax enable
colorscheme monokai

" Dev icons
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" Ctags
set tags=tags

" Markdown
let vim_markdown_preview_github=1

" Ale
let g:ale_fixers = {
 \ 'javascript': ['prettier', 'eslint']
 \ }

let g:ale_fix_on_save = 1


command! PyBr :normal Oimport pdb;pdb.set_trace()<ESC>
