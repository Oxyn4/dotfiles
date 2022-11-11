
setxkbmap gb
/usr/bin/xmodmap -e "clear mod5"
/usr/bin/xmodmap -e "keycode 108 = Alt_L"

xbindkeys

exec picom &

exec dunst &

exec awesome

#exec dwmblocks & 

#exec dwm

