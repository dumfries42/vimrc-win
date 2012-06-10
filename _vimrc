"编码设置部分;github等都是用的utf-8,所以vim编辑出来的使用utf-8,不然是乱码
set enc=utf-8
set tenc=utf-8
set fenc=utf-8
set fencs=utf-8,usc-bomm,gbk,cp936 
"依次尝试各种打开编码去打开文件,因为本地有很多文件不是utf-8编码格式的

"解决提示信息乱码
language messages zh_CN.utf-8

"菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"for vi compatible, we don't need
set nocompatible

"the vim runtime dir setted when install 
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

"system default setting
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"设置配色方案，设置colors文件夹下有的
colorscheme Lucius

"按键映射，F5快捷键，映射到命令行运行python脚本
map <F5> :!C:\python27\python.exe %

"编译选项中包换了ime，则插入模式下的光标是紫色的
if has('multi_byte_ime')
    "highlight Cursor guibg=Green guifg=NONE
    highlight CursorIM guibg=Purple guifg=NONE
endif

set hls "highlight search

set is "increase search 

set nu "show line number 

"设置的等号前后不能有空格
set backspace=indent,eol,start

set nobackup

set cursorline "set cursor line highlight

set tabstop=4 "tab spaces

set shiftwidth=4 "自动缩进的字符宽度

set et "equal tab to number of spaces

set smarttab "只一次退格就可删除等价的tab,而不是多删除space

"自动缩进
set autoindent
set smartindent

"自动切换当前目录
set autochdir

"语法高亮
syntax on

"开启文件自动识别,文件类型插件,启用正对文件类型的自动缩进,不过好像这个版本默认就是开启的
filetype plugin indent on

set guioptions-=m
set guioptions-=T


