if [ -f $HOME/.bashrc ]; then
        source $HOME/.bashrc
fi

export PATH="$HOME/.poetry/bin:$PATH"

[ -s "/Users/carl.worley/.jabba/jabba.sh" ] && source "/Users/carl.worley/.jabba/jabba.sh"
