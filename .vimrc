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

let g:ale_completion_enabled = 1

call plug#begin('~/.vim/plugged')

Plug 'w0rp/ale'

Plug 'chaoren/vim-wordmotion'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'tmhedberg/simpylfold', {'for': 'python'}
Plug 'djoshea/vim-autoread'
Plug 'itchyny/lightline.vim'

" Plug 'airblade/vim-rooter'

call plug#end()

" ale
if exists('g:plugs["ale"]')
  let g:ale_fixers = {} 
  let g:ale_fixers.javascript = ['eslint', 'prettier']
  let g:ale_fixers['javascript.jsx'] = ['eslint', 'prettier']
  let g:ale_fixers.typescript = ['tslint', 'prettier']
  let g:ale_fixers.cpp = ['clang-format']
  let g:ale_fixers.python = ['autopep8']
   
  nnoremap gl :ALEToggle<CR>
  nnoremap gf :ALEFix<CR>
  nnoremap ge :ALENextWrap<CR>
  nnoremap gd :ALEGoToDefinition<CR>
  nnoremap gh :ALEHover<CR>
  " nnoremap gr :<CR>

  set omnifunc=ale#completion#OmniFunc

  highlight ALEError ctermfg=red ctermbg=NONE
  let g:ale_sign_error = '●'
  highlight ALEErrorSign ctermbg=NONE ctermfg=red

  highlight ALEWarning ctermfg=yellow ctermbg=NONE
  let g:ale_sign_warning = '●'
  highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

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
