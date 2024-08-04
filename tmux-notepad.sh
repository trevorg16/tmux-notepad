#!/usr/bin/env sh

TMUX_NOTE_DIR=/tmp/tmux-notepad

TMUX_PID=$(tmux display -p '#{pid}')

if [ $? -ne 0 ]
then
    echo "Failed to get tmux pid"
    read res # Leave on screen so the user can see the error
    exit 1
fi

TMUX_SESID=$(tmux display -p '#{session_id}' | sed 's/^\$//g')

if [ $? -ne 0 ]
then
    echo "Failed to get tmux session_id"
    read res # Leave on screen so the user can see the error
    exit 1
fi

DESTINATION_DIR="$TMUX_NOTE_DIR/$TMUX_PID/session_$TMUX_SESID"

if ! [ -d "$DESTINATION_DIR" ]
then
    mkdir -p "$DESTINATION_DIR"

    if [ $? -ne 0 ]
    then
        echo "Failed to create directory $DESTINATION_DIR"
        read res # Leave on screen so the user can see the error
        exit 1
    fi
fi

if [ -z "$EDITOR" ]
then
    echo '$EDITOR is unset. Set $EDITOR and restart tmux.'
    read res # Leave on screen so the user can see the error
    exit 1
fi

TMUX_WINDID=$(tmux display -p '#{window_id}' | sed 's/^@//g')

if [ $? -ne 0 ]
then
    echo "Failed to get tmux window_id"
    read res # Leave on screen so the user can see the error
    exit 1
fi

NOTEFILE="$DESTINATION_DIR/window_$TMUX_WINDID"

if ! touch "$NOTEFILE"
then
    echo "Failed to touch (create) file $NOTEFILE"
    read res # Leave on screen so the user can see the error
    exit 1
fi

$EDITOR $NOTEFILE
