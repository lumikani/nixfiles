{ config, pkgs, ...}:
{
  imports =
    [
      ./hardware-configuration.nix
      ../../common.nix
      ../../software.nix
    ];

  # NixOS needs to be aware that we have a LUKS encrypted partition that needs to
  # be decrypted before accessing LVM partitions.
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/sda2";
      preLVM = true;
    };
  };

  networking.hostName = "muffin"; # Define your hostname.

  system.stateVersion = "21.11";                            
}

