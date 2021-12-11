my-accept-line() {
  zle _expand_alias
  zle expand-word
  zle accept-line
}

# create a widget from `my-accept-line' with the same name
zle -N my-accept-line

# rebind Enter, usually this is `^M'
bindkey '^M' my-accept-line

reload() {
  source "${HOME}/.zshrc"
}

zedit() {
  ${EDITOR:-vim} "${HOME}/.zshrc"
}
