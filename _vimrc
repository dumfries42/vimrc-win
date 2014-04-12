"fofore's vimrc
"Minming Qian <qianminming@gmail.com> www.fofore.com
"Fork me in GITHUB https://github.com/fofore/vimrc

"For pathogen.vim :auto load all plugins in 'vimpath'/bundle

let g:pathogen_disabled = [] 
if !has('gui_running')
	call add(g:pathogen_disabled, 'powerline')
endif 

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" General Settings

set nocompatible            " not compatible with the old-fashion vi mode
set bs=2                    " allow backspacing over everything in insert mode
set history=50              " keep 50 lines of command line history
set ruler                   " show the cursor position all the time
set autoread                " auto read when file is changed from outside
set nowrap                  " wrat setting
set textwidth=1000           " set the max textwith
set columns=86              " fit for the vimrc and looks good  "
set lines=52

filetype on                 " Enable filetype detection
filetype indent on          " Enable fileytpe-specific indenting
filetype plugin on          " Enable filetype-specific plugins


" auto reload _vimrc when editing it
if has('win32')
    autocmd! bufwritepost _vimrc source $VIM\_vimrc
else
    autocmd! bufwritepost .vimrc source ~/.vimrc
endif

syntax enable
syntax on                   " syntax highlight
set hlsearch                " search highlighting

" GUI color and font settings
if has('gui_running')
    colors moria
    set cursorline          " highlight current line
    highlight CursorLine    guibg=#003853 ctermbg=24 gui=none cterm=none
    set guioptions-=m       "hide the menu toolbar
    set guioptions-=T       "hide the tool toolbar
    set guioptions-=r       "hide the ride scroll bar
    set guioptions-=L       "hide the left scroll bar
    set guifont=Mensch\ for\ Powerline:h10
else
" terminal color settings
    colors vgod
endif


" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

set autochdir
set nu                      " show line number 
set clipboard=unnamed       " yank to the system register (*)  by default
set showmatch               " Cursor shows matching ) and }
set showmode                " show current mode
set wildchar=<TAB>          " start wild expansion in the command linpathogene using <TAB>
set wildmenu                " wild char completion menu

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc


set autoindent              " auto indentation 1314
set incsearch               " incremental search
set copyindent              " copy the previous indentation on autoindenting
set ignorecase              " ignore case when searching
set smartcase               " ignore case if search pattern is all lowercase,case-sensitive othterwise
set smarttab                " insert tabs on the start of a line according to context


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""F11"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Use spaces instead of tabs
set expandtab

"1 tab == 4spaces
set tabstop=4               " tab length
set shiftwidth=4            
set smartindent
set wrap
"when input the tab in python or some place automaticaly, input the >- symbols
set list
set listchars=tab:>-

autocmd Filetype Makefile set noexpandtab

" status line by powerline {
set laststatus=2
if !has('gui_running')
    set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \
    set statusline+=\ \ \ [%{&ff}/%Y]
    set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\
    set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L
else
    let g:Powerline_symbols = 'fancy'
endif
    
function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endifcygwin
endfunction
"}

" C/C++ specific settings
autocmd FileType c,cpp,cc set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30

"Restore cursor to file position in previous editing session
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"---------------------------------------------------------------------------
" Tip #382: Search for <cword> and replace with input() in all open buffers
"---------------------------------------------------------------------------
fun! Replace()
    let s:word = input("Replace " . expand('<cword>') . " with:")
    :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge'
    :unlet! s:word
endfun 

"---------------------------------------------------------------------------
" USEFUL SHORTCUTS
"---------------------------------------------------------------------------
"
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk



" set leader to ,
let mapleader=","
let g:mapleader=","

" set the current buffer the only buffer
map <leader>o :only<cr>


"replace the current word in all opened buffers
map <leader>r :call Replace()<CR>




" --- move around splits {
" move to and maximize the below split
map <C-J> <C-W>j<C-W>_
" move to and maximize the above split
map <C-K> <C-W>k<C-W>_
" move to and maximize the left split
nmap <c-h> <c-w>h<c-w><bar>
" move to and maximize the right split
nmap <c-l> <c-w>l<c-w><bar>
set wmw=0 " set the min width of a window to 0 so we can maximize others
set wmh=0 " set the min height of a window to 0 so we can maximize others
" }

" move around tabs. conflict with the original screen top/bottom
" comment them out if you want the original H/L
" go to prev tab
map <S-H> gT
" go to next tab
map <S-L> gt

" new tab
map <C-t><C-t> :tabnew<CR>
" close tab
map <C-t><C-w> :tabclose<CR> 

" ,/ turn off search highlighting
nmap <leader>/ :nohl<CR>

" Bash like keys for the command line
cnoremap <C-A> <Home>
cnoremap <C-E> <End>
cnoremap <C-K> <C-U>

" ,p toggles paste mode
nmap <leader>p :set paste!<BAR>set paste?<CR>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h


"---------------------------------------------------------------------------
" PROGRAMMING SHORTCUTS
"---------------------------------------------------------------------------

" Ctrl-[ jump out of the tag stack (undo Ctrl-])
map <C-[> <ESC>:po<CR>

" ,g generates the header guard
map <leader>g :call IncludeGuard()<CR>
fun! IncludeGuard()
   let basename = substitute(bufname(""), '.*/', '', '')
   let guard = '_' . substitute(toupper(basename), '\.', '_', "H")
   call append(0, "#ifndef " . guard)
   call append(1, "#define " . guard)
   call append( line("$"), "#endif // for #ifndef " . guard)
endfun

" Enable omni completion. (Ctrl-X Ctrl-O)
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType java set omnifunc=javacomplete#Complete

" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
              \ if &omnifunc == "" |
              \ setlocal omnifunc=syntaxcomplete#Complete |
              \ endif
endif

set cot-=preview "disable doc preview in omnicomplete

" make CSS omnicompletion work for SASS and SCSS
autocmd BufNewFile,BufRead *.scss set ft=scss.css
autocmd BufNewFile,BufRead *.sass set ft=sass.css





"--------------------------------------------------------------------------------
" Encoding Settings
"-------------------------------------------------------------------------------- 
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,gbk,cp936,big5,gb2312,latin1 


" --- the quicklist errors must after enconding
" open the error console, if map Alt(M) keys, must after the enconding=utf-8
set winaltkeys=no
map <leader>cc :botright cope<CR>
" move to next error
map  <M-n> :cn<CR>
imap <M-n> <ESC><M-n>i
" move to the prev error
map <M-p> :cp<CR>
imap <M-p> <ESC><M-p>i
" list all the errors
map <F8> :clist<CR>
imap <F8> <ESC><F8>

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?
map <s-space> *

" delete to the end of line and enter the input mode
imap <a-l> <esc>la
imap <a-k> <esc>ka
imap <a-j> <esc>ja
imap <a-h> <esc>ha

" delete current line and rewrite it 
imap <M-r> <esc>o<ESC>kddi
map <M-r> o<esc>kddi

" go to the end in insert mode 
imap <m-a> <esc>A

" delete current word under the curse and yank in the input use y to input
" this is incredible, the h I figure it up and input it fofore 1315
imap <M-w> <esc>hebdei
map <M-w> hebdei

" copy current word under the curse, remember keys is enought
" the key is hebye

" delete current cotent between two quotes
imap <A-d> <esc>di"i
map <A-d> <esc>di"i 

" delete one line comment and prepared to write new one
imap <a-C> <esc>^f*lc$<space><space>*/<esc>hhi
map <a-C> ^f*lc$<space><space>*/<esc>hhi

" input the frame for the new code
imap <a-c> /*  */<esc>hhi
map <a-c> a/*  */<esc>hhi


"---------------------------------------
" Menu Settings, the message and the menu in English, this is so good
"---------------------------------------
language messages en_US
set langmenu=en_US
let $LANG='en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim




"--------------------------------------------------------------------------------
" Mswin Settings
"-------------------------------------------------------------------------------- 
if has('win32')
    source $VIMRUNTIME/vimrc_example.vim    "the vim runtime dir setted when install 
    source $VIMRUNTIME/mswin.vim
    behave mswin
    set fileformat=unix
endif
set nobackup    " to avoid tilde(~) files when open and modify a file and the position is important "

map <F6> :!C:\ruby193\bin\ruby.exe %
imap <F6> <esc>:!C:\ruby193\bin\ruby.exe %
map <F5> :!C:\python27\python.exe %
imap <F5> <esc>:!C:\python27\python.exe %

if has('multi_byte_ime')
    "highlight Cursor guibg=Green guifg=NONE
    highlight CursorIM guibg=Purple guifg=NONE
endif



"----------------------------------
" full screen VIM and let VIM biggest after start VIM
"----------------------------------
map <F12> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
"if has('gui_running') && has("win32")
"    au GUIEnter * simalt ~x
"endif


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


""""""""""""""""""""""""""""""
" => coding faster
""""""""""""""""""""""""""""""
imap <C-CR> <ESC>A;<ESC>o
imap <S-CR> <ESC>o


"---------------------------------------------------------------------------
" PLUGIN SETTINGS
"---------------------------------------------------------------------------


""""""""""""""""""""""""""""""
" => fencview setting, fancy vim is used to resolve the messy chinese problems
""""""""""""""""""""""""""""""
let g:fencview_autodetect = 1


""""""""""""""""""""""""""""""
" => CtrlP setting, keyboard map
""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

""""""""""""""""""""""""""""""
" => c make new
""""""""""""""""""""""""""""""
autocmd FileType c,cpp map <buffer> <leader><spaautocomplpop work with snipmatece> :w<cr>:make<cr>

""""""""""""""""""""""""""""""
" => minibufexpl setting
""""""""""""""""""""""""""""""
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim = 1



""""""""""""""""""""""""""""""
" => ctags 
""""""""""""""""""""""""""""""
"let g:ctags_statusline=1
let g:ctags_regenerate=1
let g:ctags_title=1
let Tlist_Ctags_Cmd="c:/vim/vim73/ctags"
let Tlist_Show_Menu=1
set tags=tags;
nmap <F9> <ESC>:!ctags -R *<CR>

""""""""""""""""""""""""""""""
" => taglist 
""""""""""""""""""""""""""""""
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
nnoremap <silent> <F8> :TlistToggle<CR>

""""""""""""""""""""""""""""""
" => autocomplpop work with snipmate
""""""""""""""""""""""""""""""
let g:acp_behaviorSnipmateLength=1
let g:acp_ignorecaseOption=1


""""""""""""""""""""""""""""""
" => winmanager
""""""""""""""""""""""""""""""
let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<CR>


" --- AutoClose - Inserts matching bracket, paren, brace or quote
" fixed the arrow key problems caused by AutoClose
if !has("gui_running")
   set term=linux
   imap OA <ESC>ki
   imap OB <ESC>ji
   imap OC <ESC>li
   imap OD <ESC>hi

   nmap OA k
   nmap OB j
   nmap OC l
   nmap OD h
endif

" --- Command-T
let g:CommandTMaxHeight = 15

" --- TagBar
" toggle TagBar with F7
nnoremap <silent> <F7> :TagbarToggle<CR>
" set focus to TagBar when opening it
let g:tagbar_autofocus = 1

" --- NeoComplCache
let g:neocomplcache_enable_at_startup = 1

" --- Calendar
let g:calendar_weeknm = 1
