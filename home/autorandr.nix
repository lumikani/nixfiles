{ config, pkgs, ... }:
{
  programs.autorandr= {
    enable = true;

    profiles = let
      laptop-screen-edid = "00ffffffffffff004c834a350000000000190104a51d11780a28659759548e271e505400000001010101010101010101010101010101293680a070381f403020250025a5100000190000000f0000000000000000001e82105200000000fe0053414d53554e470a204c83484c000000fe004c544e313333484c3035393032002e";
      home-screen-edid = "00ffffffffffff0030aeee6542374c36301d0103803c22783a4455a9554d9d260f5054a1080081809500a9c0b300d1c001010101010164e7006aa0a067501520350055502100001a70c200a0a0a055503020350055502100001a000000fd0030901edf3c000a202020202020000000fc004c454e20593237712d32300a2001f3020344f14c61601f9014010304121305022309070783010000e200d567030c001000383c67d85dc401788007681a00000101309000e305c000e30f0300e606070161561c565e00a0a0a029503020350055502100001ea073006aa0a029500820350055502100001a70a000a0a0a046503020350055502100001e000000000073";
      home-tv-edid = "00ffffffffffff004c2d0270000e0001011e0103807944780aa833ab5045a5270d4848bdef80714f81c0810081809500a9c0b300d1c004740030f2705a80b0588a00501d7400001e565e00a0a0a0295030203500501d7400001a000000fd0018780f871e000a202020202020000000fc0053414d53554e470a202020202001e3020350f0545f101f041305142021225d5e6264071603123f402c09070715075057070067540083010000e2004fe30503016e030c003000b83c20008001020304e3060d01e50e60616566e5018b849001011d80d0721c1620102c2580501d7400009e023a801871382d40582c4500501d7400001e000000000000000000000020";

      audio-device = "alsa_card.pci-0000_00_1f.3";
      audio-output-analog = "output:analog-stereo";
      audio-output-hdmi = "output:hdmi-stereo";

      set-audio-card-profile = "pactl set-card-profile";
      switch-audio-to-analog = "${set-audio-card-profile} ${audio-device} ${audio-output-analog}";
    in {
      laptop = {
        fingerprint = {
          eDP1 = laptop-screen-edid;
        };

        config = {
          eDP-1 = {
            enable = true;
            crtc = 0;
            mode = "1920x1080";
            rate = "60.00";
            primary = true;

            position = "0x0";
          };
        };

        hooks.postswitch = switch-audio-to-analog;
      };

      home = {
        fingerprint = {
          eDP-1 = laptop-screen-edid;
          HDMI-1 = home-screen-edid;
        };

        config = {
          eDP-1 = {
            enable = true;
            crtc = 1;
            mode = "1920x1080";
            rate = "60.00";

            position = "0x131";
          };

          HDMI-1 = {
            enable = true;
            crtc = 0;
            mode = "2560x1440";
            rate = "74.97";
            primary = true;

            position = "1920x0";
          };
        };

        hooks.postswitch = switch-audio-to-analog;
      };

      living-room = {
        fingerprint = {
          eDP-1 = laptop-screen-edid;
          HDMI-1 = home-tv-edid;
        };

        config = {
          eDP-1 = {
            enable = true;
            crtc = 1;
            mode = "1920x1080";
            rate = "60.00";

            position = "0x0";
          };

          HDMI-1 = {
            enable = true;
            crtc = 0;
            mode = "1920x1080";
            rate = "120.00";
            primary = true;

            position = "0x0";
          };
        };

        hooks.postswitch = "${set-audio-card-profile} ${audio-device} ${audio-output-hdmi}";
      };
    };
  };
}

