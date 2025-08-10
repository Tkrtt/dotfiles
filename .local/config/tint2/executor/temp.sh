#!/usr/bin/env sh
export LANG='POSIX'
exec 2>/dev/null
. "${XDG_CONFIG_HOME}/joyfuld"
TEMPERATURE_DEVICE="/sys/class/hwmon/${TEMP_DEV}"
if [ -f "${TEMPERATURE_DEVICE}/temp1_input" ]; then
    IFS= read -r TEMP <"${TEMPERATURE_DEVICE}/temp1_input"
    echo "$((TEMP/1000))˚C"
else
    echo "Invalid ${TEMPERATURE_DEVICE} interface!"
fi
exit ${?}
