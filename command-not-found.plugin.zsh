ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-${TMPDIR:-/tmp}/zsh-${UID:-user}}"
COMMAND_NOT_FOUND_CACHE_FILE="${ZSH_CACHE_DIR}/command-not-found.zsh"

source "${COMMAND_NOT_FOUND_CACHE_FILE}" 2>/dev/null || {
  # Standarized $0 handling, following:
  # https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html
  0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
  0="${${(M)0:#/*}:-$PWD/$0}"

  source "${0:h}/gen.zsh"
}
