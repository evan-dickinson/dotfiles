## Evan's dot files

### Installation

Changing shell to zsh:
% chsh -s /bin/zsh

Create symlink
% cd ~
% ln -s ~/Apps/dotfiles/zprofile .zprofile

* Create a symlink from ~/.profile to profile


### Install for Emacs
% cd ~
% ln -s ~/Apps/dotfiles/emacs.d .emacs.d

### Update Mac app key bindings
Install Sketch (and any other apps that need bindings)

% ./setup-app-keybindings


### Install for Sublime Text

See the [notes for keeping items in sync](https://packagecontrol.io/docs/syncing). At startup of Sublime Text, Package Control will automatically install any missing packages.

First, install Sublime Text and [Package Control](https://packagecontrol.io/installation#st2). 

Are you behind a proxy? Set the [proxy settings](https://packagecontrol.io/docs/settings).

% ln -s ~/Apps/dotfiles/sublime-packages-user ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User
% ln -s ~/Apps/dotfiles/sublime-3-packages-user ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User