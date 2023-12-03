# macOS_Shortcut

## Requirement

* Download [AutoHotkey](https://autohotkey.com/download/)
* After install AutoHotkey, double click the .ahk file to execute the script

## Tested Environment

* Windows 11 build 22621.2715
* AutoHotKey v2.0.10

## Disabled Keys

If your requirements fully meet the following conditions:
1. You want to use easy type mode (CapsLock as shortcut prefix, with i/j/k/l as arrow keys)
2. You want to lock windows with shortcut
3. You are the first time to run this script
You have to run this script with administrator, and press "alt + ctrl + q" to lock windows first.

In addition, this script will disable left windows key and alt key.

## Mouse Mode

Press `prefix + Tab` to toggle mouse mode. After the script running, mouse mode is disabled by default.

1. Use `awsd` to move left, up, down, and right.
   * Press `jkl;` for different moving speed. `j` is the fatest, `;` is the slowest.
2. Press `i` to toggle scroll mode. Or press `,` to enable scroll mode temprorarily. Under scroll mode, use `awsd` to scroll left, up, down, and right.
   * Press `l;` under scroll mode for different scrolling speed. `l` is moving slower, `;` is scrolling faster.
3. Press `m` for left click, `.` for right click, `/` for middle click.
   * Currently, left click and right click support for other modifiers. But middle click does not support modifier.
   * For example, we can press shift with awsd and keep pressing left click to select a range of text. However, we cannot press shift or alt along with middle click.
4. If you want to disable the whole mouse mode functionality, set `mouseModeCap` to 0.
