" Maintainer: Rafael Kallis <rafaelkallis.com>

" Keybindings:
"   gd: go to identifier (D)efinition
"   ge: go to next (E)rror
"   gf: (F)ix errors
"   gl: toggle (L)inter
"   gn: toggle line (N)umbers
"   go: search and (O)pen file
"   gq: (Q)uit normal mode
"   gr: (R)ename identifier

" insert spaces when tab is pressed
setlocal expandtab

" insert 2 spaces per tab
setlocal tabstop=2

" number of space characters for indentation
setlocal shiftwidth=2

" backspace deletes 2 characters
setlocal softtabstop=2

" don't break lines
setlocal nowrap

" better code fold
setlocal foldmethod=syntax
autocmd FileType python setlocal foldmethod=indent
setlocal foldlevelstart=20

" quit insert mode
inoremap gq <Esc>

" toggle line numbers
nnoremap gn :set number!<CR>

" hide hide
set noshowmode

" install vim-plug if it doesn't exist
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" install plugins that are missing
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

call plug#begin('~/.vim/plugged')

Plug 'ajh17/vimcompletesme'
Plug 'autozimu/languageclient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'w0rp/ale'
Plug 'chaoren/vim-wordmotion'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tmhedberg/simpylfold', {'for': 'python'}
Plug 'shougo/vimproc.vim', {'do': 'make'}
Plug 'djoshea/vim-autoread'
Plug 'itchyny/lightline.vim'

call plug#end()

" ale
if exists('g:plugs["ale"]')
  let g:ale_fixers = {} 
  let g:ale_fixers.javascript = ['eslint']
  let g:ale_fixers['javascript.jsx'] = ['eslint']
  let g:ale_fixers.typescript = ['tslint']
  let g:ale_fixers.cpp = ['clang-format']
  let g:ale_fixers.python = ['autopep8']
   
  nnoremap gl :ALEToggle<CR>
  nnoremap gf :ALEFix<CR>
  nnoremap ge :ALENextWrap<CR>
endif

" languageclient-neovim
if exists('g:plugs["languageclient-neovim"]')
  nnoremap gm :call LanguageClient_contextMenu()<CR>
  nnoremap gr :call LanguageClient#textDocument_rename()<CR>
  nnoremap gd :call LanguageClient#textDocument_definition()<CR>
  nnoremap gh :call LanguageClient#textDocument_hover()<CR>
  nnoremap gpc :pclose<CR>
  
	let g:LanguageClient_serverCommands = {}

  " c, c++
  " yay --sync llvm
  let g:LanguageClient_serverCommands.c = ['clangd']
  let g:LanguageClient_serverCommands.cpp = ['clangd']
  if !executable('clangd')
    echo 'clangd not installed'
  endif

  " javascript, typescript, jsx
  " npm install --global javascript-typescript-langserver
  let g:LanguageClient_serverCommands.javascript = ['javascript-typescript-stdio']
  let g:LanguageClient_serverCommands['javascript.jsx'] = ['javascript-typescript-stdio']
  let g:LanguageClient_serverCommands.typescript = ['javascript-typescript-stdio']
  if !executable('javascript-typescript-langserver')
    echo 'javascript-typescript-langserver not installed'
  endif

  " python
  " pip install --user python-language-server
  let g:LanguageClient_serverCommands.python = ['pyls']
  if !executable('pyls')
    echo 'pyls not installed'
  endif

  " java
  " yay --sync jdtls
  let g:LanguageClient_serverCommands.java = ['jdtls']
  if !executable('jdtls')
    echo 'jdtls not installed'
  endif

  " go
  " go get -u github.com/sourcegraph/go-langserver
  let g:LanguageClient_serverCommands.go = ['go-langserver']
  if !executable('go-langserver')
    echo 'go-langserver not installed'
  endif

  " rust
  " yay --sync rustup
  let g:LanguageClient_serverCommands.rust = ['rustup', 'run', 'stable', 'rls']
  if !executable('rustup')
    echo 'rustup not installed'
  endif
endif

" vim-wordmotion
if exists('g:plugs["vim-wordmotion"]')
  let g:wordmotion_mappings = {
    \ 'ge' : '',
    \ }
endif

" vim-polyglot
if exists('g:plugs["vim-polyglot"]')
  " Syntax Highlighting javascript jsdoc
  let g:javascript_plugin_jsdoc = 1
endif

" ctrlp.vim
if exists('g:plugs["ctrlp.vim"]')
  nmap go :CtrlP<CR>
  let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|svn'
endif

if exists('g:plugs["lightline.vim"]')
  " let g:lightline = {
  "       \ 'colorscheme': 'wombat',
  "       \ }
endif
