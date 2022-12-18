#!/bin/sh

path="$HOME/.config/i3lock/lockimage.png"

scrot ~/.config/i3lock/lockimage.png

convert -resize 10% $path $path
convert -resize 1000% $path $path

i3lock -i $path

rm -f $path
