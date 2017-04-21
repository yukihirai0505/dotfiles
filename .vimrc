" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible
endif

" Required:
set runtimepath+=~/.vim/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache.git'
NeoBundle 'Shougo/neosnippet.git'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'derekwyatt/vim-scala.git'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'szw/vim-tags'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'vim-scripts/errormarker.vim.git'
NeoBundle 'wincent/Command-T'
NeoBundle 'gre/play2vim'
NeoBundle 'othree/html5.vim'


" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" display
set showmatch
set number
set ruler
set cursorline
" indent
set smartindent
set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
" etc
set smartcase
set history=50
syntax enable

" colorschehme
set background=dark
colorscheme solarized

" neocomplcache
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'scala' : $HOME . '/.vim/dict/scala.dict',
    \ }

" neosnippet
"   Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
"   SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"   For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
let g:neosnippet#snippets_directory='~/.vim/snippets'

" vimsehll
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt = $USER."% "
"vimshell map
nmap vs :VimShell<CR>
nmap vp :VimShellPop<CR>

" make
autocmd FileType scala :compiler sbt
autocmd QuickFixCmdPost make if len(getqflist()) != 0 | copen | endif

" marker
let g:errormarker_errortext     = '!!'
let g:errormarker_warningtext   = '??'
let g:errormarker_errorgroup    = 'Error'
let g:errormarker_warninggroup  = 'ToDo'

" TagBar
nmap <F8> :TagbarToggle<CR>

" NERDTree
nmap <silent> <C-e> :NERDTreeToggle<CR>
vmap <silent> <C-e> <Esc> :NERDTreeToggle<CR>
omap <silent> <C-e> :NERDTreeToggle<CR>
imap <silent> <C-e> <Esc> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let g:NERDTreeShowHidden=1

" vim-tags
nnoremap <C-]> g<C-]>

""""""""""""""""""""""""""""""""
"  Key Maps -- Command-T
""""""""""""""""""""""""""""""""
let s:commandTHeight=18
let g:CommandTMaxHeight=s:commandTHeight
let g:CommandTMinHeight=s:commandTHeight
let g:CommandTClearMap=['<C-u>', '<C-w>']
let g:CommandTCancelMap=['<C-[>', '<C-c>', '<Esc>']
let g:CommandTMaxDepth=20
nnoremap  ,t :CommandTFlush<CR>\|:CommandT<Space><UP>
nnoremap  <silent> ,l :CommandTFlush<CR>\|:CommandT<CR>
nnoremap  <silent> ,b :CommandTFlush<CR>\|:CommandTBuffer<CR>

" indent-guides
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 1
