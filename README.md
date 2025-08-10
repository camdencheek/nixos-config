# NixOS Configuration

## Basic Commands

```bash
# Build configuration
nix build ".#darwinConfigurations.aarch64-darwin.system"

# Switch to new configuration  
sudo darwin-rebuild switch --flake ".#aarch64-darwin"

# Build and switch for Sourcegraph config
sudo darwin-rebuild switch --flake ".#darwinSourcegraphConfigurations.aarch64-darwin"

# Enter development shell
nix develop
```
