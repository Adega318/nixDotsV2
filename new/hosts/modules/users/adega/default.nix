{ pkgs, config, ... }:
let
  ifTheyExist = groups: builtins.filter
    (
      group: builtins.hasAttr group config.users.groups
    )
    groups;
in
{
  users.users.adega = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = ifTheyExist [
      "audio"
      "docker"
      "git"
      "video"
      "wheel"
    ];

    packages = [ pkgs.home-manager ];
  };

  home-manager.users.adega = import ../../../../home/adega/${config.networking.hostName}.nix;
}
