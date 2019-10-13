" Maintainer: Rafael Kallis <rafaelkallis.com>

" Keybindings:
"   ge: go to next (E)rror
"   gf: (F)ix errors
"   gn: toggle line (N)umbers
"   gr: (R)ename identifier
"   gd: go to identifier (D)efinition

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

" let g:ale_completion_enabled = 1

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
Plug 'sjl/vitality.vim'

Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-gitbranch'
Plug 'maximbaz/lightline-ale'

Plug 'marcweber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'

call plug#end()

" ale
if exists('g:plugs["ale"]')
  let g:ale_echo_msg_format = '%s'
  
  let g:ale_fixers = {
  \   'javascript': ['eslint', 'prettier'],
  \   'typescript': ['eslint', 'prettier'],
  \   'cpp': ['clang-format'],
  \   'python': ['autopep8'],
  \ } 
   
  nnoremap gf :ALEFix<CR>
  nnoremap ge :ALENextWrap<CR>
  nnoremap gd :ALEGoToDefinition<CR>
  nnoremap gh :ALEHover<CR>

  set omnifunc=ale#completion#OmniFunc

  highlight ALEError ctermfg=red ctermbg=NONE
  let g:ale_sign_error = '●'
  highlight ALEErrorSign ctermbg=NONE ctermfg=red

  highlight ALEWarning ctermfg=yellow ctermbg=NONE
  let g:ale_sign_warning = '●'
  highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

endif

" vim-wordmotion
let g:wordmotion_mappings = {
\   'ge': '',
\ }

" vim-polyglot
" Syntax Highlighting javascript jsdoc
let g:javascript_plugin_jsdoc = 1

" lightline.vim
let g:lightline = {}
let g:lightline.mode_map = {
\   'n': 'NOR',
\   'i': 'INS',
\   'R': 'REP',
\   'v': 'VIS',
\   'V': 'V-L',
\   "\<C-v>": 'V-B',
\ }
let g:lightline.colorscheme = 'wombat'
let g:lightline.component_function = {
\   'gitbranch': 'gitbranch#name',
\ }
let g:lightline.component_expand = {
\  'linter_checking': 'lightline#ale#checking',
\  'linter_warnings': 'lightline#ale#warnings',
\  'linter_errors': 'lightline#ale#errors',
\  'linter_ok': 'lightline#ale#ok',
\ }
let g:lightline.component_type = {
\  'linter_checking': 'left',
\  'linter_warnings': 'warning',
\  'linter_errors': 'error',
\  'linter_ok': 'left',
\ }
let g:lightline.active = {
\   'left': [['mode', 'linter_errors', 'linter_warnings', 'linter_ok']],
\   'right': [
\      ['readonly', 'modified'],
\      ['filename'],
\      ['gitbranch'],
\   ],
\ }
let g:lightline#ale#indicator_warnings = ''
let g:lightline#ale#indicator_errors = ''
