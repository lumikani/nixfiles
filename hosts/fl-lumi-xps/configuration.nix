# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../common.nix
      ../../software.nix
    ];

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/nvme0n1p2";
      preLVM = true;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = lib.mkDefault [ "acpi_rev_override" ];

  environment.variables = {
    VPAU_DRIVER = "va_gl";
    LIBVA_DRIVER_NAME = "iHD";
  };

  services.thermald.enable = lib.mkDefault true;

  networking.hostName = "fl-lumi-xps"; # Define your hostname.
  hardware.video.hidpi.enable = true;
  hardware.opengl = { 
    driSupport = true;
    driSupport32Bit = true;

    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  environment.systemPackages = with pkgs; [
    libva-utils
    intel-gpu-tools
  ];

  system.stateVersion = "22.05"; # Did you read the comment?
}

