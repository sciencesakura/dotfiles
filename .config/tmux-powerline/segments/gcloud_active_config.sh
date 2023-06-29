run_segment() {
  if [ -r "$XDG_CONFIG_HOME/gcloud/active_config" ]; then
    __config="$(cat "$XDG_CONFIG_HOME/gcloud/active_config")"
    if [ "${#__config}" -gt 32 ]; then
      __config="$(echo "$__config" | cut -c1-29)..."
    fi
    echo "󱇶 $__config"
  fi
}
