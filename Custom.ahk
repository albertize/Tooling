#Requires AutoHotkey v2.0
#SingleInstance Force

#q::WinClose("A")

#Enter::
{
    if WinExist("ahk_exe WindowsTerminal.exe")
        WinActivate "ahk_exe WindowsTerminal.exe"
    else
        Run "wt"

}

; AltGr (Right Alt) + ì -> tilde (~) as text
<^>!ì::{
    SendText "~"
}

; AltGr (Right Alt) + ' -> backtick (`) as text
<^>!'::{
    SendText "``"
}
