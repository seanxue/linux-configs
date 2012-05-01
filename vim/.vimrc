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
set cmdheight=2 "Command buffer heigh
set backspace=indent,eol,start

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
" goto previous buffer
nmap <leader>bp :bp<CR>

source $VIMRUNTIME/ftplugin/man.vim
nmap <leader>M :Man <C-R>=expand("<cword>")<CR><CR>

" settings of exuberant ctags
let Tlist_Ctags_Cmd="/usr/bin/ctags"
" let Tlist_Auto_Open=1
let Tlist_Inc_Winwidth=0
let Tlist_Auto_Update=1
let Tlist_Compact_Format=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Exit_OnlyWindow = 1
autocmd BufWrite *.h,*.c,*.hpp,*.cc,*.cpp,*.rl,*.def call system("ctags -a --extra=+q " . expand("%:p"))
autocmd BufRead,BufNewFile *.h,*.hpp,*.c,*.cpp,*.cc setlocal tags+=~/cfg/vim/tags/c/**/tags
autocmd BufRead,BufNewFile *.h,*.hpp,*.c,*.cpp,*.cc 2match Underlined /.\%81v/
set tags=./tags;${HOME}

let g:winManagerWindowLayout='TagList,FileExplorer'
let g:persistentBehaviour=0
let g:winManagerWidth=24
nmap wm :WMToggle<cr>

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
" jump to header file
let g:C_LocalTemplateFile = $HOME.'/cfg/vim/c-support/templates/Templates'
let g:C_FormatDate = '%F'
let g:C_FormatTime = '%T'
map <leader>a :A<cr>

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
