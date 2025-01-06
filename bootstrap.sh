#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

function letsgo() {
	# Install brew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";

	# Set brew to the environment
	if ! command -v brew 2>&1 >/dev/null
	then 
		echo "Setting up brew to the .zprofile";
		echo >> $HOME/.zprofile;
		echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile;
		eval "$(/opt/homebrew/bin/brew shellenv)";
	fi

	# Install brew apps
	sh brew.sh;

	# Update zsh
	echo "";
	echo "Update zsh";
	brew install zsh;
	chsh -s $(which zsh);

	# Install ohmyzsh (macOS now ships with zsh by default)
	echo "";
	echo "Install OhMyZsh";
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)";

	# Install powerlevel10k ohmyzsh theme
	echo "";
	echo "Install powerlevel10k";
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k;

	# copy dotfiles
	echo "";
	echo "Update .dotfiles with rsync (verbose)";
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "brew.sh" \
		--exclude "macos.sh" \
		--exclude "README.md" \
		-avh --no-perms . ~;

	# Setup default config for macOS
	echo "";
	echo "Set default config for macOS";
	sh macos.sh;

	echo "";
	echo "bootstrap done!";
	echo "";
	echo "---------------";
	echo "Below are the apps that you may want to install manually:";
	echo "- Wireguard is not present on brew";
	echo "- Giphy is not present on brew";
	echo "---------------";
	echo "";
	echo "You may have to restart and set the font manually in the terminal.";
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	letsgo;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n)" -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		letsgo;
	fi;
fi;
unset letsgo;
