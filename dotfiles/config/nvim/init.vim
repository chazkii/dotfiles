" keybindings beigin
" keep in sync with .ideavimrc
inoremap kj <Esc>
" keybindings end

:set number relativenumber
call plug#begin(stdpath('data') . '/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'lighttiger2505/sqls.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()
