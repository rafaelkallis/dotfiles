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

" if hidden is not set, TextEdit might fail.
setlocal hidden

" Some servers have issues with backup files, see #649
setlocal nobackup
setlocal nowritebackup

" Better display for messages
setlocal cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
setlocal updatetime=300

" don't give |ins-completion-menu| messages.
setlocal shortmess+=c

" always show signcolumns
setlocal signcolumn=yes

" better code fold
setlocal foldmethod=syntax
autocmd FileType python setlocal foldmethod=indent
setlocal foldlevelstart=20

" toggle line numbers
nnoremap gn :set number!<CR>

" hide hide
setlocal noshowmode

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

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'OmniSharp/omnisharp-vim'

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

call plug#end()

" coc.nvim
if exists('g:plugs["coc.nvim"]')
  let g:coc_global_extensions = [
  \   'coc-tsserver',
  \   'coc-json',
  \   'coc-eslint',
  \   'coc-prettier',
  \   'coc-jest',
  \   'coc-python',
  \   'coc-java',
  \   'coc-omnisharp',
  \ ]

  nmap <silent> ga <Plug>(coc-codeaction)

  nmap <silent> gf <Plug>(coc-fix-current)

  nmap <silent> ge <Plug>(coc-diagnostic-next)

  nmap <silent> gE <Plug>(coc-diagnostic-prev)
  nmap <silent> GE <Plug>(coc-diagnostic-prev)

  nmap <silent> gd <Plug>(coc-definition)
  
  nmap <silent> gD <Plug>(coc-references)
  nmap <silent> GD <Plug>(coc-references)

  " nmap <silent> gr <Plug>(coc-rename)
  nmap <silent> gr <Plug>(coc-refactor)
  nmap <silent> grf :CocCommand workspace.renameCurrentFile<CR>
  
  nmap <silent> gp <Plug>(coc-format)
  
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction

  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()

  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"
endif

if exists('g:plugs["omnisharp-vim"]')
  let g:OmniSharp_server_stdio = 1
  let g:OmniSharp_highlight_types = 3
endif

" lightline.vim
if exists('g:plugs["lightline.vim"]')
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

  autocmd User CocDiagnosticChange call lightline#update()

  function! CocErrors()
    if !exists('b:coc_diagnostic_info')
      return ''
    endif
    if b:coc_diagnostic_info['error'] == 0
      return ''
    endif
    return b:coc_diagnostic_info['error']
  endfunction

  function! CocWarnings()
    if !exists('b:coc_diagnostic_info')
      return ''
    endif
    if b:coc_diagnostic_info['warning'] == 0
      return ''
    endif
    return b:coc_diagnostic_info['warning']
  endfunction

  function! CocOk()
    if !exists('b:coc_diagnostic_info') 
      return ''
    elseif b:coc_diagnostic_info['warning'] > 0
      return ''
    elseif b:coc_diagnostic_info['error'] > 0
      return ''
    endif
    return 'OK'
  endfunction

  let g:lightline.component_function = {
        \   'gitbranch': 'gitbranch#name',
        \   'coc_ok': 'CocOk',
        \ }

  let g:lightline.component_expand = {
        \   'coc_warnings': 'CocWarnings',
        \   'coc_errors': 'CocErrors',
        \ }
  let g:lightline.component_type = {
        \  'coc_warnings': 'warning',
        \  'coc_errors': 'error',
        \ }
  let g:lightline.active = {
        \   'left': [
        \     ['mode', 'coc_errors', 'coc_warnings'],
        \     ['coc_ok'],
        \   ],
        \   'right': [
        \     ['readonly', 'modified'],
        \     ['filename'],
        \     ['gitbranch'],
        \   ],
        \ }
endif

" ale
if exists('g:plugs["ale"]')
  let g:ale_echo_msg_format = '%s'
  
  let g:ale_fixers = {
  \   'javascript': ['eslint', 'prettier'],
  \   'typescript': ['eslint', 'prettier'],
  \   'cpp': ['clang-format'],
  \   'python': ['autopep8'],
  \ } 

  let g:ale_lint_delay = 0
  " lint on file open
  let g:ale_lint_on_enter = 1
  let g:ale_lint_on_filetype_changed = 0
  let g:ale_lint_on_insert_leave = 1
  let g:ale_lint_on_save = 0
  let g:ale_lint_on_text_changed = 'never'
   
  nnoremap gf :ALEFix<CR>
  nnoremap ge :ALENextWrap<CR>
  nnoremap gE :ALEPreviousWrap<CR>
  nnoremap gd :ALEGoToDefinition<CR>
  nnoremap gD :ALEFindReferences<CR>
  nnoremap gh :ALEHover<CR>
  nnoremap gr :ALERename<CR>

  " let g:ale_completion_tsserver_autoimport = 1
  " set omnifunc=ale#completion#OmniFunc

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
