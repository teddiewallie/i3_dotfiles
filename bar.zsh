#!/bin/zsh

datetime  () { date +"%H:%M" }
ssid      () { iwconfig wlp4s0 | grep ESSID | cut -d'"' -f 2 }

# To avoid a bug: 1%-12% seems to be 78%-100%
# while 12%-100% seems to be 0%-100%
# Lenovo Legion 5 Pro with GTX 3070
blight    () { echo $((($(brightnessctl g)-12)*100/88)) }

volume    () {
  raw=$(pamixer --get-volume-human)
  if [[ $raw == "muted" ]]; then raw="MM" fi
  echo $raw
}

echo "*$(blight)%  ♪$(volume)  ☎$(ssid)  ✺$(datetime) "

