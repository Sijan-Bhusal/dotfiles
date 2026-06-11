# Flutter
set -gx PATH $PATH $HOME/dev/tools/flutter/bin

# Godot
# set -gx PATH $PATH /opt/godot

# Android SDK
set -gx ANDROID_HOME $HOME/dev/tools/android-sdk
set -gx PATH $PATH \
    $ANDROID_HOME/cmdline-tools/latest/bin \
    $ANDROID_HOME/platform-tools \
    $ANDROID_HOME/emulator

# Chrome / Brave
set -gx CHROME_EXECUTABLE /usr/bin/brave

#Golang
# set -Ux GOPATH $HOME/go
# set -Ux PATH $PATH $GOPATH/bin


