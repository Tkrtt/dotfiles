#!/usr/bin/env sh
# shellcheck disable=SC2166,SC2016
set -x

export LANG='POSIX'
exec 2>/dev/null
. "${XDG_CONFIG_HOME}/joyfuld"
[ -x "$(command -v iwgetid)" -o -x "$(command -v ip)" ] || exec echo 'Install `wireless-tools` and/or `iproute2`!'
if GET_ET="$(ip addr show "$IFACE_ET")" && [ -n "$GET_ET" ]; then
    IP_ET="${GET_ET##*inet\ }" IP_ET="${IP_ET%%\ brd*}"
    case "$IP_ET" in
        *'
'*       ) ICON=''
           STAT="No IP Address @ ${IFACE_ET}"
        ;;
        *) ICON=''
           STAT="${IP_ET} @ ${IFACE_ET}"
        ;;
    esac
elif GET_USB="$(ip addr show "$IFACE_USB")" && [ -n "$GET_USB" ]; then
    IP_USB="${GET_USB##*inet\ }" IP_USB="${IP_USB%%\ brd*}"
    case "$IP_USB" in
        *'
'*       ) ICON=''
           STAT="No IP Address @ ${IFACE_USB}"
        ;;
        *) ICON=''
           STAT="${IP_USB} @ ${IFACE_USB}"
        ;;
    esac
elif GET_WL="$(iwgetid "$IFACE_WL")" && [ -n "$GET_WL" ]; then
    ESSID="${GET_WL##*:\"}" ESSID="${ESSID%\"}"
    if [ -n "$ESSID" ]; then
        IP_WL="$(ip addr show "$IFACE_WL")"
        if [ -z "${IP_WL%%*inet*\ *}" ]; then
            ICON=''
            STAT="${ESSID} @ ${IFACE_WL}"
        else
            ICON=''
            STAT="No IP Address @ ${IFACE_WL}"
        fi
    else
        ICON=''
        STAT="Disconnected @ ${IFACE_WL}"
    fi
else
    ICON=''
    STAT="Invalid \"${IFACE_WL}\", \"${IFACE_USB}\" and \"${IFACE_ET}\" network interfaces"
fi
case "${1}" in
    icon) echo "$ICON"
    ;;
    sta*) echo "$STAT"
    ;;
esac
exit ${?}
