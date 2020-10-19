" config based on https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en
call plug#begin('~/.local/share/nvim/plugged')

Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'vim-airline/vim-airline'
" Completes quote marks and such for you
Plug 'jiangmiao/auto-pairs'
" Something with comments--idk
Plug 'scrooloose/nerdcommenter'
Plug 'sbdchd/neoformat'
Plug 'davidhalter/jedi-vim'
Plug 'machakann/vim-sandwich'
Plug 'scrooloose/nerdtree'
Plug 'neomake/neomake'
Plug 'machakann/vim-highlightedyank'
Plug 'whatyouhide/vim-gotham'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-sleuth'

call plug#end()

" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 0

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"

let g:deoplete#enable_at_startup = 1
" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

let g:neomake_python_enabled_makers = ['pylint']

let g:neoformat_enabled_python = ['black']

call neomake#configure#automake('nrwi', 500)

let mapleader=","
" so that we can keep the , key's functionality
nnoremap ,, ,

" line numbers
set number

nmap <F8> :TagbarToggle<CR>
nmap <F6> :NERDTreeToggle<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"""" 2. Key Bindings.
" More convenient movement when lines are wrapped.
nmap j gj
nmap k gk

"""" 3. Vim Appearance.
" Search settings
set hlsearch " hilight
set incsearch " jump to best fit
 " Turn off search highlighting with <CR>.
nnoremap <CR> :nohlsearch<CR><CR>
" Tab settings
set autoindent
filetype plugin indent on
" set tabstop=4
" set shiftwidth=4
" set expandtab
set mouse=a

set background=dark
set termguicolors
colorscheme gotham
