#!/bin/sh
tmux new-session -d 'vim "+set number" lib/koans/*'
tmux split-window -v -p 50 'mix meditate'
tmux select-pane -t 0
tmux -2 attach-session -d
