PROMPT=$'%{$fg_bold[green]%}%n@%m %{$fg[blue]%}%D{[%X]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info)%{$fg_bold[green]%} %#%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
