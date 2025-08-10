#!/bin/sh
# System path
export PATH="${HOME}/.local/bin:${PATH}"

### CLEANING HOME
# CALCHIST + GNUPG + W3M
export CALCHISTFILE=${XDG_CACHE_HOME}/calc_history
export GNUPGHOME=${XDG_DATA_HOME}/gnupg
export W3M_DIR=${XDG_STATE_HOME}/w3m
# RUST + GO + CCACHE + NODEJS + JAVA
export RUSTUP_HOME=${XDG_DATA_HOME}/rustup
export CARGO_HOME=${XDG_DATA_HOME}/cargo
export NVM_DIR=${XDG_DATA_HOME}/nvm
export NPM_CONFIG_USERCONFIG=${XDG_CONFIG_HOME}/npm/npmrc
export GOPATH=${XDG_DATA_HOME}/go
export GOMODCACHE=${XDG_CACHE_HOME}/go/mod
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export MAVEN_OPTS=-Dmaven.repo.local="$XDG_DATA_HOME"/maven/repository
export USE_CCACHE=1
export CCACHE_EXEC=/usr/bin/ccache
export CCACHE_DIR=/media/Local-Media/ccache
# DOCKER + K8S + TALOS + ANSIBLE
export DOCKER_CONFIG=${XDG_CONFIG_HOME}/docker
export KUBECONFIG=${XDG_CONFIG_HOME}/kube/config
export KUBECACHEDIR=${XDG_CACHE_HOME}/kube/cache
export TALOSCONFIG=${XDG_CONFIG_HOME}/talos/config
export ANSIBLE_CONFIG=${XDG_CONFIG_HOME}/ansible/ansible.cfg
export ANSIBLE_HOME=${XDG_DATA_HOME}/ansible
export ANSIBLE_GALAXY_CACHE_DIR=${XDG_CACHE_HOME}/ansible/galaxy_cache
# POSTGRESQL + SQLITE
export PSQLRC=${XDG_CONFIG_HOME}/pg/psqlrc
export PSQL_HISTORY=${XDG_STATE_HOME}/psql_history
export PGPASSFILE=${XDG_CONFIG_HOME}/pg/pgpass
export PGSERVICEFILE=${XDG_CONFIG_HOME}/pg/pg_service.conf
export SQLITE_HISTORY=$XDG_DATA_HOME/sqlite_history
# MICROSOFT
export AZURE_CONFIG_DIR=${XDG_DATA_HOME:-HOME/.config}/azure
export WINEPREFIX="$XDG_DATA_HOME"/wine
export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet
# ADB
export ANDROID_USER_HOME="$XDG_DATA_HOME"/android
export RENPY_PATH_TO_SAVES="$XDG_DATA_HOME/renpy"

### AND STARTING X
if [[ -z $DISPLAY ]] && (( $EUID != 0 )) && [[ $TTY == /dev/tty1 ]]; then
 [ ! -d "${HOME}/.local/share/Xorg" ] || rm -rf "${HOME}/.local/share/Xorg"
 exec startx -- vt01 -nolisten tcp 2>/dev/null
fi
