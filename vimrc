"fofore's vimrc
"Minming Qian <qianminming@gmail.com> www.fofore.com
"Fork me in GITHUB https://github.com/fofore/vimrc

"For pathogen.vim :auto load all plugins in 'vimpath'/bundle
let g:pathogen_disabled = [] 
if !has('gui_running') 
    call add(g:pathogen_disabled, 'powerline')
endif
call pathogen#infect()

"--------------------------------------------------------------------------------
" General Settings
"-------------------------------------------------------------------------------- 

set nocompatible            " not compatible with the old-fashion vi mode
set bs=2                    " allow backspacing over everything in insert mode
set history=50              " keep 50 lines of command line history
set ruler                   " show the cursor position all the time
set autoread                " auto read when file is changed from outside
set nowrap                  " wrat setting
set textwidth=200           " set the max textwith

filetype on                 " Enable filetype detection
filetype indent on          " Enable fileytpe-specific indenting
filetype plugin on          " Enable filetype-specific plugins


" auto reload _vimrc when editing it
if has('win32')
    autocmd! bufwritepost _vimrc source $VIM\_vimrc
else
    autocmd! bufwritepost .vimrc source ~/.vimrc
endif


" GUI color and font settings
if has('gui_running')
    colors lucius
    set cursorline          " highlight current line
    highlight CursorLine    guibg=#003853 ctermbg=24 gui=none cterm=none
    set guioptions-=m
    set guioptions-=T
    set guifont=Bitstream_Vera_Sans_Mono:h11
else
    colors lucius
endif


syntax enable
syntax on                   " syntax highlight
set hls                     " search highlighting

" disable sound on errors
set noerrorbells
set novisualbell
set tm=500

set autochdir
set nu                      " show line number 
set clipboard=unnamed       " yank to the system register (*)  by default
set showmatch               " Cursor shows matching ) and }
set showmode                " show current mode
set wildchar=<TAB>          " start wild expansion in the command line using <TAB>
set wildmenu                " wild char completion menu

" ignore these files while expanding wild chars
set wildignore=*.o,*.class,*.pyc


set nobackup                " no *~backup file
set incsearch               " incremental search
set copyindent              " copy the previous indentation on autoindenting
set autoindent              " auto indenting
set smartindent             " smart indenting
set ignorecase              " ignore case when searching
set smartcase               " ignore case if search pattern is all lowercase,case-sensitive othterwise
set smarttab                " insert tabs on the start of a line according to

" TAB settings
set tabstop=4               " tab length
set shiftwidth=4            
set expandtab               " equal tab to number of spaces, replace <TAB> with spaces
autocmd Filetype Makefile set noexpandtab

" status line
set laststatus=2
set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \ 
set statusline+=\ \ \ [%{&ff}/%Y] 
set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\ 
set statusline+=%=%-10.(%l,%c%V%)\ %p%%/%L

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "")
    return curdir
endfunction

function! HasPaste()
    if &paste
        return '[PASTE]'
    else
        return ''
    endif
endfunction

" C/C++ specific settings
autocmd FileType c,cpp,cc set cindent comments=sr:/*,mb:*,el:*/,:// cino=>s,e0,n0,f0,{0,}0,^-1s,:0,=s,g0,h1s,p2,t0,+2,(2,)20,*30


"--------------------------------------------------------------------------------
" Encoding Settings
"-------------------------------------------------------------------------------- 
set enc=utf-8
set tenc=utf-8
set fenc=utf-8
set fencs=ucs-bom,utf-8,gbk,cp936,big5,gb2312,latin1 


"--------------------------------------------------------------------------------
" Menu Settings
"-------------------------------------------------------------------------------- 
if has('win32')
    language messages zh_CN.utf-8
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
endif


"--------------------------------------------------------------------------------
" Mswin Settings
"-------------------------------------------------------------------------------- 
if has('win32')
    source $VIMRUNTIME/vimrc_example.vim    "the vim runtime dir setted when install 
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif





"按键映射，F5快捷键，映射到命令行运行python脚本
map <F5> :!C:\python27\python.exe %

"编译选项中包换了ime，则插入模式下的光标是紫色的
if has('multi_byte_ime')
    "highlight Cursor guibg=Green guifg=NONE
    highlight CursorIM guibg=Purple guifg=NONE
endif






"--------------------------------------------------------------------------------
" Ctags Configuration
"--------------------------------------------------------------------------------
"ctags使用的配置,中间自动进行父路径查找,不知道是不是正确
set tags=tags;
set autochdir

let Tlist_Ctags_Cmd='C:/Vim/vim73/ctags.exe'
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Left_Window=1
let Tlist_Auto_Open=1
let Tlist_Auto_Update=1
let Tlist_Compact_Format=1
let Tlist_Enable_Fold_Column=0
let Tlist_Process_File_Always=1
let Tlist_File_Fold_Auto_Close=0
let Tlist_Sort_Type="order"
let Tlist_WinWidth=30
let Tlist_Close_On_Select=0
let Tlist_Use_SingleClick=1
let g:winManagerWindowLayout='TagList|BufExplorer'
let g:miniBufExplMapCTabSwitchBufs=1
nnoremap <silent> <F8> :TlistToggle<CR>

"自动补全括号,引号部分还是有问题的
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=CloseThePair(')')<CR> 
:inoremap { {}<ESC>i
:inoremap } <c-r>=CloseThePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=CloseThePair(']')<CR>

function CloseThePair(char)
    if getline('.')[col('.')-1]==a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

"括号自动补齐功能总是和shift+enter一起使用,
"shift+enter提供直接跳转到下一行开始编辑
"常用的按键:<ESC>
"<C-G>:Ctrl+G;<UP>;<C-LeftMouse>;<S-F11>;<Space>空格;<Tab>;<CR>就是Enter
:inoremap <S-CR> <ESC>o
:inoremap <C-CR> <ESC>A:<ESC>o





"使用鼠标映射
let g:vimwiki_use_mouse=1
"不要将驼峰式词组作为 wiki 词条
let g:vimwiki_camel_case=0
let g:vimwiki_list=[{'path':'D:/mysite/html/','path_html':'D:/mysite/html/','auto_export':1,}]

"vimfile diretory
if has("win32")
    let $VIMFILES = $VIM.'/vimfiles'
else
    let $VIMFILES = $HOME.'/.vim'
endif


