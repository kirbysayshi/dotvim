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
colorscheme sunburst
" change parenthesis matching to a different color than the cursor
highlight MatchParen guibg=#2A2A2A guifg=#F0F0F0

set noswapfile
set encoding=utf8

set expandtab					  " insert spaces instead of tabs when <TAB> is pressed
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

" buffer shortcuts
" press <F5> to bring up a menu of buffers
" noremap <F5> :buffers<CR>:buffer<Space>

" activate html snippets on .php files
au BufNewFile,BufRead *.php setlocal filetype=php.html
au BufNewFile,BufRead *.as    setlocal filetype=actionscript
au BufRead,BufNewFile *.json  setlocal filetype=javascript

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
