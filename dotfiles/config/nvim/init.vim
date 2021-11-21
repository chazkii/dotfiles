" keybindings beigin
" keep in sync with .ideavimrc
inoremap kj <Esc>
" keybindings end

syntax enable
filetype plugin indent on

" https://github.com/dense-analysis/ale/blob/de67f4743d9ffd1694d15b1b91fedfaa0a5cda70/README.md?plain=1#L452
let g:ale_disable_lsp = 1

:set number relativenumber
call plug#begin(stdpath('data') . '/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'lighttiger2505/sqls.vim'

Plug 'vim-syntastic/syntastic'

" Auto-completion engine (alternative to omnicomplete)
" Disabled as conflicts big-time with coc
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Alternative to deoplete that we should migrate to once it has feature-parity
" with deoplete
" Plug 'Shougo/ddc.vim'
" Plug 'vim-denops/denops.vim'


" LSP system 1
" We use coc.nvim over vim.lsp and others because coc.nvim leverages VSCode
" ecosystem
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
Plug 'fannheyward/coc-julia'

" LSP system 2
" Experimenting with stock nvim as coc-julia wasn't working properly as of
" 2021-04-04
" Plug 'neovim/nvim-lspconfig'

Plug 'jpalardy/vim-slime'

" Themes
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'JuliaEditorSupport/julia-vim'

Plug 'rust-lang/rust.vim'

" Plug 'elixir-editors/vim-elixir'

" Line engine
Plug 'dense-analysis/ale'
" Microsoft open source linting
Plug 'fannheyward/coc-pyright'
" Python 3 syntax higlighting
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
Plug 'bfredl/nvim-ipy'

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
call plug#end()

colorscheme nord
let g:rustfmt_autosave = 1

" LSP system 1 START recommend coc.nvim config

" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" https://github.com/dense-analysis/ale/blob/de67f4743d9ffd1694d15b1b91fedfaa0a5cda70/README.md?plain=1#L452
let g:ale_disable_lsp = 1


" Disabled as conflicts big-time with coc
" let g:deoplete#enable_at_startup = 1
" https://github.com/numirias/semshi/blob/252f07fd5f0ae9eb19d02bae979fd7c9152c1ccf/README.md?plain=1#L181
" call deoplete#custom#option('auto_complete_delay', 100)

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

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" END recommend coc.nvim config

" LSP system 2

" lua << EOF
" require'lspconfig'.julials.setup{
"     on_new_config = function(new_config,new_root_dir)
"       server_path = "/Users/csmith/.julia/packages/LanguageServer/y1ebo/src"
"       cmd = {
"         "julia",
"         "--project="..server_path,
"         "--startup-file=no",
"         "--history-file=no",
"         "-e", [[
"           using Pkg;
"           Pkg.instantiate()
"           using LanguageServer; using SymbolServer;
"           depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
"           project_path = dirname(something(Base.current_project(pwd()), Base.load_path_expand(LOAD_PATH[2])))
"           # Make sure that we only load packages from this environment specifically.
"           @info "Running language server" env=Base.load_path()[1] pwd() project_path depot_path
"           server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path);
"           server.runlinter = true;
"           run(server);
"         ]]
"     };
"       new_config.cmd = cmd
"     end
" }
" local nvim_lsp = require('lspconfig')
" local on_attach = function(client, bufnr)
"   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
"   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
" 
"   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
" 
"   -- Mappings.
"   local opts = { noremap=true, silent=true }
"   buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
"   buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
"   buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
"   buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
"   buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
"   buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
"   buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
"   buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
"   buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
"   buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
"   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
"   buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
"   buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
"   buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
"   buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
" 
"   -- Set some keybinds conditional on server capabilities
"   if client.resolved_capabilities.document_formatting then
"     buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
"   elseif client.resolved_capabilities.document_range_formatting then
"     buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
"   end
" 
"   -- Set autocommands conditional on server_capabilities
"   if client.resolved_capabilities.document_highlight then
"     vim.api.nvim_exec([[
"       hi LspReferenceRead cterm=bold ctermbg=red guibg=LightYellow
"       hi LspReferenceText cterm=bold ctermbg=red guibg=LightYellow
"       hi LspReferenceWrite cterm=bold ctermbg=red guibg=LightYellow
"       augroup lsp_document_highlight
"         autocmd! * <buffer>
"         autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
"         autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
"       augroup END
"     ]], false)
"   end
" end
" 
" -- Use a loop to conveniently both setup defined servers 
" -- and map buffer local keybindings when the language server attaches
" local servers = { "pyright", "rust_analyzer", "tsserver" }
" for _, lsp in ipairs(servers) do
"   nvim_lsp[lsp].setup { on_attach = on_attach }
" end
" EOF

" END LSP system 2
let g:airline_powerline_fonts = 1

" Use builtin netrw instead of NERDTree
" https://shapeshed.com/vim-netrw/
" Hide useless help banner
let g:netrw_banner = 0
" Open in a new vertical split
let g:netrw_browse_split = 1
" Set width to 20%
let g:netrw_winsize = 20

" vim-slime
let g:slime_target = "tmux"
let g:slime_paste_file = tempname()
