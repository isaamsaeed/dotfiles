
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'sainnhe/gruvbox-material'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'itchyny/lightline.vim'
Plug 'leafgarland/typescript-vim'
Plug 'vim-syntastic/syntastic'
Plug 'mustache/vim-mustache-handlebars'
Plug 'hashivim/vim-terraform'
call plug#end()

" Theme
syntax enable

" Theme settings
" for vim 8
if (has("termguicolors"))
	set termguicolors
endif

set number
" Set tab properties
set tabstop=4
set shiftwidth=4
set noexpandtab
set autoindent
" Allow buffers to be open and not have to save the current buffer
set hidden
set hlsearch
set incsearch
set relativenumber
set colorcolumn=120
" Allow files to reload automatically
set autoread
set ignorecase
set smartcase
" Allow folds to be created based on indents
set foldmethod=indent

" For some reason lightline requires this to show
set laststatus=2
set wildignore=*/node_modules/*,*/build/*,*/lib/*

" Set directories for vim files
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

" Prettier settings
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat_config_present = 1
let g:prettier#config#arrow_parens = 'avoid'
let g:prettier#config#print_width = 120
let g:prettier#config#config_precedence = 'prefer-file'

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']

" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4"

" Map the <Leader> key to space
nnoremap <SPACE> <Nop>
let mapleader = " "

nnoremap <Leader>p :Files<CR>
nnoremap <Leader>b :buffers<CR>:buffer<Space>
nnoremap <Leader>g :grep -RF --exclude-dir={node_modules,build,coverage,dist} --exclude=tags<Space>
nnoremap <Leader>z :w<CR>
nnoremap <Leader>c :bn\|bd! #<CR>

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
	nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

imap jk <Esc>

let g:gruvbox_material_disable_italic_comment = 1
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_palette = 'mix'

set background=dark
colorscheme gruvbox-material
