" taken from: http://github.com/dsturnbull/dotfiles/blob/master/.vimrc

" vim:filetype=vim
" inspiration: http://github.com/foot/dotfiles/tree/master/.vimrc

set nocompatible                  " yeah

" enable pathogen!
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" colours
syntax on
colorscheme sunburst

" set global backup and swp folders to avoid clutter
" silent execute '!mkdir "'.$HOME.'/.backup/vimbackup"'
" silent execute '!mkdir "'.$HOME.'/.backup/vimswp"'
" set backupdir=$HOME/.backup/vimbackup//
" set directory=$HOME/.backup/vimswp//
set nobackup

" change parenthesis matching to a different color than the cursor
highlight MatchParen guibg=#2A2A2A guifg=#F0F0F0

set encoding=utf8

if has("win32")
	set shell=cmd.exe
	set shellcmdflag=/c\ powershell.exe\ -NoLogo\ -NoProfile\ -NonInteractive\ -ExecutionPolicy\ RemoteSigned
	set shellpipe=|
	set shellredir=>
endif

" options
set expandtab					  " insert spaces instead of tabs when <TAB> is pressed
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent                    " current line indent carries to next line
set smartindent                   " also pay attention to syntax
set shiftround                    " round indent to multiple of sw
set hidden                        " do not unload buffers which go out of visibility
set backspace=indent,eol,start    " backspace multi lines
set viminfo='100,f1               " marks remembered for 100 files, enable mark storing
set laststatus=2				  " ?? for smarter statusline

"set wrap                          " for julio
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

" buffer shortcuts
" press <F5> to bring up a menu of buffers
" noremap <F5> :buffers<CR>:buffer<Space>

" activate html snippets on .php files
au BufRead *.php set ft=php.html
au BufNewFile *.php set ft=php.html

" yes
" set textwidth=79
"match ErrorMsg '\%>80v.\+'
"au BufWinEnter * let w:m1=matchadd('ErrorMsg', '\%>80v.\+', -1)

" use c-a in command mode
cnoremap <C-a> <Home>

" git/svn blame - \g/\s on a visual block - FIXME svn blame not working
vmap <Leader>g :<C-u>!git blame <C-r>=expand("%") <CR> \| sed -n <C-r>=line("'<") <CR>,<C-r>=line("'>") <CR>p <CR>
vmap <Leader>s :<C-u>!svn blame <C-r>=expand("%") <CR> \| sed -n <C-r>=line("'<") <CR>,<C-r>=line("'>") <CR>p <CR>

" move windows easily
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
noremap <C-j> <C-w>j

" slide text around
" imap <Up>    <Esc>:m-2<CR>gi
" imap <Down>  <Esc>:m+<CR>gi

" nmap <Up>    mz:m-2<CR>`z
" nmap <Down>  mz:m+<CR>`z

" vmap <Up>    :m'<-2<CR>gv
" vmap <Down>  :m'>+<CR>gv
" vmap <Left>  :<<CR>gv
" vmap <Right> :><CR>gv

" set paste! - keybindings
map <leader>p :set paste!<CR>

" indentation
filetype plugin indent on

aug init
  au FileType ruby       let g:rubycomplete_rails=1
  au FileType ruby       let g:rubycomplete_classes_in_global=1

  au BufNewFile,BufRead *.as    setlocal filetype=actionscript
  au BufRead,BufNewFile *.json  setlocal filetype=javascript
aug END

" don't save options in view
set viewoptions-=options

" autosave folds
au BufWinLeave * nested silent! mkview
au BufWinEnter * nested silent! loadview


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


" camel case motion overrides
nmap <silent> <Space> <Plug>CamelCaseMotion_w
omap <silent> <Space> <Plug>CamelCaseMotion_w
vmap <silent> <Space> <Plug>CamelCaseMotion_w

nmap <silent> <BS> <Plug>CamelCaseMotion_b
omap <silent> <BS> <Plug>CamelCaseMotion_b
vmap <silent> <BS> <Plug>CamelCaseMotion_b

omap <silent> i<Space> <Plug>CamelCaseMotion_iw
vmap <silent> i<Space> <Plug>CamelCaseMotion_iw
omap <silent> i<BS>    <Plug>CamelCaseMotion_ib
vmap <silent> i<BS>    <Plug>CamelCaseMotion_ib

" omni fail
imap <C-]> <C-x><C-]>
inoremap <expr> <C-d> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" align commas nicely
" FIXME it's bad
function! AlignCommasNicely()
  exec ":AlignCtrl =Wl"
  exec ":%Align ,"
  exec ":%s/\\([ ]\\+\\),/,\\1/g"
endfunction
command! AC :call AlignCommasNicely()

" move up/down based on visual, not actual lines (for word wrap)
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" tab hax
nmap <silent> <C-n> :tabn<CR>
nmap <silent> <C-p> :tabp<CR>
" swap tag stack pop with tabnew
nmap <C-BSlash> :po<CR>
nmap <silent> <C-t> :tabnew<CR>

" ptag
nmap <Leader>\ :ptag <C-r>=expand("<cword>")<CR><CR>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

""""""""""""""""""""""""""""""
" => Command-T
""""""""""""""""""""""""""""""
try
  let g:CommandTMaxHeight = 15
  set wildignore+=*.o,*.obj,.git,*.pyc
catch
endtry

" indent/dedent with >< without losing hightlighted text
vnoremap < <gv
vnoremap > >gv
