#!/bin/bash

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

FONT="Hack Nerd Font" # Nerd font is preferred
PADDINGS=0                     # All paddings use this value (icon, label, background)

THEME="dark" # light|dark
AUTO_SWITCH_THEME=on

LIGHT_START_TIME="06:00"
LIGHT_END_TIME="15:00"
LIGHT_WALLPAPER=$(realpath ~/Pictures/bg/light.jpg)
DARK_WALLPAPER=$(realpath ~/Pictures/bg/dark.jpg)
VPN_NAME="Shadowrocket"
# Ensure that the query and srcid parameters lead to a valid, existing page.
# For example: https://weathernew.pae.baidu.com/weathernew/pc?query=杭州西湖天气&srcid=4982&forecast=long_day_forecast
WEATHER_BAIDU_QUERY="开普敦天气"
WEATHER_BAIDU_SRCID="20099"
# To find your city’s station ID, visit: https://www.nmc.cn/publish/forecast.html
# Note: NMC (China Meteorological Administration) primarily covers China; for Cape Town, consider using a global service or alternative API.
# A placeholder is provided; verify or replace with a suitable endpoint for international forecasts.
WEATHER_NMC_STATIONID="CAPETOWN"
WEATHER_METEO_LATITUDE=-33.9249
WEATHER_METEO_LONGITUDE=18.4241
is_dark_mode() {
  # Your implementation here (e.g., check time against LIGHT_START_TIME and LIGHT_END_TIME)
  current_hour=$(date +%H:%M)
  if [[ "$current_hour" > "$LIGHT_END_TIME" || "$current_hour" < "$LIGHT_START_TIME" ]]; then
    echo true
  else
    echo false
  fi
}
# General bar colors
if is_dark_mode; then
    BAR_COLOR=$TRANSPARENT
    BAR_BORDER_COLOR=$TRANSPARENT
    ICON_COLOR=$WHITE
    LABEL_COLOR=$WHITE
    HIGHLIGHT_COLOR=$GREY
    POPUP_BACKGROUND_COLOR=$BG3
    POPUP_BORDER_COLOR=$WHITE
    BACKGROUND_COLOR=$BG0
    BACKGROUND_BORDER_COLOR=$BG2
else
    BAR_COLOR=$TRANSPARENT1
    BAR_BORDER_COLOR=$TRANSPARENT1
    ICON_COLOR=$BLACK
    LABEL_COLOR=$BLACK
    HIGHLIGHT_COLOR=$BLACK
    POPUP_BACKGROUND_COLOR=$BG3
    POPUP_BORDER_COLOR=$BLACK
    BACKGROUND_COLOR=$BG0
    BACKGROUND_BORDER_COLOR=$BG2
fi

bar=(
    position=top
    topmost=window
    sticky=off
    height=24
    color=$BAR_COLOR
    border_color=$BAR_BORDER_COLOR
    blur_radius=10
)

default=(
    updates=when_shown

    icon.font.family="$FONT"
    icon.font.style="Bold"
    icon.font.size=14.0
    icon.color=$ICON_COLOR
    icon.highlight_color=$HIGHLIGHT_COLOR
    icon.padding_left=$PADDINGS
    icon.padding_right=$PADDINGS

    label.font.family="$FONT"
    label.font.style="Semibold"
    label.font.size=13.0
    label.color=$LABEL_COLOR
    label.highlight_color=$HIGHLIGHT_COLOR

    padding_right=$PADDINGS
    padding_left=$PADDINGS

    popup.blur_radius=50
    popup.background.border_width=0
    popup.background.corner_radius=5
    popup.background.border_color=$POPUP_BORDER_COLOR
    popup.background.color=$POPUP_BACKGROUND_COLOR

    background.height=24
    background.border_width=1
    background.corner_radius=5
)

popup_item=(
    icon.drawing=off
    label.color=$WHITE
    label.padding_left=$PADDINGS
    label.padding_right=$PADDINGS
)

popup_events=(
    mouse.entered
    mouse.exited
    mouse.exited.global
)

popup() {
    sketchybar --set $NAME popup.drawing=$1
}
