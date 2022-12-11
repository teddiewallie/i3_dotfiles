#!/bin/zsh

date_out  () { date +"%H:%m" }
ssid      () { iwconfig wlp4s0 | grep ESSID | cut -d'"' -f 2 }

blight    () { echo $((($(brightnessctl g)-12)*100/88)) }

volume    () {
  raw=$(pamixer --get-volume-human)
  if [[ $raw == "muted" ]]; then raw="MM" fi
  echo $raw
}

echo "*$(blight)%  ♪$(volume)  ☎$(ssid)  ✺$(date_out) "


