#!/bin/sh

get_batt_lv() {
  pmset -g batt | sed -nE 's/^.*[[:blank:]]([[:digit:]]+)%.*$/\1/p'
}

level=$(get_batt_lv)
[ -z "$level" ] && exit
format='%s  %3d%%'
if [ $level = 100 ]; then
  stat=''
elif [ $level -ge 75 ]; then
  stat=''
elif [ $level -ge 50 ]; then
  stat=''
else
  stat=''
  format="#[fg=#e27878]${format}#[default]"
fi
printf "$format" $stat $level
