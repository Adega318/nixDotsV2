{ inputs, outputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./gamemode.nix
    ./locale.nix
    ./nix-ld.nix
    ./nix.nix
    ./upower.nix
    ./zsh.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  home-manager = {
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs outputs;
    };
  };

  nixpkgs.config.allowUnfree = true;
}
