{ pkgs, ... }:
let
  settings = {
    hostName = "castiel";
    wallpaper = ../../wallpaper/a.png;
  };
in
{
  imports = [
    ./hardware-configuration.nix

    ../modules/core
    ../modules/users/adega
    ../modules/optional/boot.nix
    ../modules/optional/docker.nix
    ../modules/optional/greetd.nix
    ../modules/optional/networ.nix
    ../modules/optional/pipewire.nix
    ../modules/optional/stylix.nix
  ];

  networking.hostName = settings.hostName;

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod_latest;
    binfmt.emulatedSystems = [
      "aarch64-linux"
      "i686-linux"
    ];
  };

  powerManagement.powertop.enable = true;
  programs = {
    light.enable = true;
    adb.enable = true;
    dconf.enable = true;
  };

  # Lid settings
  services.logind = {
    lidSwitch = "suspend";
    lidSwitchExternalPower = "lock";
  };

  hardware.graphics.enable = true;

  system.stateVersion = "24.05";
}
