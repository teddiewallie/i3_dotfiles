#!/bin/zsh

NOESCAPE=false

init () {
  feh --bg-scale ~/Pictures/bg.png
  setxkbmap se_prog -option caps:super
  xrdb -merge ~/.Xresources
  rmmod pcspkr
  picom &
}


width () {
  NOESCAPE=true
  case $1 in
    inc) i3-msg resize grow width 10 px ;;
    dec) i3-msg resize shrink width 10 px ;;
  esac
}
 
height () {
  NOESCAPE=true
  case $1 in
    inc) i3-msg resize grow height 10 px ;;
    dec) i3-msg resize shrink height 10 px ;;
  esac
}

backlight () {
  NOESCAPE=true

  # To avoid a bug: 0%-12% seems to be 78%-100%
  # while 12%-100% seems to be 0%-100%
  # Lenovo Legion 5 Pro with GTX 3070
  perc=$((($(brightnessctl g)-12)*100/88))

  case $1 in
    max) brightnessctl set '100%';;
    min) brightnessctl set '12%' ;;

    INC) brightnessctl set '+8%' ;;

    DEC)
      if [[ $perc -gt 3 ]]; then
        brightnessctl set '8%-'
      fi
    ;;
    inc) brightnessctl set '+4%' ;;
    dec)
      if [[ $perc -gt 3 ]]; then
        brightnessctl set '4%-'
      fi
    ;;
    *) brightnessctl set $1 ;;
  esac
}

volume () {
  NOESCAPE=true
  case $1 in
    INC) pamixer -i 8 ;;
    DEC) pamixer -d 8 ;;

    inc) pamixer -i 4 ;;
    dec) pamixer -d 4 ;;
    mute)
      NOESCAPE=false
      pamixer -t
    ;;
    *) pamixer --set-volume $1 ;;
  esac
}

wmove_noescape () {
  NOESCAPE=true
  i3-msg move container to workspace number $1
}

workspace_noescape () {
  NOESCAPE=true
  i3-msg workspace number $1
}

run_runner () {
  exec $(print -rC1 -- ${(kc)commands} | bemenu \
    --fn 'CMU Typewriter Text 16' \
    --tb  '#282828' \
    --fb  '#282828' \
    --nb  '#282828' \
    --hb  '#282828' \
    --fbb '#282828' \
    --sb  '#282828' \
    --ab  '#282828' \
    --scb '#282828' \
    --bdr '#282828' \
    --tf  '#aaaa88' \
    --ff  '#aaaa88' \
    --nf  '#aaaa88' \
    --hf  '#ccccaa' \
    --fbf '#aaaa88' \
    --sf  '#aaaa88' \
    --af  '#aaaa88' \
    --scf '#aaaa88' \
    --hp 10000 \
    -p ' ' \
    ) &
}

fullscreen      () { i3-msg fullscreen toggle }
workspace       () { i3-msg workspace number $1 }
wmove           () { i3-msg move container to workspace number $1 }
move            () { i3-msg move $1 }
move_noescape   () { NOESCAPE=true; i3-msg move $1 }
focus           () { i3-msg focus $1 }
sticky          () { i3-msg sticky toggle }
floating        () { i3-msg floating toggle }
restart         () { i3-msg restart }
quit            () { i3-msg kill }
key             () { xdotool key $1 }
mode            () { NOESCAPE=true; i3-msg mode $1 }
toggle_bar      () { i3-msg bar mode toggle }

susp            () { sudo systemctl suspend }

run_1password   () { 1password --quick-access & }
run_alacritty   () { alacritty & }
run_firefox     () { firefox &   }
run_steam       () { steam &     }

not_implemented () { NOESCAPE=true; echo "not implemented" }

case $1 in
  init)               init                    ;;
  fullscreen)         fullscreen              ;;
  workspace)          workspace           $2  ;;
  sticky)             sticky                  ;;
  floating)           floating                ;;
  move)               move                $2  ;;
  wmove)              wmove               $2  ;;
  focus)              focus               $2  ;;
  restart)            restart                 ;;
  quit)               quit                    ;;
  width)              width               $2  ;;
  height)             height              $2  ;;
  mode)               mode                $2  ;;
  backlight)          backlight           $2  ;;
  volume)             volume              $2  ;;
  susp)               susp                    ;;
  key)                key                 $2  ;;
  toggle_bar)         toggle_bar              ;;

  run_1password)      run_1password           ;;
  run_alacritty)      run_alacritty           ;;
  run_firefox)        run_firefox             ;;
  run_steam)          run_steam               ;;
  run_runner)         run_runner              ;;

  move_noescape)      move_noescape       $2  ;;
  wmove_noescape)     wmove_noescape      $2  ;;
  workspace_noescape) workspace_noescape  $2  ;;

  *) not_implemented ;;
esac

$NOESCAPE && return

mode default

