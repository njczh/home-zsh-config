###############################################################################
#                          OH MY ZSH CONFIGURATION                            #
###############################################################################

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="njczh-custom"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 14

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="%y/%m/%d %T"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    zsh-256color            # 使 auto suggestion 半透明
    colored-man-pages
    command-not-found
    cp
    extract
    git
    sudo
    safe-paste
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh



###############################################################################
#                           USER CONFIGURATION                                #
###############################################################################

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/.local/bin

# export MANPATH="/usr/local/man:$MANPATH"

# CUDA CONFIGURATION
#
#export CUDA_HOME=/usr/local/cuda-10.0
#export CUDA_HOME=/usr/local/cuda-11.3 
export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH=$CUDA_HOME/lib64
export PATH=$PATH:$CUDA_HOME/bin

# You may need to manually set your language environment
# Chinese
#export LANGUAGE="zh_CN.UTF-8:en_US.UTF-8"
#export LC_ALL="zh_CN.UTF-8"
#export LANG="zh_CN.UTF-8"
#
# English
export LANGUAGE="en_US.UTF-8:zh_CN.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# COMPILATION FLAGS
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# EXAMPLE ALIASES
alias zshconfig='vim ~/.zshrc'
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
export hostip=10.177.45.171
alias setss='export https_proxy="http://${hostip}:7890";export http_proxy="http://${hostip}:7890";export all_proxy="socks5://${hostip}:7890";'
alias unsetss='unset all_proxy; unset http_proxy; unset https_proxy;'
alias myip="curl myip.ipip.net"
#
# some more ls aliases
alias ll='ls -alhF'
alias la='ls -Ah'
alias l='ls -hCF'
#
#alias cp='/usr/local/bin/advcp -g'
#alias mv='/usr/local/bin/advmv -g'
#
alias cls='clear'
#
alias grep="grep --color=auto"
alias -s html='vim'             # 在命令行直接输入后缀为 html 的文件名，会在 Vim 中打开
alias -s rb='vim'               # 在命令行直接输入 ruby 文件，会在 Vim 中打开
alias -s py='vim'               # 在命令行直接输入 python 文件，会用 vim 中打开，以下类似
alias -s js='vim'
alias -s c='vim'
alias -s txt='vim'
alias -s gz='tar -xzvf'         # 在命令行直接输入后缀为 gz 的文件名，会自动解压打开
alias -s tgz='tar -xzvf'
alias -s zip='unzip'
alias -s bz2='tar -xjvf'

alias cman='man -M /usr/share/man/zh_CN'

# 如果终端支持truecolor, 用之
case $TERM in
    # export TERM="xterm-256color" # Enable 256 color to make auto-suggestions look nice?
    # 别在zsh里改TERM
    (screen-256color |  tmux-256color   |  xterm-256color  )
        # Set the COLORTERM environment variable to 'truecolor' to advertise 24-bit color support
        # COLORTERM 的选项:no|yes|truecolor
        export COLORTERM=truecolor
        ;;           # 一个分号能把2个命令串在一起,所以要2个分号
    (*)              #  (*) :  a final pattern to define the default case  This pattern will always match? 不是啊, 就跟if else差不多
        echo '$TERM='
        echo $TERM
        echo '---'
        echo '$COLORTERM='
        echo ${COLORTERM}
        ;;
esac

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

setopt no_nomatch

## Check if ~/.pid_ssh_agent exists.
#if [ -f ~/.pid_ssh_agent ]; then
#
#    source ~/.pid_ssh_agent
#
#    # Check process of ssh-agent still exists.
#    TEST=$(ssh-add -l)
#
#    if [ -z "$TEST" ]; then # Reinit if not.
#        NEED_INIT=1
#    fi
#else
#    NEED_INIT=1 # PID file doesm't exist, reinit it.
#fi
#
## Try start ssh-agent.
#if [ ! -z "$NEED_INIT" ]; then
#    echo $(ssh-agent -s) | sed -e 's/echo[ A-Za-z0-9]*;//g' > ~/.pid_ssh_agent # save the PID to file.
#    source ~/.pid_ssh_agent
#fi

# Note the source command must be at the end of .zshrc
source "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
