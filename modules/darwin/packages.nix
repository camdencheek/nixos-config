{ pkgs }:

let
  gdk = pkgs.google-cloud-sdk.withExtraComponents (
    with pkgs.google-cloud-sdk.components;
    [
      gke-gcloud-auth-plugin
      cloud-sql-proxy
    ]
  );
in
with pkgs;
[
  # General packages for development and system management
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
  mise
  # mullvad-vpn
  neovim
  ngrok
  nmap
  openssh
  parallel
  podman
  rbw
  sqlite
  tailscale
  wget
  yq
  zip
  zstd
  jjui
	p7zip

  # Language tools
  nixd
  nil # another nix language server
  nixfmt-rfc-style
  go
  gopls
  rustup
  nodejs_24
  bun
  firefox-devedition
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
