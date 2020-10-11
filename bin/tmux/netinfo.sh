#!/bin/sh

get_ipadrs() {
  ifconfig en0 inet 2>/dev/null | sed -nE 's/^[[:blank:]]*inet[[:blank:]]*(([[:digit:]]|\.)+).*$/\1/p'
}

ipadrs=$(get_ipadrs)
if [ -n "$ipadrs" ]; then
  stat=''
else
  stat=''
fi
printf "$stat $ipadrs"
