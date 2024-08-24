; Filename: EasyType.ahk
; Version: 1.0
; Tested: AutoHotKey v2.0.10, Windows 11 build 22000.434
;
; Note:
; If your requirements fully meet the following conditions:
; 1. You want to use easy type mode
; 2. You want to lock windows with shortcut
; 3. You are the first time to run this script
; You have to run this script with administrator, and press "alt + ctrl + q" to lock
; windows first.

;
; Configurations
;

; Set capsAsPrefix to 1 if you want to use CapsLock as your shortcut prefix key
capsAsPrefix := 1

; Set mouseModeCap to 1 if you want to move mouse via keyboard
mouseModeCap := 1

; Set excludeVdi to 1 if you want to exclude VDI from autohotkey
excludeVdi := 1

;
; Programs
;

; Always disable caplock
SetCapsLockState "AlwaysOff"

#HotIf WinActive("ahk_exe vmware-view.exe") && excludeVdi

F1::MsgBox "You pressed F1 in VDI"

#HotIf !WinActive("ahk_exe vmware-view.exe")

F1::MsgBox "You pressed F1 out of VDI"

; Disable this script temporarily if you want
tempDisable := 0
^F1::{
  global tempDisable
  if (tempDisable) {
    tempDisable := 0
    TrayTip "AHK EasyType", "Enabled"
    SetCapsLockState "AlwaysOff"
  } else {
    tempDisable := 1
    TrayTip "AHK EasyType", "Disabled"
    SetCapsLockState
  }
  return
}

; Disable LWin
~LWin up::SendInput "{Blind}{vkE8}"
~LWin::SendInput "{Blind}{vkE8}"

; Disable LAlt
~LAlt::SendInput "{Blind}{vkE8}"

; Add caplock shortcut
#HotIf GetKeyState("CapsLock", "P") && capsAsPrefix && !tempDisable
  ; Edit function keys
  i::SendInput "{Up}"
  +i::SendInput "+{Up}"
  <!i::SendInput "^{Home}"
  <#i::SendInput "!{Up}"

  k::SendInput "{Down}"
  +k::SendInput "+{Down}"
  <!k::SendInput "^{End}"
  <#k::SendInput "!{Down}"

  j::SendInput "{Left}"
  +j::SendInput "+{Left}"
  <!j::SendInput "{Home}"
  +<!j::SendInput "+{Home}"
  <#j::SendInput "^{Left}"
  +<#j::SendInput "+^{Left}"

  l::SendInput "{Right}"
  +l::SendInput "+{Right}"
  <!l::SendInput "{End}"
  +<!l::SendInput "+{End}"
  <#l::SendInput "^{Right}"
  +<#l::SendInput "+^{Right}"

  <!BS::SendInput "+{Home}{Backspace}"
  <#BS::SendInput "^{Backspace}"
  <!Delete::SendInput "+{Home}{Delete}"
  <#Delete::SendInput "^{Delete}"
  h::SendInput "{Backspace}"
  n::SendInput "{Delete}"
  <!h::SendInput "+{Home}{Backspace}"
  <#h::SendInput "^{Backspace}"
  <!n::SendInput "+{Home}{Delete}"
  <#n::SendInput "^{Delete}"

  a::SendInput "{Left}"
  d::SendInput "{Right}"
  w::SendInput "{Up}"
  s::SendInput "{Down}"

  ; Used in terminal
  u::SendInput "{PgUp}"
  o::SendInput "{PgDn}"
  q::SendInput "{PgUp}"
  e::SendInput "{PgDn}"
  m::SendInput "{Home}"
  ,::SendInput "{End}"
  z::SendInput "{Home}"
  x::SendInput "{End}"

; Add normal shortcut
#HotIf !GetKeyState("CapsLock", "P") && !tempDisable
  ; Enable alt + up/down again
  <!Up::SendInput "^{Home}"
  <#Up::SendInput "!{Up}"
  <!Down::SendInput "^{End}"
  <#Down::SendInput "!{Down}"

  ; Toggle CapsLock
  <!<#RShift::SendInput "{CapsLock}"

  ; Lock windows
  <!^q::{
    RegWrite "0", "REG_DWORD", "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System", "DisableLockWorkstation"
    DllCall("LockWorkStation")
    sleep 1000
    RegWrite "1", "REG_DWORD", "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System", "DisableLockWorkstation"
    return
  }

  ; Edit function keys
  <!Left::SendInput "{Home}"
  +<!Left::SendInput "+{Home}"
  <#Left::SendInput "^{Left}"
  +<#Left::SendInput "+^{Left}"

  <!Right::SendInput "{End}"
  +<!Right::SendInput "+{End}"
  <#Right::SendInput "^{Right}"
  +<#Right::SendInput "+^{Right}"

  <!BS::SendInput "+{Home}{Backspace}"
  <#BS::SendInput "^{Backspace}"
  <!Delete::SendInput "+{Home}{Delete}"
  <#Delete::SendInput "^{Delete}"

  ; Frequently used shortcut
  <!a::SendInput "^a"
  <!b::SendInput "^b"
  <!c::SendInput "^{Insert}"
  <!f::SendInput "^f"
  <!i::SendInput "^i"
  <!n::SendInput "^n"
  <!o::SendInput "^o"
  <!q::SendInput "!{F4}"
  <!r::SendInput "^r"
  <!s::SendInput "^s"
  <!t::SendInput "^t"
  <!u::SendInput "^u"
  <!v::SendInput "+{Insert}"
  <!w::SendInput "^w"
  <!x::SendInput "^x"
  <!z::SendInput "^z"
  <!,::SendInput "^,"
  <!/::SendInput "^/"
  <!+n::SendInput "^+n"
  <!+o::SendInput "^+o"
  <!+p::SendInput "^+p"
  <!+r::SendInput "^+r"
  <!+t::SendInput "^+t"
  <!+z::SendInput "^+z"
  <!Space::SendInput "^{Esc}"

  ; Hotstring, awesome!!
  :o:@@::email@email.com

  ; Used in terminal
  <#z::SendInput "!z"
  <#t::SendInput "!t"
  <#-::{
    SendInput "^b"
    SendInput '"'
  }
  <#\::{
    SendInput "^b"
    SendInput "%"
  }
  <#a::SendInput "!a"
  <#s::SendInput "!s"

  ; For keyboard less than 83 keys
  +Esc::SendInput "~"

  ; Switch application from RDP to others
  !`::SendInput "{Blind}{Tab}"
  !+`::SendInput "{Blind}{Tab}"

; Switch application in RDP
#HotIf !GetKeyState("CapsLock", "P") && !tempDisable && WinActive("ahk_exe mstsc.exe")
  !Tab::SendInput "{Blind}{PgUp}"
  !+Tab::SendInput "{Blind}{PgDn}"
#HotIf

;
; Mouse mode
;

; Design
; 1. Press prefix + r to toggle mouse mode
; 2. Use awsd to move mouse
; 3. Use ikjl to scroll
; 4. 3 kinds of moving speeds. Default: middle, press shift to move slow, press control to move fast
; 5. use "m.," as left click, middle click, and right click

mouseModeEn := 0 ; default: 0, 1 is for debugging
movingMouse := 0

leftClickDown := 0
rightClickDown := 0
middleClickDown := 0
scrollEn := 0

#HotIf GetKeyState("CapsLock", "P") && capsAsPrefix && !tempDisable && mouseModeCap
  Tab::{
    global mouseModeEn, movingMouse, clickingMouse
    if mouseModeEn {
      mousemodeEn := 0
      movingMouse := 0
      clickingMouse := 0
    } else {
      mousemodeEn := 1
    }
  }
#HotIf !tempDisable && mouseModeCap && mouseModeEn
  ; Moving mouse
  *a::MoveMouse()  ; move mouse left
  *w::MoveMouse()  ; move mouse up
  *s::MoveMouse()  ; move mouse down
  *d::MoveMouse()  ; move mouse right
  *j::MoveMouse()  ; move extremely slow
  *k::MoveMouse()  ; move slow
  *l::MoveMouse()  ; move fast
  *`;::MoveMouse() ; move extremely fast

  ; Click
  *Space::ClickMouse()     ; left click
  *m::ClickMouse()         ; left click
  *,::ClickMouse()         ; scroll
  *i::ClickMouse()         ; scroll
  *.::ClickMouse()         ; right click
  /::ClickMouse()         ; middle click
  *b::Send "!{Left}"       ; Previous page
  *n::Send "!{Right}"      ; Next page

  *Space Up::{
    global leftClickDown
    if GetKeyState("m", "P") {
      return
    }
    Click "Up Left"
    leftClickDown := 0
  }
  *m Up::{
    global leftClickDown
    if GetKeyState("Space", "P") {
      return
    }
    Click "Up Left"
    leftClickDown := 0
  }
  *. Up::{
    global rightClickDown
    Click "Up Right"
    rightClickDown := 0
  }
  *, Up::{
    global scrollEn
    scrollEn := 0
  }
  / Up::{
    global middleClickDown
    Click "Up Middle"
    middleClickDown := 0
  }

  MoveMouse() {
    global movingMouse, mouseModeEn, scrollEn

    ; Critical
    if movingMouse {
      ; Critical "Off"
      return ; Only keep 1 function call for MoveMouse
    }
    movingMouse := 1
    ; Critical "Off"

    while mouseModeEn == 1 {
      if scrollEn {
        movingSleep := 8
        if GetKeyState("l", "P") { ; 200
          movingSleep := 200
        } else if GetKeyState(";", "P") { ; 150
          movingSleep := 20
        } else { ; 15
          movingSleep := 50
        }

        if GetKeyState("a", "P") {
          Click "WL"
        } else if GetKeyState("w", "P") {
          Click "WU"
        } else if GetKeyState("s", "P") {
          Click "WD"
        } else if GetKeyState("d", "P") {
          Click "WR"
        }
      } else {
        movingSleep := 8
        if GetKeyState("j", "P") { ; 1
          movingSleep := 1
          movingSpeed := 2
        } else if GetKeyState("k", "P") { ; 5
          movingSpeed := 5
        } else if GetKeyState("l", "P") { ; 50
          movingSpeed := 50
        } else if GetKeyState(";", "P") { ; 150
          movingSpeed := 150
        } else { ; 15
          movingSpeed := 15
        }

        if GetKeyState("a", "P") {
          MouseMove -movingSpeed, 0, 0, "R"
        }

        if GetKeyState("w", "P") {
          MouseMove 0, -movingSpeed, 0, "R"
        }

        if GetKeyState("s", "P") {
          MouseMove 0, movingSpeed, 0, "R"
        }

        if GetKeyState("d", "P") {
          MouseMove movingSpeed, 0, 0, "R"
        }
      }

      if !GetKeyState("a", "P") && !GetKeyState("w", "P") && !GetKeyState("s", "P") && !GetKeyState("d", "P") {
        break
      }

      sleep movingSleep
    }

    ; Critical
    movingMouse := 0
    ; Critical "Off"
  }

  ClickMouse() {
    global mouseModeEn, leftClickDown, rightClickDown, middleClickDown, scrollEn

    if !mouseModeEn {
      return
    }

    if GetKeyState("m", "P") || GetKeyState("Space", "P") {
      if leftClickDown == 0 {
        Click "Down Left"
        leftClickDown := 1
      }
    }

    if GetKeyState(",", "P") {
      if scrollEn == 0 {
        scrollEn := 1
      }
    }

    if GetKeyState(".", "P") {
      if rightClickDown == 0 {
        Click "Down Right"
        rightClickDown := 1
      }
    }

    if GetKeyState("/", "P") {
      if middleClickDown == 0 {
        Click "Down Middle"
        middleClickDown := 1
      }
    }

    if GetKeyState("i", "P") {
      if scrollEn == 0 {
        scrollEn := 1
      } else {
        scrollEn := 0
      }
    }
  }
#HotIf