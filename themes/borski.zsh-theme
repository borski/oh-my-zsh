# Based on lukerandall and gallois

local return_code="%(?..%{$fg_bold[red]%}%? ↵%{$reset_color%})"

ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✓"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[blue]%}(%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[blue]%})"

# ----------------------------------------------------------------------------
# Shows little symbol '±' if you're currently at a git repo,
#                     '☿' if you're currently at a hg repo,
#                     '⚡' if you're currently at a svn repo,
#                 and '○' all other times
# ----------------------------------------------------------------------------
prompt_char() {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    svn info >/dev/null 2>/dev/null && echo '⚡' && return
    echo '○'
}

local_dir() {
  echo "%{$reset_color%}%B%~% %b"
}

user_host() {
  echo "%{$fg[cyan]%}%m%{$reset_color%}"
}

rvm_env() {
  if [[ -e ~/.rvm/bin/rvm-prompt ]] ; then
    echo "%{$fg[red]%}|`~/.rvm/bin/rvm-prompt`|%{$reset_color%}"
  elif [[ -e /usr/local/rvm/bin/rvm-prompt ]] ; then
    echo  "%{$fg[red]%}|`/usr/local/rvm/bin/rvm-prompt`|%{$reset_color%}"
  fi
}

py_venv() {
  if [ -n "$VIRTUAL_ENV" ] ; then
    echo "%{${fg[green]}%}|`basename \"$VIRTUAL_ENV\"`|%{${reset_color}%}"
  fi
}

PROMPT='
$(py_venv)$(rvm_env) $(user_host) %{$fg[yellow]%}in%{$reset_color%} $(local_dir)
$(prompt_char) $(git_prompt_info)%{$reset_color%} %{$fg[yellow]%}→%{$fg[white]%} '