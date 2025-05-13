" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


""" BEGIN Vundle plugin config

filetype off                  " required

" Auto-install vim-plug if it isn't already
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" set the plugin path and start vim-plug
call plug#begin('~/.vim/plugged')

" need the 'cs reset' because Fedora autoloads a cscope db if it exists
if has("cscope")
  set nocscopeverbose
  cs kill -1
endif

Plug 'nvim-tree/nvim-tree.lua'
" Prereq for nvim-telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'natecraddock/telescope-zf-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'run': { -> TSUpdate() } }
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'chrisgrieser/nvim-lsp-endhints'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'kevinhwang91/nvim-bqf'
Plug 'vim-scripts/gtk-vim-syntax'
Plug 'preservim/nerdcommenter'
Plug 'terryma/vim-multiple-cursors'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'rhysd/git-messenger.vim'
Plug 'editorconfig/editorconfig-vim'
" For C++
Plug 'rhysd/vim-clang-format', { 'for': 'cpp' }
" For haskell
Plug 'godlygeek/tabular', { 'for': ['haskell', 'purescript', 'elm'] }
Plug 'neovimhaskell/haskell-vim', { 'for': ['haskell', 'purescript', 'elm'] }
Plug 'vmchale/dhall-vim', { 'for': ['dhall'] }
" For nix
Plug 'LnL7/vim-nix', { 'for': 'nix' }
"Plug 'bitc/vim-hdevtools'
" For clojure
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'vim-scripts/paredit.vim', { 'for': 'clojure' }
" For purescript
Plug 'raichoo/purescript-vim', { 'for': 'purescript' }
" For Elm
Plug 'ElmCast/elm-vim', { 'for': 'elm' }
"Plug 'FrigoEU/psc-ide-vim'
" For typescript
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
" For rust
Plug 'cespare/vim-toml', { 'for': 'rust' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" For meson
Plug 'igankevich/mesonic'
" For glsl
Plug 'tikhomirov/vim-glsl'
" Themes
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'embark-theme/vim', { 'as': 'embark' }
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'patstockwell/vim-monokai-tasty'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
" LLMs
Plug 'huggingface/llm.nvim'
Plug 'github/copilot.vim'

" Initialize plugin system
call plug#end()

" Our favourite colorscheme
colorscheme koehler

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

""" END Vundle plugin config


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

set bg=dark
set nobackup
set incsearch
"set foldmethod=syntax

highlight Folded guibg=black guifg=blue
highlight FoldColumn guibg=darkgrey guifg=white

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" Make encryption stronger by default
if !has('nvim')
  set cryptmethod=blowfish2
endif

" Vala stuff
autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala

" Show current function with 'f'
fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map f :call ShowFuncName() <CR>

" From Stephen Diehl's setup

let g:haskell_tabular = 1
vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>
" End Stephen Diehl

" purescript keymappings from their README
"nm <buffer> <silent> <leader>t :<C-U>call Ptype(PgetKeyword(), v:true)<CR>
"nm <buffer> <silent> <leader>T :<C-U>call PaddTypeAnnotation(matchstr(getline(line(".")), '^\s*\zs\k\+\ze'))<CR>
"nm <buffer> <silent> <leader>s :<C-U>call PapplySuggestion()<CR>
"nm <buffer> <silent> <leader>a :<C-U>call PaddTypeAnnotation()<CR>
"nm <buffer> <silent> <leader>i :<C-U>call PimportIdentifier(PgetKeyword())<CR>
"nm <buffer> <silent> <leader>r :<C-U>call Pload()<CR>
"nm <buffer> <silent> <leader>p :<C-U>call Ppursuit(PgetKeyword())<CR>
"nm <buffer> <silent> <leader>C :<C-U>PcaseSplit<SPACE>
"nm <buffer> <silent> <leader>qd :<C-U>call PremoveImportQualifications()<CR>
"nm <buffer> <silent> <leader>qa :<C-U>call PaddImportQualifications()<CR>
"nm <buffer> <silent> ]d :<C-U>call PgoToDefinition(PgetKeyword())<CR>

" nvim-telescope suggested bindings
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Some LSP bindings
nnoremap <leader>gr <cmd>Telescope lsp_references<cr>
nnoremap <leader>gi <cmd>Telescope lsp_implementations<cr>

" Auto-format Rust files on save
let g:rustfmt_autosave = 1

"This unsets the "last search pattern" register by hitting return
nnoremap <BS> :noh<CR>
