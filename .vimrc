set nocompatible

source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if has("autocmd")
  augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
  augroup END
endif

" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif
""" 

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhartington/oceanic-next'
Plug 'sainnhe/sonokai'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'leafgarland/typescript-vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'hashivim/vim-terraform'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Theme
syntax on

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

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

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
  noremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

imap jk <Esc>

colorscheme OceanicNext

" COC settings
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

command! -nargs=0 Prettier :CocCommand prettier.formatFile

