# NixOS Configuration Memory File

## Build Commands
- `nix flake check` - Verify flake integrity
- `nix build` - Build without applying
- `nix run .#build` - Build Darwin configuration
- `nix run .#build-switch` - Build and apply Darwin configuration
- `nix run .#apply` - Apply the existing build
- `nix run .#rollback` - Rollback to previous generation

## Code Style Guidelines
- Use 2-space indentation in Nix files
- Sort package lists alphabetically within their category
- Use explicit `with pkgs;` at top level of package lists
- Group related packages with comments indicating their purpose
- Prefer declarative package configuration over imperative setup
- Use camelCase for variable names
- When adding new options, follow the existing pattern in similar module files
- Use descriptive names for all inputs and outputs in functions