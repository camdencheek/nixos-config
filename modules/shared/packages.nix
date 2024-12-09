{ pkgs }:

with pkgs; [
  # General packages for development and system management
  aspell
  aspellDicts.en
  bash-completion
  bat
  btop
  coreutils
  direnv
  eza
  fre
  fzf
  git
  killall
  neovim
  openssh
  sqlite
  wget
  zip
  parallel

  # Language tools
  nixd
  nil # another nix language server
  go
  gopls
  rustup

  # Encryption and security tools
  age
  age-plugin-yubikey
  gnupg
  libfido2
  nss.tools # includes certutil

  # Cloud-related tools and SDKs
  docker
  docker-compose

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

  # Node.js development tools
  nodePackages.npm # globally install npm
  nodePackages.prettier
  nodejs

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

  # Python packages
  python3
  virtualenv

  # Sourcegraph-specific utilities
  # TODO: split this out
  google-cloud-sdk
  asdf-vm
  findutils
  pcre
  bazelisk
  bazel-watcher
  p4
  postgresql
  redis
  caddy
  concurrently
]
