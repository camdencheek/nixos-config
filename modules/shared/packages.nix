{ pkgs }:

with pkgs; [
  # General packages for development and system management
  aspell
  aspellDicts.en
  bash-completion
  bat
  btop
  coreutils
  killall
  neovim
  openssh
  sqlite
  wget
  zip

  # Language tools
  nixd
  nil

  # Encryption and security tools
  age
  age-plugin-yubikey
  gnupg
  libfido2

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
]
