# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

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
      device = "/dev/nvme0n1p2";
      preLVM = true;
    };
  };

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "lumi" ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "pancake";

  system.stateVersion = "22.05"; # Did you read the comment?
}

