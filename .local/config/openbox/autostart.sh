#!/usr/bin/env sh
#
# These things are run when an Openbox X Session is started.
# You may place a similar script in "${HOME}/.config/openbox/autostart" to run user-specific things.
#
# https://github.com/owl4ce/dotfiles
#
# shellcheck disable=SC3044,SC2091,SC2086
# ---

#exec >/dev/null 2>&1
. "${XDG_CONFIG_HOME}/joyfuld"

[ -z "$BASH" ] || shopt -s expand_aliases

{ [ "$(joyd_launch_apps -g terminal)" = 'urxvtc' ] && urxvtd -f -q; } &

joyd_toggle_mode apply
joyd_tray_programs exec

xsettingsd &
picom -b

$(find ${LIBS_PATH} -type f -iname 'polkit-gnome-authentication-agent-*' | sed 1q) &

{ [ -x "$(command -v xss-lock)" ] && xss-lock -q -l "${JOYD_DIR}/xss-lock-tsl.sh"; } &

joyd_mpd_notifier

pipewire &
pipewire-pulse &
wireplumber &

# Tumblerd Fix
tumblerd-fix &
