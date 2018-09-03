let mapleader = " "

syntax on
filetype plugin indent on

set clipboard=unnamed
set scrolloff=8
set number
set relativenumber
set laststatus=2

" Remove 'set hidden'
set nohidden

" https://github.com/tpope/vim-vinegar/issues/13
augroup netrw_buf_hidden_fix
    autocmd!

    " Set all non-netrw buffers to bufhidden=hide
    autocmd BufWinEnter *
                \  if &ft != 'netrw'
                \|     set bufhidden=hide
                \| endif

augroup end

set confirm
set nocompatible
set ts=4
set sw=4
set sts=4
set expandtab
set ruler
set list
set listchars=nbsp:⦸                  " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅                 " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
                                      " + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
set listchars+=extends:»              " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:«             " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•                " BULLET (U+2022, UTF-8: E2 80 A2)
set gdefault
set mouse=a
set background=dark
set cursorline
set textwidth=100
set colorcolumn=100

set autoindent
set backspace=indent,eol,start
set complete-=i
set smarttab

set incsearch
set wildmenu
set history=1000
set t_Co=16

" persistent undo
set undofile
set undodir=~/.vim/undodir

" let's not do swapfiles, k?
set noswapfile

" donkey!
set noerrorbells
set vb t_vb=

" Switch between last two files
nnoremap <Leader>b <C-^>

nnoremap <Leader>w :write<CR>

" Close current buffer
nnoremap <Leader>qq :bd<CR>

" Easier editing of .vimrc
nnoremap <Leader>v :sp ~/.vimrc<CR>
nnoremap <Leader>r :source $MYVIMRC<CR>

nnoremap <Leader>h :silent! nohls<cr>

" Quickly switch between buffers
nnoremap <Leader><Left> :bprevious<CR>
nnoremap <Leader><Right> :bnext<CR>

" Turn off highlight searches
nnoremap <Leader><Leader> :noh<CR>

" Copy rest of line to line above
nnoremap <Leader>p DO<c-r>"<esc>

" Remap j and k to act as expected when used on long, wrapped, lines
" https://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Yank to end of line
nnoremap Y y$

" Toggle folds
nnoremap <Tab> za

autocmd filetype crontab setlocal nobackup nowritebackup

if exists('+colorcolumn')
  " Highlight up to 255 columns (this is the current Vim max) beyond 'textwidth'
  let &l:colorcolumn='+' . join(range(0, 254), ',+')
endif

if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j                " remove comment leader when joining comment lines
endif

set formatoptions+=n                  " smart auto-indenting inside numbered lists

set foldmethod=indent
set nofoldenable

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'chriskempson/base16-vim'

Plug 'sheerun/vim-polyglot'

Plug 'vim-scripts/groovyindent-unix'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-vinegar'

Plug 'junegunn/vim-easy-align'

" Plug 'jiangmiao/auto-pairs'
" https://github.com/jiangmiao/auto-pairs/issues/74
Plug 'tylrd/auto-pairs'

Plug 'airblade/vim-gitgutter'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'wincent/terminus'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'mattn/calendar-vim'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
call plug#end()

""""""""""""""""""""""""""""""""""""""""
" Plugin Configuration goes under here!
""""""""""""""""""""""""""""""""""""""""

let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

nmap <Leader>n <Plug>VimwikiIndex
nmap <Leader>i <Plug>VimwikiDiaryIndex
nmap <Leader>d <Plug>VimwikiMakeDiaryNote
nmap <Leader>dy <Plug>VimwikiMakeYesterdayDiaryNote
nmap <Leader>c :Calendar<CR>

let g:calendar_options = 'nornu'

let g:AutoPairsMultilineClose=0

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

let g:airline_theme='minimalist'

nnoremap <silent> <C-p> :FZF<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

set updatetime=100
set timeoutlen=1000 ttimeoutlen=0

set highlight+=c:LineNr
set highlight+=N:DiffText
set highlight+=@:ColorColumn
set hlsearch
let @/ = ""

hi! MatchParen cterm=none ctermbg=black ctermfg=white
hi! Error cterm=reverse ctermbg=white ctermfg=red

" set wildignore+=*/.terraform/*,*/node_modules/*,*.swp,*.so,*.zip,*/.gradle/*
