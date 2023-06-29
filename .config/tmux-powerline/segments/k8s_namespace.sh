run_segment() {
  if type kubens >/dev/null 2>&1; then
    __ns="$(kubens -c)"
    if [ "${#__ns}" -gt 32 ]; then
      __ns="$(echo "$__ns" | cut -c1-29)..."
    fi
    echo "󱃾 $__ns"
  fi
}
