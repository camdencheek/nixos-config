{ pkgs }:

with pkgs;
[
# General packages for development and system management
	p7zip
	aspell
	aspellDicts.en
	wireguard-tools
	bash-completion
	mitmproxy
	lnav
	dust
	delta
	bat
	btop
	coreutils
	pkg-config
	cmake
	mackup
	direnv
	bruno
	docker
	localsend
	docker-compose
	discord
	duckdb
	dtrx
	eza
	fre
	fzf
	git
	git-open
	github-cli
	ghostty-bin
	ghostty-bin.terminfo
	graphviz
	jjui
	jujutsu
	killall
	luarocks
	luajit
	mise
	neovim
	openssh
	parallel
	podman
	sqlite
	wget
	yq-go
	zip
	zstd

# GUI applications
	firefox-devedition
	google-chrome
	raycast
	slack
	spotify
	stats
	telegram-desktop
	whatsapp-for-mac

# Language tools
	vlc-bin
	vscode

# Encryption and security tools
	gnupg
	libfido2
	nss.tools # includes certutil

# Media-related packages
	dejavu_fonts
	ffmpeg
	fd
	font-awesome
	hack-font
	noto-fonts
	noto-fonts-color-emoji
	intel-one-mono
	meslo-lgs-nf

# Text and terminal utilities
	htop
	iftop
	jetbrains-mono
	jq
	ripgrep
	tree
	unrar
	unzip
	zsh-powerlevel10k
	tree-sitter
	]
