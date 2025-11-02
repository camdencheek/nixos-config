{ pkgs }:

with pkgs;
[
# General packages for development and system management
	p7zip
	aspell
	aspellDicts.en
	atuin
	bash-completion
	mitmproxy
	lnav
	dust
	bat
	btop
	coreutils
	pkg-config
	cmake
	mackup
	direnv
	docker
	localsend
	docker-compose
	duckdb
	dtrx
	eza
	fre
	fzf
	git
	git-open
	github-cli
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
	syncthing
	wget
	yq
	zip
	zstd

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
	noto-fonts-emoji
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
