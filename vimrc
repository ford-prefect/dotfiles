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

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" need the 'cs reset' because Fedora autoloads a cscope db if it exists
set nocscopeverbose
cs kill -1

Plugin 'steffanc/cscopemaps.vim'
Plugin 'gtk-vim-syntax'
Plugin 'honza/vim-snippets.git'
Plugin 'gobgen'
Plugin 'vim-syntastic/syntastic'
Plugin 'Shougo/neocomplete.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'w0rp/ale'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'tpope/vim-fugitive'
" For C++
Plugin 'rhysd/vim-clang-format'
" For haskell
Plugin 'eagletmt/neco-ghc'
Plugin 'Shougo/vimproc' " For ghcmod-vim
Plugin 'eagletmt/ghcmod-vim'
Plugin 'Tabular'
Plugin 'itchyny/vim-haskell-indent'
"Plugin 'bitc/vim-hdevtools'
" For clojure
Plugin 'tpope/vim-fireplace'
Plugin 'paredit.vim'
" For purescript
Plugin 'raichoo/purescript-vim'
Plugin 'FrigoEU/psc-ide-vim'
" For rust
Plugin 'cespare/vim-toml'
Plugin 'rust-lang/rust.vim'
" Themes
Plugin 'altercation/vim-colors-solarized'

" All of your Plugins must be added before the following line

call vundle#end()            " required
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
set cryptmethod=blowfish2

" Vala stuff
autocmd BufRead *.vala set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
autocmd BufRead *.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala            setfiletype vala
au BufRead,BufNewFile *.vapi            setfiletype vala

" Default indentations
autocmd BufRead,BufNewFile */gst-*/*.[ch] set et sw=2
autocmd BufRead,BufNewFile */gstreamer-*/*.[ch] set et sw=2
autocmd BufRead,BufNewFile */gupnp-*/*.[ch] set et
autocmd BufRead,BufNewFile */pulseaudio/*.[ch] set et sw=4 tw=128
autocmd BufRead,BufNewFile */ansible/*.yml set et sw=2
autocmd BufRead,BufNewFile *.hs set et sw=2 sts=2 si
autocmd BufRead,BufNewFile *.purs set et sw=2 sts=2 si

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

" ale settings
let g:ale_lint_on_text_changed = 'never'
let g:ale_sign_column_always = 1
" too painful at the moment to run on C/C++ projects
let g:ale_pattern_options = {
\  '\.c$': {'ale_linters': [], 'ale_fixers': []},
\  '\.cc$': {'ale_linters': [], 'ale_fixers': []},
\  '\.cpp$': {'ale_linters': [], 'ale_fixers': []},
\}

" syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" From Stephen Diehl's setup
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

let g:haskell_tabular = 1

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>
" End Stephen Diehl

" Disable C and C++ since include files are a pain
let g:syntastic_mode_map = {
			\ "mode": "active",
			\ "passive_filetypes": ["c", "cpp"]
			\ }
" drop only ghc-mod, superseded by ghcmod-vim
"let g:syntastic_haskell_checkers = ["hdevtools", "hlint"]
let g:syntastic_haskell_checkers = ["hlint"]

" neocompletion settings
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" purescript keymappings from their README
nm <buffer> <silent> <leader>t :<C-U>call Ptype(PgetKeyword(), v:true)<CR>
nm <buffer> <silent> <leader>T :<C-U>call PaddTypeAnnotation(matchstr(getline(line(".")), '^\s*\zs\k\+\ze'))<CR>
nm <buffer> <silent> <leader>s :<C-U>call PapplySuggestion()<CR>
nm <buffer> <silent> <leader>a :<C-U>call PaddTypeAnnotation()<CR>
nm <buffer> <silent> <leader>i :<C-U>call PimportIdentifier(PgetKeyword())<CR>
nm <buffer> <silent> <leader>r :<C-U>call Pload()<CR>
nm <buffer> <silent> <leader>p :<C-U>call Ppursuit(PgetKeyword())<CR>
nm <buffer> <silent> <leader>C :<C-U>PcaseSplit<SPACE>
nm <buffer> <silent> <leader>qd :<C-U>call PremoveImportQualifications()<CR>
nm <buffer> <silent> <leader>qa :<C-U>call PaddImportQualifications()<CR>
nm <buffer> <silent> ]d :<C-U>call PgoToDefinition(PgetKeyword())<CR>

" Ignore files from .gitignore in ctrl-p
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co -X .gitignore --exclude-standard']

" Auto-format Rust files on save
let g:rustfmt_autosave = 1

" needed for neocomplete to not break multiple cursors
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
  if exists(':NeoCompleteLock')==2
    exe 'NeoCompleteLock'
  endif
endfunction

" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
  if exists(':NeoCompleteUnlock')==2
    exe 'NeoCompleteUnlock'
  endif
endfunction

"This unsets the "last search pattern" register by hitting return
nnoremap <BS> :noh<CR>
