" au! QuickFixCmdPre *.[ch] call SearchWord()

func SearchWord()
    let w = expand("<cword>")> " 在当前光标位置抓词
    let p = expand("%:p:h")> " 取得当前文件的路径
    exe "cd " p
    exe "vimgrep " w "*.c *.h"
    exe ‘copen’
endfun
