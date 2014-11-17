scriptencoding utf-8
set encoding=utf-8

set nocompatible
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif


NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'itchyny/lightline.vim'


NeoBundle 'chase/vim/ansible-yaml'
NeoBundle 'mitsuhiko/vim-jinja'
NeoBundle 'evanmiller/nginx-vim-syntax'
NeoBundle 'vim-ruby/vim-ruby'

filetype plugin indent on

let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ },
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? "\u2b64" : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
	  \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
	  \  &ft == 'unite' ? unite#get_status_string() :
	  \  &ft == 'vimshell' ? vimshell#get_status_string() :
	  \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
	  \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction


function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction


function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction


function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction


function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction


set laststatus=2
set t_Co=256

syntax on
set number

set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

