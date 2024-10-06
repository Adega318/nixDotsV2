{pkgs, inputs, ...}: let
  settings = {
    hostName = "castiel";
  };
in {
  imports = [
    ./hardware-configuration.nix

    ../modules/core
    ../modules/users/adega
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