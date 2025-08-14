# Agent Instructions for NixOS Config

## Testing Changes

After making any changes to the configuration files, you MUST:

1. Build the configuration: `nix build ".#darwinConfigurations.aarch64-darwin.system"`
2. Apply the changes: `sudo darwin-rebuild switch --flake ".#aarch64-darwin"`

This ensures all changes work correctly and the system is properly updated.

## Commands

- **Regular config**: `sudo darwin-rebuild switch --flake ".#aarch64-darwin"`
- **Sourcegraph config**: `sudo darwin-rebuild switch --flake ".#darwinSourcegraphConfigurations.aarch64-darwin"`
- **Development shell**: `nix develop`
