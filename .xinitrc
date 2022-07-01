feh --bg-scale .config/wall.jpg

xrandr --auto --output DP-1 --mode 1920x1080 --left-of DP-2

picom &

/usr/bin/polkit-dumb-agent &

exec i3
