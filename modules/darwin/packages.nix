{ pkgs }:

with pkgs;
[
  # General packages for development and system management
	p7zip
  # mullvad-vpn
  aspell
  aspellDicts.en
  atuin
  bash-completion
  bat
  btop
  coreutils
  direnv
  docker
  docker-compose
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
  ngrok
  nmap
  openssh
  parallel
  podman
  rbw
  sqlite
  wget
  yq
  zip
  zstd

  # Language tools
  nixd
  nil # another nix language server
  nixfmt-rfc-style
  go
  gopls
  rustup
  nodejs_24
  bun
  vlc-bin
  spotify
  telegram-desktop
  vscode


  # Encryption and security tools
  age
  age-plugin-yubikey
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
  pinentry-tty


  # Text and terminal utilities
  htop
  hunspell
  iftop
  jetbrains-mono
  jq
  ripgrep
  tree
  unrar
  unzip
  zsh-powerlevel10k
  tree-sitter

  # Python packages
  python3
  virtualenv
  uv
]
