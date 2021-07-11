"""" 1. Vim Behaviour.
" Use filetype-based syntax hilighting, ftplugins, and indentation.
syntax on
filetype plugin indent on
" Use numbering. Don't use relative numbering as this is slow (especially in
" .tex files).
set number
" Enables mouse support. Note that on Mac OS X this doesn't work well on the
" default terminal.
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

"""" 2. Key Bindings.
" More convenient movement when lines are wrapped.
nmap j gj
nmap k gk

vmap y ygv<Esc>

"""" 3. Vim Appearance.
" Search settings
set hlsearch " hilight
set incsearch " jump to best fit
 " Turn off seach hilighting with <CR>.
nnoremap <CR> :nohlsearch<CR><CR>
" Tab settings
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
" Make statusline appear even with only single window.
set laststatus=2

" Disable arrow keys to force using hjkl
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" vim: set ft=vim foldmethod=marker ts=4 sw=4 tw=80 et :
" Plugin 'vbundles/nerdtree'

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'godlygeek/tabular'
" Plugin 'plasticboy/vim-markdown'
" Plugin 'pandysong/ghost-text.vim'
Plugin 'preservim/nerdtree'

call vundle#end()            " required
filetype plugin indent on    " required

call plug#begin('~/.vim/plugged')

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {}
    \ }


call plug#end()

nmap <C-s> <Plug>MarkdownPreview
nmap <M-s> <Plug>MarkdownPreviewStop
nmap <C-p> <Plug>MarkdownPreviewToggle

nmap <F6> :NERDTreeToggle<CR>

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'javascript', 'java']
let g:mkdp_browser = 'google-chrome'

autocmd FileType markdown setlocal shiftwidth=2 tabstop=2

" https://stackoverflow.com/questions/4766230/map-shift-tab-in-vim-to-inverse-tab-in-vim
inoremap <S-Tab> <C-d>

" None of these keys already do something that I either need to do or can't
" already do but easier
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Show incomplete commands
set showcmd
set nofoldenable
