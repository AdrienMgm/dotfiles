#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

function letsgo() {
	# Install brew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)";

	# Install brew apps
	sh brew.sh;

	# Install zsh
	brew install zsh;
	chsh -s $(which zsh);

	# Install ohmyzsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

	# Install powerlevel10k ohmyzsh theme
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k;

	# copy dotfiles
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "brew.sh" \
		--exclude "README.md" \
		-avh --no-perms . ~;

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
	echo "You may have to set the font manually in the terminal.";
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
