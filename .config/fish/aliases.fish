# ┌──────────────────────────────────────┐
# │ Navigation                           │
# └──────────────────────────────────────┘
alias cd='z'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
abbr -a op opencode
abbr -a xx tmux
abbr -a tmuxk 'tmux kill-session'
abbr -a zz yazi
abbr -a lg lazygit

# ┌──────────────────────────────────────┐
# │ File Listing                         │
# └──────────────────────────────────────┘
alias ls='eza --sort=type --no-symlinks --icons=auto'
abbr -a la 'ls -a'
abbr -a ll 'eza -lha --icons=auto --sort=name --group-directories-first'
abbr -a ld 'eza -lhD --icons=auto'
abbr -a lt 'eza --icons=auto --tree'
abbr -a ltt 'eza --tree --level=2 --long --icons --git'
abbr -a lta 'lt -a'

# ┌──────────────────────────────────────┐
# │ File Operations                      │
# └──────────────────────────────────────┘
abbr -a mkd 'mkdir -p && cd .'
abbr -a chx 'chmod +x'
abbr -a rr 'rm -rf'
abbr -a ff 'find . -type f -name'
abbr -a fd 'find . -type d -name'
abbr -a fdh 'fd --hidden'
abbr -a f "find . | grep "

# ┌──────────────────────────────────────┐
# │ Editors & Config                     │
# └──────────────────────────────────────┘
abbr -a c clear
abbr -a nn nvim
abbr -a vim nvim
abbr -a n nvim
abbr -a ffile 'nvim ~/.config/fish/config.fish'
abbr -a bfile 'nvim ~/.bashrc'
abbr -a nb 'nvim ~/.config/hypr/bindings.conf'

# ┌──────────────────────────────────────┐
# │ Development                          │
# └──────────────────────────────────────┘
abbr -a nd 'npm run dev'
abbr -a oo 'opencode run'
abbr -a open 'nautilus .'
abbr -a x exit
abbr -a zed 'zeditor'

# ┌──────────────────────────────────────┐
# │ Git                                  │
# └──────────────────────────────────────┘
abbr -a gits 'git status'
abbr -a ghs 'streaker vyrx-dev'
abbr -a ghp 'gh repo create --public (basename "$PWD") --source=. --description="desc" --push'

# ┌──────────────────────────────────────┐
# │ System & Package Management          │
# └──────────────────────────────────────┘
abbr -a update 'sudo pacman -Syu'
abbr -a mp 'makepkg -si'
abbr -a ss "paru -Slq | fzf --multi --preview 'paru -Sii {1}' --preview-window=down:75% | xargs -ro paru -S"
abbr -a ping 'ping -c 10'
abbr -a pg 'ping -c 10 google.com'
abbr -a cleanup 'sudo pacman -Rns (pacman -Qdtq)'
abbr -a cleanc 'sudo pacman -Sc && paru -Sc'
abbr -a pacckeep 'sudo paccache -k 3'
abbr -a pacclean 'sudo paccache -r'
abbr -a paccleanall 'sudo paccache -r -c /var/cache/pacman/pkg -u'
abbr -a folders 'du -h --max-depth=1'
abbr -a mirrorfix 'sudo reflector --latest 20 --sort rate --save /etc/pacman.d/mirrorlist'
abbr -a showpkg 'pacman -Qi'

# ┌──────────────────────────────────────┐
# │ Shell & TTY                          │
# └──────────────────────────────────────┘
alias tobash="chsh $USER -s /usr/bin/bash && echo 'Log out and log back in for change to take effect.'"
alias tozsh="chsh $USER -s /usr/bin/zsh && echo 'Log out and log back in for change to take effect.'"
alias tofish="chsh $USER -s /usr/bin/fish && echo 'Log out and log back in for change to take effect.'"
abbr -a bigfont "setfont ter-132b"
abbr -a regfont "setfont default8x16"
abbr -a last-updated 'grep -i "full system upgrade" /var/log/pacman.log | tail -n 1'
abbr -a cache 'du -sh /var/cache/pacman/pkg .cache/yay'
abbr -a pwreset 'faillock --reset --user vyrx'

# ┌──────────────────────────────────────┐
# │ Media                                │
# └──────────────────────────────────────┘
abbr -a rip "yt-dlp -x --audio-format=\"mp3\""
abbr -a vdo "yt-dlp -x"
abbr -a ac ani-cli

# ┌──────────────────────────────────────┐
# │ Other                                │
# └──────────────────────────────────────┘
abbr -a gemini gemini
abbr -a jdbc-run 'javac -cp $HOME/.m2/repository/org/postgresql/postgresql/42.7.4/postgresql-42.7.4.jar JdbcCrudDemo.java && java -cp .:$HOME/.m2/repository/org/postgresql/postgresql/42.7.4/postgresql-42.7.4.jar JdbcCrudDemo'
abbr -a h "history | grep "
