mkdir -p "${TMPDIR:-/tmp}/zsh-${UID}"

for file (
  /usr/share/doc/pkgfile/command-not-found.zsh
  /opt/homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh
  /usr/local/Homebrew/Library/Taps/homebrew/homebrew-command-not-found/handler.sh
  ); do
  if [[ -r "$file" ]]; then
    cat "$file" >! "${COMMAND_NOT_FOUND_CACHE_FILE}"
  fi
done
unset file

if [[ -x /usr/lib/command-not-found  ]]; then
  echo 'command_not_found_handler() {
/usr/lib/command-not-found -- "$1"
return $?
  }' >! "${COMMAND_NOT_FOUND_CACHE_FILE}"
fi

if [[ -x /usr/share/command-not-found/command-not-found  ]]; then
  echo 'command_not_found_handler() {
/usr/share/command-not-found/command-not-found -- "$1"
return $?
  }' >! "${COMMAND_NOT_FOUND_CACHE_FILE}"
fi

if [[ -x /usr/libexec/pk-command-not-found   ]]; then
  echo 'command_not_found_handler() {
if [[ -S /var/run/dbus/system_bus_socket && -x /usr/libexec/packagekitd ]]; then
/usr/libexec/pk-command-not-found "$@"
return $?
  fi' >! "${COMMAND_NOT_FOUND_CACHE_FILE}"
fi

if [[ -x /run/current-system/sw/bin/command-not-found   ]]; then
  echo 'function command_not_found_handler() {
/run/current-system/sw/bin/command-not-found "$@"
  }' >! "${COMMAND_NOT_FOUND_CACHE_FILE}"
fi

if [[ -x /data/data/com.termux/files/usr/libexec/termux/command-not-found  ]]; then
  echo 'function command_not_found_handler() {
/data/data/com.termux/files/usr/libexec/termux/command-not-found "$1"
  }' >! "${COMMAND_NOT_FOUND_CACHE_FILE}"
fi

source "${COMMAND_NOT_FOUND_CACHE_FILE}"
