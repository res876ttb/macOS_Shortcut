; Filename: mac_shortcut.ahk
; Goal of this script
;   Remap windows shortcuts into mac shortcuts
; Version: 1.1

ifShortcutActivate() {
  ; black list
  if (WinActive("ahk_exe some_application.exe")) {
    return 0
  } else {
    return 1
  }
}

ifX11Active() {
  if (WinActive("ahk_exe vcxsrv.exe")) {
    return 1
  } else {
    return 0
  }
}

ifTyporaActive() {
  if (WinActive("ahk_exe Typora.exe")) {
    return 1
  } else {
    return 0
  }
}

ifVscodeActive() {
  if (WinActive("ahk_exe Code.exe")) {
    return 1
  } else {
    return 0
  }
}

; disable alt key
Alt::return

; disable left windows key
LWin::return
LWin & Esc::SendInput {RWin}

; re-enable windows-tab shortcut
LWin & Tab::SendInput #{Tab}

; remap application key
AppsKey::SendInput {RWin}

; show the class, title, and the process name of active window
!#^w::
  WinGetClass, class, A
  WinGetTitle, title, A
  WinGet, process, ProcessName, A
  MsgBox, The active windows's class is "%class%", title is "%title%", process name is "%process%"
  return

#If, ifTyporaActive() && ifShortcutActivate()
  !/::SendInput ^/
  return
#If

#If, ifVscodeActive() && ifShortcutActivate()
  ![::SendInput ^[
  !]::SendInput ^]
  #Up::SendInput !{Up}
  #Down::SendInput !{Down}
  return
#If

#If, !ifX11Active() && ifShortcutActivate()
  !Left::SendInput {Home}
  !Right::SendInput {End}
  !+Left::SendInput +{HOME}
  !+Right::SendInput +{End}
  #Left::SendInput ^{Left}
  #Right::SendInput ^{Right}
  #+Left::SendInput ^+{Left}
  #+Right::SendInput ^+{Right}
  !z::SendInput ^z
  !+z::SendInput ^+z
  !w::SendInput ^w
  !t::SendInput ^t
  !+t::SendInput ^+t
  !1::SendInput ^1
  !2::SendInput ^2
  !3::SendInput ^3
  !4::SendInput ^4
  !5::SendInput ^5
  !6::SendInput ^6
  !7::SendInput ^7
  !8::SendInput ^8
  !9::SendInput ^9
  !-::SendInput ^-
  return
#If

#If, !ifVscodeActive() && ifShortcutActivate()
  ![::SendInput !{Left}
  !]::SendInput !{Right}
  !Up::SendInput ^{Home}
  !Down::SendInput ^{End}
  !+Up::SendInput ^+{Home}
  !+Down::SendInput ^+{End}
  return
#If

#If, ifShortcutActivate()
  !c::SendInput ^c
  !+c::SendInput ^+c
  #c::SendInput ^{Insert}
  !x::SendInput ^x
  !v::SendInput ^v
  !+v::SendInput ^+{Insert}
  #v::SendInput +{Insert}
  !a::SendInput ^a
  !s::SendInput ^s
  !p::SendInput ^p
  !q::SendInput !{f4}
  !r::SendInput {f5}
  !f::SendInput ^f
  !n::SendInput ^n
  !o::SendInput ^o
  #BS::SendInput ^{BackSpace}
  #Delete::SendInput ^{Delete}
  !BS::SendInput +{Home}{backspace}
  !Delete::SendInput +{End}{Delete}
  !b::SendInput ^b
  !i::SendInput ^i
  !u::SendInput ^u
  !+b::SendInput ^+b
  !+i::SendInput ^+i
  !+u::SendInput ^+u
  !=::SendInput ^=
  !0::SendInput ^0
  !,::SendInput ^,
  !Space::SendInput #{Space}
  ^!f::SendInput #{Up}
  +Esc::SendInput ~
  return
#If