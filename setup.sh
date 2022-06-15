#!/bin/bash

# Back up any existing config
if [ -f "/home/$USER/.vimrc" ]; then
	mv /home/$USER/.vimrc{,.bak}
fi

if [ -f "/home/$USER/.tmux.conf" ]; then
	mv /home/$USER/.tmux.conf{,.bak}
fi

if [ -f "/home/$USER/.config/i3/config" ]; then
	mv /home/$USER/.config/i3/config{,.bak}
else
	# Set up config directory for i3
	mkdir -p /home/$USER/.config/i3
fi

# Set up symlinks
ln -sv /home/$USER/dotfiles/.vimrc /home/$USER/.vimrc
ln -sv /home/$USER/dotfiles/.tmux.conf /home/$USER/.tmux.conf
ln -sv /home/$USER/dotfiles/i3config /home/$USER/.config/i3/config
