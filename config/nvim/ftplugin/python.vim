set tabstop=4
set shiftwidth=4

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Formatting selected code.
xmap <leader>f  :Format<CR>
nmap <leader>f  :Format<CR>
