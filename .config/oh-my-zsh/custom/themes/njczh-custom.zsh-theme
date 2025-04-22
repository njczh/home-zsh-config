###########################################################################
# time
###########################################################################
function real_time() {
    # color in PROMPT need format in %{XXX%} which is not same with echo
    local color="%{$fg_no_bold[white]%}";
    local time="[$(date +%H:%M:%S)]";
    local color_reset="%{$reset_color%}";
    echo "${color}${time}${color_reset}";
}


###########################################################################
# login_info
###########################################################################
function login_info() {
    # color in PROMPT need format in %{XXX%} which is not same with echo
    local color="%{$fg_no_bold[white]%}";
    local ip
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        # Linux
        ip="$(ifconfig | grep -E '^eno1|^eth1|^bond|^em1' -A 1 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | head -1)";
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        ip="$(ifconfig | grep ^en1 -A 4 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' | head -1)";
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
    elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
    else
        # Unknown.
    fi
    local color_reset="%{$reset_color%}";
    # ??? if user_info = # then ... else ...
    local user_info="%(#,%{$bg[yellow]%}%{$fg[black]%}%n${color_reset},${color}%n${color_reset})"
    echo "${color}<${color_reset}${user_info}${color}@${ip}:%m>${color_reset}";
}


###########################################################################
# conda_env_info
###########################################################################
function conda_info() {
    local PYTHON_VERSION="$(python -V 2>&1)"
    local PYTHON_VERSION=${PYTHON_VERSION/Python /Python}
    local PYTHON_VERSION=${PYTHON_VERSION/ */}

    local color="%{$fg_no_bold[yellow]%}";
    local conda_env="$CONDA_DEFAULT_ENV";
    local color_reset="%{$reset_color%}";
    echo "${color}(${conda_env}::${PYTHON_VERSION})${color_reset}";
}


###########################################################################
# directory
###########################################################################
function directory() {
    local color="%{$fg_no_bold[cyan]%}";
    # REF: https://stackoverflow.com/questions/25944006/bash-current-working-directory-with-replacing-path-to-home-folder
    local directory="${PWD/#$HOME/~}";
    # local directory="%/";
    local color_reset="%{$reset_color%}";
    echo "${color}${directory}${color_reset}";
}


###########################################################################
# git 
###########################################################################
# git_prompt_status  
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+ "
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}! "
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}- "
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}> "
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}# "
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}? "

# git_prompt_info
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_no_bold[blue]%}[ git::%{$reset_color%}%{$fg_no_bold[red]%}";
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_no_bold[blue]%}] %{$reset_color%}";
# TODO
ZSH_THEME_GIT_PROMPT_DIRTY="* $(git_prompt_status)%{$reset_color%}";
ZSH_THEME_GIT_PROMPT_CLEAN=" ";

function update_git_status() {
    GIT_STATUS="$(git_prompt_info)";
}

function git_status() {
    echo "${GIT_STATUS}"
}


###########################################################################
# command
###########################################################################
function update_command_status() {
    local arrow="";
    local color_reset="%{$reset_color%}";
    local reset_font="%{$fg_no_bold[white]%}";
    COMMAND_RESULT=$1;
    export COMMAND_RESULT=$COMMAND_RESULT
    if $COMMAND_RESULT;
    then
        arrow="%{$fg_bold[red]%}>%{$fg_bold[yellow]%}>%{$fg_bold[green]%}>";
    else
        arrow="%{$fg_bold[red]%}>>>";
    fi
    COMMAND_STATUS="${arrow}${reset_font}${color_reset}";
}
update_command_status true;

function command_status() {
    echo "${COMMAND_STATUS}"
}


# output command execute after
output_command_execute_after() {
    if [ "$COMMAND_TIME_BEIGIN" = "-20200325" ] || [ "$COMMAND_TIME_BEIGIN" = "" ];
    then
        return 1;
    fi

    # cmd
    local cmd="CMD histroy No.${${$(fc -l | tail -1)#*  }/  /:\"}\"";
    local color_cmd="";
    if $1;
    then
        color_cmd="$fg_no_bold[green]";
    else
        color_cmd="$fg_bold[red]";
    fi
    local color_reset="$reset_color";
    cmd="${color_cmd}${cmd}${color_reset}"

    # time
    local time="[$(date +%H:%M:%S)]"
    local color_time="$fg_no_bold[white]";
    time="${color_time}${time}${color_reset}";

    # cost
    local time_end="$(current_time_millis)";
    local cost=$(bc -l <<<"${time_end}-${COMMAND_TIME_BEIGIN}");
    COMMAND_TIME_BEIGIN="-20200325"
    local length_cost=${#cost};
    if [ "$length_cost" = "4" ];
    then
        cost="0${cost}"
    fi
    cost="(cost ${cost}s)"
    local color_cost="$fg_no_bold[white]";
    cost="${color_cost}${cost}${color_reset}";

    echo -e "${time} ${cmd} ${cost}";
    echo -e "";
}


# command execute before
# REF: http://zsh.sourceforge.net/Doc/Release/Functions.html
preexec() {
    COMMAND_TIME_BEIGIN="$(current_time_millis)";
}

current_time_millis() {
    local time_millis;
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        # Linux
        time_millis="$(date +%s.%3N)";
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        time_millis="$(gdate +%s.%3N)";
    elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
    elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
    elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
    elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
    else
        # Unknown.
    fi
    echo $time_millis;
}


# command execute after
# REF: http://zsh.sourceforge.net/Doc/Release/Functions.html
precmd() {
    # last_cmd
    local last_cmd_return_code=$?;
    local last_cmd_result=true;
    if [ "$last_cmd_return_code" = "0" ];
    then
        last_cmd_result=true;
    else
        last_cmd_result=false;
    fi

    # update_git_status
    update_git_status;

    # update_command_status
    update_command_status $last_cmd_result;

    # output command execute after
    output_command_execute_after $last_cmd_result;
}


# set option
setopt PROMPT_SUBST;
autoload zsh/terminfo


# timer
# TRAPALRM函数每隔TMOUT秒就会被调用一次(在本例中为1)，在这里它执行提示刷新，并一直执行直到命令开始执行为止(并且不会干扰您在按Enter之前在提示上键入的任何内容)。
#REF: https://stackoverflow.com/questions/26526175/zsh-menu-completion-causes-problems-after-zle-reset-prompt
TMOUT=1;
TRAPALRM() {
    # $(git_prompt_info) cost too much time which will raise stutters when inputting. so we need to disable it in this occurence.
    # if [ "$WIDGET" != "expand-or-complete" ] && [ "$WIDGET" != "self-insert" ] && [ "$WIDGET" != "backward-delete-char" ]; then
    # expand-or-complete|self-insert|up-line-or-beginning-search|down-line-or-beginning-search|backward-delete-char|.history-incremental-search-backward|.history-incremental-search-forward
    # black list will not enum it completely. even some pipe broken will appear.
    # so we just put a white list here.
    # echo "$WIDGET"
    if [ "$WIDGET" = "" ] || [ "$WIDGET" = "accept-line" ] ; then
        zle reset-prompt;
    fi
}

###########################################################################
# prompt
###########################################################################
PROMPT='$(conda_info)
$(real_time) $(directory) $(git_status)$(login_info)
$(command_status) ';
