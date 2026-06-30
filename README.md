# macOS Nix Configuration

## Basic Commands

```bash
# Build configuration
nix build ".#darwinConfigurations.aarch64-darwin.system"

# Switch to new configuration
sudo darwin-rebuild switch --flake ".#aarch64-darwin"

# Enter development shell
nix develop
```

Work and personal-only packages are controlled by `tags` in `locals.nix`.
