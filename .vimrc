" taken from: http://github.com/dsturnbull/dotfiles/blob/master/.vimrc

" vim:filetype=vim
" inspiration: http://github.com/foot/dotfiles/tree/master/.vimrc


"

call plug#begin($HOME.'/.vim/plugged')
Plug 'tpope/vim-fugitive'
Plug 'msanders/snipmate.vim'
Plug 'kien/ctrlp.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'othree/html5.vim'
Plug 'sjl/gundo.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'jistr/vim-nerdtree-tabs', { 'on': 'NERDTreeToggle' }
Plug 'Raimondi/delimitMate'
Plug 'briandoll/change-inside-surroundings.vim'
Plug 'bling/vim-airline'
Plug 'edkolev/promptline.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'rust-lang/rust.vim'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
call plug#end()

set nocompatible
set backspace=indent,eol,start

" indentation
filetype plugin indent on

" colours
syntax on
colorscheme Sunburst
" change parenthesis matching to a different color than the cursor
highlight MatchParen guibg=#2A2A2A guifg=#F0F0F0 "

set noswapfile
set encoding=utf8

" enable mouse scrolling
set mouse=a

"set expandtab					  " insert spaces instead of tabs when <TAB> is pressed
set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent                    " current line indent carries to next line
set smartindent                   " also pay attention to syntax
set shiftround                    " round indent to multiple of sw
set laststatus=2				  " always show status line
set scrolloff=7                   " always ensure 7 lines are visible above/below cursor when scrolling
set sidescrolloff=10              " ensure at least 10 characters are visible when horizontally scrolling

set nowrap
set linebreak
set textwidth=0
set wrapmargin=0
set showtabline=2                 " always
set wildmode=list:longest,full    " completion style when opening files

" autoindent
set formatoptions+=r              " keep autoindent for <CR>
set formatoptions-=o              " but stop it when o/O
"set formatoptions+=t              " autowrap text to textwidth

" folding
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default

" 'set list' will show special chars as the following
set listchars=eol:¬,tab:▸\ ,nbsp:·,trail:·,extends:⇢,precedes:⇠
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
" apply muted colors to special chars
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

" use PCRE regex for searches
nnoremap / /\v
vnoremap / /\v

" smart search case sensitivity
set ignorecase
set smartcase

" apply substitutions globally per line
" set gdefault
set nogdefault

" highlight search results
set incsearch
set showmatch
set hlsearch

" shortcut to end search highlighting
nnoremap <leader><space> :noh<cr>

" TAB matches bracket pairs
nnoremap <tab> %
vnoremap <tab> %

" buffer shortcuts
" press <F5> to bring up a menu of buffers
" noremap <F5> :buffers<CR>:buffer<Space>

" activate html snippets on .php files
au BufNewFile,BufRead *.php setlocal filetype=php.html
au BufNewFile,BufRead *.as    setlocal filetype=actionscript
au BufRead,BufNewFile *.json  setlocal filetype=javascript

au BufNewFile,BufRead *.md	setlocal filetype=markdown

" move windows easily
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap <C-j> <C-w>j

" export powerline symbols
let g:airline_powerline_fonts = 1

" move up/down based on visual, not actual lines (for word wrap)
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" indent/dedent with >< without losing hightlighted text
vnoremap < <gv
vnoremap > >gv

" easily escape insert mode
inoremap jj <Esc>`^
inoremap JJ <Esc>`^

" use w!! to sudo save if forgot to open the file with sudo
cnoremap w!! %!sudo tee > /dev/null %

" restore position in a file
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal g'\"" | endif

" persistent undos
if has('persistent_undo')
	set undofile "so is persistent undo ...
	set undolevels=1000 "maximum changes to undone
	set undoreload=10000 "maximum number lines to save
	set undodir=~/.vim/undo
endif

" allow unsaved edited buffers to exist in the background
set hidden

" ctrlP invocation, search Files 
map <Leader>p :CtrlP<cr>
" search open buffers
map <Leader>b :CtrlPBuffer<cr>

" ctrlP ignore
let g:ctrlp_custom_ignore='\$\|\.hg$\|\.svn$'
let g:ctrlp_max_files=20000
" nearest ancestor that contains , .svn, .hg, .bzr, _darcs
let g:ctrlp_working_path_mode='r'

" kill the arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" line numbers
set number
"set relativenumber

" <Leader>mm generates multimarkdown via marked 
" :w !command		pipes output of :w into command
map <Leader>mm <Esc>:w !marked --output=%.html && open %.html<CR><CR>

" <Leader>vi reloads vimrc
map <Leader>vi :so $MYVIMRC<CR>

" show syntax highlighting groups for syntax debugging
map <Leader>hg :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
	\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
	\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" gundo invocation
nnoremap <Leader>u :GundoToggle<CR>

" NERDTree w/ tabs
map <Leader>e <plug>NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_autoclose=0

" Convert all leading spaces to tabs (default range is whole file):
" :Space2Tab
" Convert lines 11 to 15 only (inclusive):
" :11,15Space2Tab
" Convert last visually-selected lines:
" :'<,'>Space2Tab
" Same, converting leading tabs to spaces:
" :'<,'>Tab2Space
:command! -range=% -nargs=0 Tab2Space execute '<line1>,<line2>s#^\t\+#\=repeat(" ", len(submatch(0))*' . &ts . ')'
:command! -range=% -nargs=0 Space2Tab execute '<line1>,<line2>s#^\( \{'.&ts.'\}\)\+#\=repeat("\t", len(submatch(0))/' . &ts . ')'

" leader +/- moves to next buffer or prev
:map <Leader>= :bnext<CR>
:map <Leader>- :bprevious<CR>

" Leader h/H html escapes/unescapes
function! HtmlEscape()
  silent s/&/\&amp;/eg
  silent s/</\&lt;/eg
  silent s/>/\&gt;/eg
endfunction

function! HtmlUnEscape()
  silent s/&lt;/</eg
  silent s/&gt;/>/eg
  silent s/&amp;/\&/eg
endfunction

nnoremap <Leader>h :call HtmlEscape()<CR>
nnoremap <Leader>H :call HtmlUnEscape()<CR>
" end html escape helper

" Remove Trailing Whitespace
fun! <SID>StripTrailingWhitespaces()
	let _s=@/			"save search pos
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
	let @/=_s			"restore search pos
endfun

nnoremap <Leader>ws :call <SID>StripTrailingWhitespaces()<CR>
" end Remove Trailing Whitespace

" Highlight trailing whitespace only when opening file or leaving insert mode
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/
" end Highlight trailing whitespace

" Quickly switch to 2space indents
function! TabIs2Spaces()
	setlocal expandtab
	setlocal tabstop=2
	setlocal softtabstop=2
	setlocal shiftwidth=2
endfunction

" Quickly switch to 4space tab indents
function! TabIs4CharTab()
	setlocal noexpandtab
	setlocal tabstop=4
	setlocal softtabstop=4
	setlocal shiftwidth=4
endfunction

command! -nargs=0 TabIs2Spaces call TabIs2Spaces()
command! -nargs=0 T2 call TabIs2Spaces()
command! -nargs=0 TabIs4CharTab call TabIs4CharTab()
command! -nargs=0 T4 call TabIs4CharTab()

" Ensure rls exists. It is only compatible with vim8
if executable('rls') && (v:version >= 800)
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

