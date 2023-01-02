; Filename: EasyType.ahk
; Version: 0.2
; Tested: AutoHotKey v1.1.33.10, Windows 11 build 22000.434
;
; Note:
; If your requirements fully meet the following conditions:
; 1. You want to use easy type mode
; 2. You want to lock windows with shortcut
; 3. You are the first time to run this script
; You have to run this script with administrator, and press "alt + ctrl + q" to lock
; windows first.

; Set easyTypeMode to 1 if you want to use CapsLock as your shortcut prefix key
easyTypeMode := 1

; Always disable caplock
SetCapsLockState, AlwaysOff

; Disable this script temporarily if you want
tempDisable := 0
^F1::
  if (tempDisable) {
    tempDisable := 0
    TrayTip, AHK EasyType, Enabled
  } else {
    tempDisable := 1
    TrayTip, AHK EasyType, Disabled
  }
  return

; Add caplock shortcut
#if GetKeyState("CapsLock", "P") && easyTypeMode && !tempDisable
  ; Disable LWin
  LWin up::return
  LWin::return

  ; Disable LAlt
  LAlt::return

  ; Edit function keys
  i::SendInput {Up}
  +i::SendInput +{Up}
  <!i::SendInput ^{Home}
  <#i::SendInput !{Up}

  k::SendInput {Down}
  +k::SendInput +{Down}
  <!k::SendInput ^{End}
  <#k::SendInput !{Down}

  j::SendInput {Left}
  +j::SendInput +{Left}
  <!j::SendInput {Home}
  +<!j::SendInput +{Home}
  <#j::SendInput ^{Left}
  +<#j::SendInput +^{Left}

  l::SendInput {Right}
  +l::SendInput +{Right}
  <!l::SendInput {End}
  +<!l::SendInput +{End}
  <#l::SendInput ^{Right}
  +<#l::SendInput +^{Right}

  <!BS::SendInput +{Home}{Backspace}
  <#BS::SendInput ^{Backspace}
  <!Delete::SendInput +{Home}{Delete}
  <#Delete::SendInput ^{Delete}
  h::SendInput {Backspace}
  n::SendInput {Delete}
  <!h::SendInput +{Home}{Backspace}
  <#h::SendInput ^{Backspace}
  <!n::SendInput +{Home}{Delete}
  <#n::SendInput ^{Delete}

  a::SendInput {Left}
  d::SendInput {Right}
  w::SendInput {Up}
  s::SendInput {Down}

  ; Used in terminal
  u::SendInput {PgUp}
  o::SendInput {PgDn}
  q::SendInput {PgUp}
  e::SendInput {PgDn}
  m::SendInput {Home}
  ,::SendInput {End}
  z::SendInput {Home}
  x::SendInput {End}
#if

; Add normal shortcut
#if !GetKeyState("CapsLock", "P") && !tempDisable
  ; Disable LWin
  LWin up::return
  LWin::return

  ; Enable LWin + tab again
  <#Tab::SendInput #{Tab}

  ; Disable LAlt
  LAlt::return

  ; Enable alt + up/down again
  <!Up::SendInput ^{Home}
  <#Up::SendInput !{Up}
  <!Down::SendInput ^{End}
  <#Down::SendInput !{Down}

  ; Toggle CapsLock
  <!<#RShift::CapsLock

  ; Lock windows
  <!^q::
    RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 0
    DllCall("LockWorkStation")
    sleep, 1000
    RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 1
    return

  ; Edit function keys
  <!Left::SendInput {Home}
  +<!Left::SendInput +{Home}
  <#Left::SendInput ^{Left}
  +<#Left::SendInput +^{Left}

  <!Right::SendInput {End}
  +<!Right::SendInput +{End}
  <#Right::SendInput ^{Right}
  +<#Right::SendInput +^{Right}

  <!BS::SendInput +{Home}{Backspace}
  <#BS::SendInput ^{Backspace}
  <!Delete::SendInput +{Home}{Delete}
  <#Delete::SendInput ^{Delete}

  ; Frequently used shortcut
  <!a::SendInput ^a
  <!b::SendInput ^b
  <!c::SendInput ^{Insert}
  <!f::SendInput ^f
  <!i::SendInput ^i
  <!n::SendInput ^n
  <!o::SendInput ^o
  <!q::SendInput !{F4}
  <!r::SendInput ^r
  <!s::SendInput ^s
  <!t::SendInput ^t
  <!u::SendInput ^u
  <!v::SendInput +{Insert}
  <!w::SendInput ^w
  <!x::SendInput ^x
  <!z::SendInput ^z
  <!,::SendInput ^,
  <!/::SendInput ^/
  <!+n::SendInput ^+n
  <!+o::SendInput ^+o
  <!+p::SendInput ^+p
  <!+r::SendInput ^+r
  <!+t::SendInput ^+t
  <!+z::SendInput ^+z
  <!Space::SendInput ^{Esc}

  ; Hotstring, awesome!!
  :o:@@::email@email.com

  ; Used in terminal
  <#z::SendInput !z
  <#t::SendInput !t
  <#-::SendInput ^b`"
  <#\::SendInput ^b`%
  <#a::SendInput !a
  <#s::SendInput !s

  ; For keyboard less than 83 keys
  +Esc::SendInput ~

  ; Switch application in RDP
  !`::SendInput {Blind}{PgUp}
  !+`::SendInput {Blind}{PgDn}
#if
