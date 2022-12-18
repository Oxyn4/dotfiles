
# bspwm
WM="bpswm" 

# set the x keymap
setxkbmap gb
# clear the right alt
/usr/bin/xmodmap -e "clear mod5"
# set right alt to super key
# 133 is code for right alt
/usr/bin/xmodmap -e "keycode 108 = mod4"
# clear the caps lock key function 
/usr/bin/xmodmap -e "clear lock"
/usr/bin/xmodmap -e "keycode 66 = mod4"
# get rid of default x cursor 
xsetroot -cursor_name left_ptr

# x set keys 
if [ -z $(which xbindkeys | grep -i "not found") ]; then
    xbindkeys
else 
    notify-send "xbindkeys executable not found"
fi

# start an x11 compositor provides 
# transparency and other effects
if [ -z $(which picom | grep -i "not found") ]; then
    exec picom &
else 
    notify-send "picom executable not found"
fi

# start a notifications server 
# provides us with notifications 
if [ -z $(which dunst | grep -i "not found") ]; then
    exec dunst &
else 
    notify-send "dunst executable not found"
fi

#exec awesome

#exec dwmblocks & 

#exec dwm

#exec mate-session

#exec openbox

#exec i3

#exec sxhkd &

if [ -z $(which redshift | grep -i "not found") ]; then
    exec redshift &
else 
    notify-send "redshift executable not found"
fi

#feh --bg-scale --randomize ~/.config/walls/*

if [ -z $(which feh | grep -i "not found") ]; then
    feh --bg-scale ~/.config/walls/firewatch_tower.jpg
else 
    notify-send "feh executable not found"
fi

#wal -s --saturate 0.6 --b 1C1D1E --backend colorz -i ~/.config/walls/ -o post_wall

if [ -z $(which polybar | grep -i "not found") ]; then
    # start the top panel 
    exec polybar topbar &
    # start the bottom panel
    exec polybar bottombar &
else 
    notify-send "polybar executable not found"
fi

# start window manager
exec bspwm
