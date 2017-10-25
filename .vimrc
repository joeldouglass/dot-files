set encoding=utf-8
set path+=**

set complete-=i

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/tmp/*,*.swp,*.zip,*.exe
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

set autoread

set statusline=
set statusline+=\ %m%r
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%{ObsessionStatus()}
set statusline+=%*
set statusline+=\ %f
set statusline+=%=L:\ %P/%L\ C:\ %c

let mapleader=","
let maplocalleader=" "

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>rv :so $MYVIMRC<CR>
nmap <silent> <leader>/ :nohlsearch<CR>

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
map <leader>ml :diffget LOCAL<CR>:diffupdate<CR>
map <leader>mb :diffget BASE<CR>:diffupdate<CR>
map <leader>mr :diffget REMOTE<CR>:diffupdate<CR>

noremap <leader>tc :tabclose<cr>

" Help find and replace
nnoremap <leader>ry "zyiw
vnoremap <leader>ry "zy
nnoremap <leader>rs yiw:%s/<C-r>"/<C-r>z/gc<cr>y
nnoremap <leader>rr yiw:%s/\<<C-r>"\>//gc<left><left><left>

" Save
noremap <C-S> :w<CR>
inoremap <C-S> <ESC>:w<CR>

filetype plugin on
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'moll/vim-node'
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'jalvesaq/Nvim-R'
Plug 'jpalardy/vim-slime'
Plug 'mileszs/ack.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-obsession'
Plug 'vim-scripts/camelcasemotion'
Plug 'tpope/tpope-vim-abolish'
Plug 'reasonml-editor/vim-reason'
Plug 'purescript-contrib/purescript-vim'
Plug 'christoomey/vim-tmux-navigator'

" Initialize plugin system
call plug#end()

" NERDTree
let NERDTreeShowHidden=1
" NERDTree Customizations
map <C-n> :NERDTreeToggle<CR>

" Ctrl-P Customizations
let g:ctrlp_root_markers = ['.ctrlp']
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files --cached --exclude-standard --others']
let g:ctrlp_cmd = 'CtrlPLastMode'

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

" TERN
let g:tern_map_keys=1
let g:tern_show_argument_hints='on_hold'

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme = 'cool'
set laststatus=2

" Ragtag
inoremap <M-o> <Esc>o
inoremap <C-j> <Down>
let g:ragtag_global_maps = 1

" Unmap some buffkill stuff that is conflicting with other mappings
" Do I need this?
"unmap <leader>ba
"unmap <leader>bundo
"unmap <leader>!bw
"unmap <leader>bw
"unmap <leader>!bd
"unmap <leader>bd
"unmap <leader>bun
"unmap <leader>!bun
"unmap <leader>bf
"unmap <leader>bb

" Reason formatting
" Wrap at the window width but not if it exceeds 120 characters.
let g:vimreason_extra_args_expr_reason = '"--print-width " . ' .  "min([120, winwidth('.')])"
autocmd FileType reason map <buffer> <C-A><C-F> :ReasonPrettyPrint<cr>

fun! TrimWhitespace()
  let l:save = winsaveview()
  %s/\s\+$//e
  call winrestview(l:save)
endfun

command! TrimWhitespace call TrimWhitespace()

noremap <Leader>tw :call TrimWhitespace()<CR>

" Fugitive
function! GStatusTabDiff()
  if has('multi_byte_encoding')
    let colon = '\%(:\|\%uff1a\)'
  else
    let colon = ':'
  endif
  let filename = matchstr(matchstr(getline(line('.')),'^#\t\zs.\{-\}\ze\%( ([^()[:digit:]]\+)\)\=$'), colon.' *\zs.*')
  tabedit %
  execute ':Gedit ' . filename
  Gvdiff
endfunction
command! GStatusTabDiff call GStatusTabDiff()
autocmd FileType gitcommit noremap <buffer> dt :GStatusTabDiff<CR>

" For cygwin/mintty
" Cursor style for edit/insert (need this for SSH from windows)
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Color Scheme
syntax enable
colorscheme monokai
