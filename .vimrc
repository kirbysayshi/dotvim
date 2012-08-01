" taken from: http://github.com/dsturnbull/dotfiles/blob/master/.vimrc

" vim:filetype=vim
" inspiration: http://github.com/foot/dotfiles/tree/master/.vimrc

set nocompatible

" enable pathogen!
call pathogen#infect()

" indentation
filetype plugin indent on

" colours
syntax on
colorscheme Sunburst
" change parenthesis matching to a different color than the cursor
highlight MatchParen guibg=#2A2A2A guifg=#F0F0F0 " 

set noswapfile
set encoding=utf8

"set expandtab					  " insert spaces instead of tabs when <TAB> is pressed
set noexpandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent                    " current line indent carries to next line
set smartindent                   " also pay attention to syntax
set shiftround                    " round indent to multiple of sw
set laststatus=2				  " always show status line

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
set gdefault

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

" START http://www.reddit.com/r/vim/comments/gexi6/a_smarter_statusline_code_in_comments/
hi StatColor guibg=#95e454 guifg=black ctermbg=lightgreen ctermfg=black
hi Modified guibg=orange guifg=black ctermbg=lightred ctermfg=black

function! MyStatusLine(mode)
    let statusline=""
    if a:mode == 'Enter'
        let statusline.="%#StatColor#"
    endif
    let statusline.="\(%n\)\ %f\ "
    if a:mode == 'Enter'
        let statusline.="%*"
    endif
    let statusline.="%#Modified#%m"
    if a:mode == 'Leave'
        let statusline.="%*%r"
    elseif a:mode == 'Enter'
        let statusline.="%r%*"
    endif
    let statusline .= "\ (%l/%L,\ %c)\ %P%=%h%w\ %y\ [%{&encoding}:%{&fileformat}]\ \ "
    return statusline
endfunction

au WinEnter * setlocal statusline=%!MyStatusLine('Enter')
au WinLeave * setlocal statusline=%!MyStatusLine('Leave')
set statusline=%!MyStatusLine('Enter')

function! InsertStatuslineColor(mode)
  if a:mode == 'i'
    hi StatColor guibg=orange ctermbg=lightred
  elseif a:mode == 'r'
    hi StatColor guibg=#e454ba ctermbg=magenta
  elseif a:mode == 'v'
    hi StatColor guibg=#e454ba ctermbg=magenta
  else
    hi StatColor guibg=red ctermbg=red
  endif
endfunction 

au InsertEnter * call InsertStatuslineColor(v:insertmode)
au InsertLeave * hi StatColor guibg=#95e454 guifg=black ctermbg=lightgreen ctermfg=black
" END 

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
let g:ctrlp_custom_ignore='\.git$\|\.hg$\|\.svn$'
let g:ctrlp_max_files=20000
" nearest ancestor that contains .git, .svn, .hg, .bzr, _darcs
let g:ctrlp_working_path_mode=2

" kill the arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>

" line numbers
set number
set relativenumber

" <Leader>mm generates multimarkdown via maruku
" :w !command		pipes output of :w into command
map <Leader>mm <Esc>:w !maruku --output=%.html && open %.html<CR><CR>

" <Leader>vi reloads vimrc
map <Leader>vi :so $MYVIMRC<CR>

" show syntax highlighting groups for syntax debugging
map <Leader>hg :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
	\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
	\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
