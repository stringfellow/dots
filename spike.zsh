function new_session() {
    create_session $@
    tmux attach-session -t$1
}

function create_session() {
    if (( $# >= 1 )); then
        SESSION_NAME=$1
        NUM_WINDOWS=${2:=0}
        tmux -2 new-session -d -s $SESSION_NAME -n zsh

        tmux set-option -t$SESSION_NAME update-environment \
            "WORKON_HOME PIP_VIRTUALENV_BASE PIP_RESPECT_VIRTUALENV VIRTUAL_ENV PYTHONPATH DJANGO_SETTINGS_MODULE DJANGO_DEVELOPMENT"
        tmux set-option -t$SESSION_NAME default-path $(pwd)

        # these environment variables should be inherited into the session
        # being created, but blocked from entering into the global environment
        tmux set-environment -gr VIRTUAL_ENV
        tmux set-environment -gr PYTHONPATH
        tmux set-environment -gr DJANGO_SETTINGS_MODULE
        tmux set-environment -gr DJANGO_DEVELOPMENT

        tmux set-environment -t$SESSION_NAME VIRTUAL_ENV $VIRTUAL_ENV
        tmux set-environment -t$SESSION_NAME PYTHONPATH $PYTHONPATH
        tmux set-environment -t$SESSION_NAME DJANGO_SETTINGS_MODULE $DJANGO_SETTINGS_MODULE
        tmux set-environment -t$SESSION_NAME DJANGO_DEVELOPMENT $DJANGO_DEVELOPMENT

        for i in $(seq 1 $NUM_WINDOWS); do
            tmux new-window -t$SESSION_NAME:$i
        done

        tmux select-window -t$SESSION_NAME:0
    else
        echo "usage: new_session <tmux session name>"
    fi
}
