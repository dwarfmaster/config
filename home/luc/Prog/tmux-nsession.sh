#!/usr/bin/bash
# Attach to a session without viewing the same window in tmux

trim() { echo $1; }

if [[ -z "$1" ]]; then
    echo "Specify session name as the first argument"
    exit
fi

base_session="$1"
tmux_nb=$(trim `tmux ls | grep "^$base_session" | wc -l`)
if [[ "$tmux_nb" == "0" ]]; then
    echo "Launching tmux base session $base_session ..."
    tmux new-session -s $base_session
else
    # Make sure we are not already in a tmux session
    if [[ -z "$TMUX" ]]; then
        # Kill defunct sessions first
        old_sessions=$(tmux ls 2>/dev/null | egrep "^[0-9]{14}.*[0-9}+\)$" | cut -f 1 -d:)
        for old_sessions_id in $old_sessions; do
            tmux kill-session -t $old_sessions_id
        done

        echo "Launching copy of base session $base_session ..."
        # Session is dare and time to prevent conflict
        session_id=`date +%Y%m%d%H%M%S`
        session_id="$base_session-$session_id"
        # Create a new session and link to base session
        tmux new-session -d -t $base_session -s $session_id
        # Create a new window in that session
        tmux new-window
        # Attach to the new sessions
        tmux attach-session -t $session_id
        # kill the session when we detach from it
        tmux kill-session -t $session_id
    fi
fi

