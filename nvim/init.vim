""
""        _
"" __   _(_)_ __ ___  _ __ ___
"" \ \ / / | '_ ` _ \| '__/ __|
""  \ V /| | | | | | | | | (__
""   \_/ |_|_| |_| |_|_|  \___|
""
""

call plug#begin('~/.config/nvim/plugged')

  Plug 'morhetz/gruvbox'
  Plug 'ap/vim-css-color'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'scrooloose/nerdtree'
  Plug 'mattn/emmet-vim'
  Plug 'sheerun/vim-polyglot'
  Plug 'jreybert/vimagit'
  Plug 'itchyny/lightline.vim'
  Plug 'ryanoasis/vim-devicons'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'Yggdroot/indentLine'

call plug#end()

  syntax enable
  let mapleader = ","              " Use , instead of \ as leader
  filetype plugin indent on
  set background=dark             " Use dark background
  colorscheme gruvbox             " gruvbox colorscheme
""set lines=50 columns=100        " vim initial window size
  set noshowmode                  " because I use a lightline
  set clipboard=unnamed           " Clipboard integration
  set laststatus=2                " Always show status line
  set encoding=utf-8              " Set default encoding to UTF-8
  set autoread                    " Automatically reread changed files without asking anything
  set autoindent                  " Automatically indent new lines
  set backspace=indent,eol,start  " Makes backspace key more powerful.
  set incsearch                   " Shows the match while typing
  set hlsearch                    " Highlight found searches
  set mouse=a
  set cursorline                  " Highlit cursor line
  set number relativenumber       " Show relative and actual line number
  set wrap linebreak nolist
  set colorcolumn=80
  highlight ColorColumn ctermbg=Black

" Softtaabs, 2 spaces
  set tabstop=2
  set shiftwidth=2
  set shiftround
  set expandtab

" Enable autocompletion:
  set wildmode=longest,list,full

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
  set splitbelow splitright

" Nerd tree
  map <leader>q :NERDTreeToggle<CR>
  let NERDTreeShowHidden=1

" devicons
  let g:webdevicons_enable_nerdtree = 1             " adding to NERDTree
  let g:webdevicons_enable_airline_statusline = 1   " adding to vim-airline's statusline

" Shortcutting split navigation, saving a keypress:
  map <C-h> <C-w>h
  map <C-j> <C-w>j
  map <C-k> <C-w>k
  map <C-l> <C-w>l

" Automatically deletes all trailing whitespace on save.
  autocmd BufWritePre * %s/\s\+$//e

" Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Spell-check set to F6:
  map <F6> :setlocal spell! spelllang=en_gb<CR>

" Enable Emmet just for html/css
  let g:user_emmet_install_global = 0
  autocmd FileType html,css EmmetInstall
  let g:user_emmet_leader_key='<C-Z>'

" Custom mappings
  map \ <leader>q
