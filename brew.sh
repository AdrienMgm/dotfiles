#!/usr/bin/env bash

# Install command-line tools & apps using Homebrew.
# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

brew install wget
# Install GnuPG to enable PGP-signing commits.
brew install gnupg

# Install more recent versions of some macOS tools.
brew install vim
brew install grep
brew install openssh

# Install nerd font.
brew install --cask font-hack-nerd-font

brew install gcc
brew install cmake
brew install nmap
brew install git
brew install git-lfs
brew install imagemagick
brew install lua
brew install ffmpeg
brew install lame

# Apps
brew install --cask mitmproxy
brew install --cask bitwarden
brew install --cask discord
brew install --cask vlc
brew install --cask visual-studio-code
brew install --cask firefox
brew install --cask opera
brew install --cask zoom
brew install --cask unity-hub
brew install --cask blender

# Remove outdated versions from the cellar.
brew cleanup