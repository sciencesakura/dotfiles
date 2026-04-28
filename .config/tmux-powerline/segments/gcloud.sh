# shellcheck shell=bash
TMUX_POWERLINE_SEG_GCLOUD_DISPLAY_MODE_DEFAULT=project
TMUX_POWERLINE_SEG_GCLOUD_SYMBOL_DEFAULT='󱇶 '
TMUX_POWERLINE_SEG_GCLOUD_ACCOUNT_PROJECT_SEPARATOR_DEFAULT='󰿟'

generate_segmentrc() {
	read -r -d '' rccontents <<EORC
# Which Google Cloud properties to display. Can be {"project", "account_and_project", "active_config_name"}.
# export TMUX_POWERLINE_SEG_GCLOUD_DISPLAY_MODE="$TMUX_POWERLINE_SEG_GCLOUD_DISPLAY_MODE_DEFAULT"
# The symbol for Google Cloud.
# export TMUX_POWERLINE_SEG_GCLOUD_SYMBOL="$TMUX_POWERLINE_SEG_GCLOUD_SYMBOL_DEFAULT"
# The separator to use between Google Cloud account and project. This environment variable is used only when
# TMUX_POWERLINE_SEG_GCLOUD_DISPLAY_MODE is set to 'account_and_project'.
# export TMUX_POWERLINE_SEG_GCLOUD_ACCOUNT_PROJECT_SEPARATOR="$TMUX_POWERLINE_SEG_GCLOUD_ACCOUNT_PROJECT_SEPARATOR_DEFAULT"
EORC
	echo "$rccontents"
}

run_segment() {
	__process_settings

	if ! type gcloud >/dev/null 2>&1; then
		echo 'gcloud was not found'
		return 1
	fi

	local format_expr status
	case "$TMUX_POWERLINE_SEG_GCLOUD_DISPLAY_MODE" in
		project)
			format_expr='value(config.project)';;
		account_and_project)
			format_expr="value[separator='$TMUX_POWERLINE_SEG_GCLOUD_ACCOUNT_PROJECT_SEPARATOR'](config.account,config.project)";;
		active_config_name)
			format_expr='value(config.active_config_name)';;
		*)
			echo 'TMUX_POWERLINE_SEG_GCLOUD_DISPLAY_MODE must be one of "project", "account_and_project" or "active_config_name"'
			return 1;;
	esac
	status="$(gcloud info --format="$format_expr")"
	[ -n "$status" ] && echo "${TMUX_POWERLINE_SEG_GCLOUD_SYMBOL}${status}"
}

__process_settings() {
	if [ -z "$TMUX_POWERLINE_SEG_GCLOUD_DISPLAY_MODE" ]; then
		export TMUX_POWERLINE_SEG_GCLOUD_DISPLAY_MODE="$TMUX_POWERLINE_SEG_GCLOUD_DISPLAY_MODE_DEFAULT"
	fi
	if [ -z "$TMUX_POWERLINE_SEG_GCLOUD_SYMBOL" ]; then
		export TMUX_POWERLINE_SEG_GCLOUD_SYMBOL="$TMUX_POWERLINE_SEG_GCLOUD_SYMBOL_DEFAULT"
	fi
	if [ -z "$TMUX_POWERLINE_SEG_GCLOUD_ACCOUNT_PROJECT_SEPARATOR" ]; then
		export TMUX_POWERLINE_SEG_GCLOUD_ACCOUNT_PROJECT_SEPARATOR="$TMUX_POWERLINE_SEG_GCLOUD_ACCOUNT_PROJECT_SEPARATOR_DEFAULT"
	fi
}
