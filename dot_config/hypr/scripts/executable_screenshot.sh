!#/bin/zsh
# grim -g "$(slurp)" &
grim -g "$(slurp)" -t png - | wl-copy -t image/png
