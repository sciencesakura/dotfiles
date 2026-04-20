# shellcheck shell=bash
TMUX_POWERLINE_SEG_GCLOUD_ACTIVE_CONFIG_SYMBOL="${TMUX_POWERLINE_SEG_GCLOUD_ACTIVE_CONFIG_SYMBOL:-󱇶 }"

generate_segmentrc() {
  read -r -d '' rccontents <<EORC
# Symbol for Google Cloud Active Configuration
# export TMUX_POWERLINE_SEG_GCLOUD_ACTIVE_CONFIG_SYMBOL="${TMUX_POWERLINE_SEG_GCLOUD_ACTIVE_CONFIG_SYMBOL}"
EORC
  echo "$rccontents"
}

run_segment() {
  type gcloud >/dev/null 2>&1 || return 0
  active_config="$(gcloud info --format='value(config.active_config_name)')"
  [ -n "$active_config" ] && echo "${TMUX_POWERLINE_SEG_GCLOUD_ACTIVE_CONFIG_SYMBOL}${active_config}"
}
