" global functioins
function! GetSys()
    if has("win32")
        return "win32"
    elseif has("unix")
        return "unix"
    else
        return "mac"
    endif
endfunction

" generic
set runtimepath=~/cfg/vim,$VIMRUNTIME
set nocompatible
set number
set showcmd
set encoding=utf-8
set fileformats=unix,dos,mac
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
filetype plugin indent on
syntax on
" syntax enable

set history=600 "Command history count
set wildmenu "Turn on WiLd menu
set wildmode=longest:full,list,full
set ruler "Always show current positon 
set cmdheight=3 "Command buffer heigh
set backspace=indent,eol,start
set shortmess=atToO
set autowriteall "auto save change

if &diff == 1
  set scrollbind
endif

set smartcase
set ignorecase "Ignore case when searching
set hlsearch "Highlight search things
set incsearch "Make search act like search in modern browsers

set showmatch "Show matching bracets when text indicator is over them
set matchtime=3 "How many tenths of a second to blin

" settings of tab
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

set autoindent 
set smartindent

set mouse=v "catch mouse TODO set variant from OSs

if has("gui_running")
  set background=dark
  colorscheme peaksea
else
  set background=dark
  colorscheme desert
endif

let mapleader = ","
let g:mapleader = ","
" buffer manipulate
" last used buffer
nmap <leader>b :b#<CR>
" goto next buffer
nmap <leader>bn :bn<CR>
nmap <C-b> :bn<CR>
" goto previous buffer
nmap <leader>bp :bp<CR>
nmap <C-S-b> :bp<CR>
" goto buffer by indicate buffer id
nmap <leader>B :b

source $VIMRUNTIME/ftplugin/man.vim
nmap <leader>M :Man <C-R>=expand("<cword>")<CR><CR>

" settings of exuberant ctags
let Tlist_Ctags_Cmd="/usr/bin/ctags"
"let Tlist_Auto_Open=1
let Tlist_Inc_Winwidth=0
let Tlist_Auto_Update=1
let Tlist_Compact_Format=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Exit_OnlyWindow = 1
autocmd BufWrite *.h,*.c,*.hpp,*.cc,*.cpp,*.rl,*.def call system("ctags -a --extra=+q " . expand("%:p"))
autocmd BufRead,BufNewFile *.h,*.hpp,*.c,*.cpp,*.cc setlocal tags+=~/.ctags/tags
autocmd BufRead,BufNewFile *.h,*.hpp,*.c,*.cpp,*.cc 2match Underlined /.\%81v/
set tags=./tags;${HOME}/.ctags/tags

"let g:winManagerWindowLayout='TagList,FileExplorer'
let g:winManagerWindowLayout='BufExplorer'
let g:persistentBehaviour=0
let g:winManagerWidth=30
nmap wm :WMToggle<cr>
nmap <F6> :WMToggle<cr>

" tagbar settings
let g:tagbar_width=30
nmap <F7> :TagbarToggle<CR>

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
autocmd CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=longest,menu,menuone,preview

" NERD commenter settings
let NERDShutUp=1

" c/c++ support
let g:C_LocalTemplateFile = $HOME.'/cfg/vim/c-support/templates/Templates'
let g:C_FormatDate = '%F'
let g:C_FormatTime = '%T'
" jump to header file
map <leader>a :A<cr>
" remove trailing space before writting buffer
autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.cc :%s/\s\+$//e

" doxygen settings
let g:DoxygenToolkit_authorName="Sean Xue"
let g:DoxygenToolkit_licenseTag=""
let g:DoxygenToolkit_undocTag="DOXIGEN_SKIP_BLOCK"
let g:DoxygenToolkit_briefTag_pre = "@brief "
let g:DoxygenToolkit_paramTag_pre = "@param "
let g:DoxygenToolkit_returnTag = "@return "
let g:DoxygenToolkit_briefTag_funcName = "no"
let g:DoxygenToolkit_maxFunctionProtoLines = 30
map <leader>d :Dox<cr>

" Grep
nnoremap <silent> <F3> :Grep<CR>

" yankring
let g:yankring_history_file = '.yankring_history'

" protobuf syntax support
augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

" Indent Guides
let g:indent_guides_guide_size=1

" other key maps
map <leader>nh :nohl<CR>
map <leader>nn :set nonumber<CR>
map <leader>qa :quitall<CR>
nmap QA :qa<CR>

" lookupfile settings
let g:LookupFile_MinPatLength = 2               "最少输入2个字符才开始查找
let g:LookupFile_PreserveLastPattern = 0        "不保存上次查找的字符串
let g:LookupFile_PreservePatternHistory = 1     "保存查找历史
let g:LookupFile_AlwaysAcceptFirst = 1          "回车打开第一个匹配项目
let g:LookupFile_AllowNewFiles = 0              "不允许创建不存在的文件
if filereadable("./filenametags")                "设置tag文件的名字
    let g:LookupFile_TagExpr = '"./filenametags"'
endif

" 在指定目录生成filenametags，并使lookupfile将这个文件作为查找源
function SetRootOfTheProject(path)
    " 进入指定目录
    exe "cd ".a:path
    " 生成文件标签
    exe "!gen-filetags"
    " 获取标签文件的路径
    let tagFilePath = genutils#CleanupFileName(a:path.'/filenametags')
    " 设置LookupFile插件的全局变量，使之以上面生成的标签文件作为查找源
    "exe "let g:LookupFile_TagExpr='\"".tagFilePath."\"'"
endfunction

" 设置当前位置为工程的根目录
function SetHereTheRoot()
    call SetRootOfTheProject('.')
endfunction
nmap <leader>root :call SetHereTheRoot()<CR><CR>

" 从用户的输入获取指定路径，并设置为工程的根目录
function SetSpecifiedPathTheRoot()
    call SetRootOfTheProject(input('请输入工程根目录的路径：'))
endfunction
nmap <leader>xroot :call SetSpecifiedPathTheRoot()<CR>

" 使用LookupFile打开文件
nmap <leader>o :LookupFile<CR>

" format xml file
map <leader>xml :%s/></>\r</g<CR>gg=G
