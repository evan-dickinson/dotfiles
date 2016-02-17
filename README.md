## Evan's dot files

### Installation

Changing shell to zsh:
% chsh -s /bin/zsh

Create symlink
% cd ~
% ln -s ~/Apps/dotfiles/zprofile .zprofile


* Create a symlink from ~/.profile to profile
* TODO: Create other symlinks, too, if I ever start using emacs again
 
### Install for Sublime Text

See the [notes for keeping items in sync](https://packagecontrol.io/docs/syncing). At startup of Sublime Text,
Package Control will automatically install any missing packages.

First, install Sublime Text and [Package Control](https://packagecontrol.io/installation#st2)

% ln -s ~/Apps/dotfiles/sublime-packages-user ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/User
% ln -s ~/Apps/dotfiles/sublime-3-packages-user ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User

