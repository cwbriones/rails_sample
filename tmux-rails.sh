#!/bin/bash

######################################################
# 
# This script creates a new tmux session named after
# the project folder it is located in and creates
# a few windows:
#
#    1. Normal Shell
#    2. Rails Console 
#    3. Rails Server
#    4. Vim
#
# The session is automatically stopped upon exiting.
#
######################################################

# Variables
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASE=${DIR##*/}

# Create a new session with the name of the project
tmux new-session -d -s "$BASE" -n terminal
tmux send-keys -t "$BASE" "cd $DIR && clear" 'C-m'
# Create a window with the rails console
tmux new-window -t "$BASE" -c "$DIR" -n console
tmux send-keys 'bundle exec rails console' 'C-m'
# Create a window with the rails server
tmux new-window -t "$BASE" -c "$DIR" -n server
tmux send-keys 'bundle exec rails s' 'C-m'
# Create a window with vim
tmux new-window -t "$BASE" -c "$DIR" -n vim
tmux send-keys 'vim' 'C-m'
# Attach to the created session
tmux attach-session -t "$BASE"
tmux kill-session -t "$BASE"
