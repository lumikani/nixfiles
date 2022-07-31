{ config, pkgs, ... }:
let
  login = "lumi";
in
{
  systemd.user.services = let
    before-after-wanted = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    protonvpn-cli = "${pkgs.protonvpn-cli}/bin/protonvpn-cli";
    service-env = [
      "PVPN_WAIT=1000"
      "PVPN_DEBUG=1"
      "SUDO_USER=${login}"
    ];
    mkUnitSectionDisconnect = description: {
      Description = description;
      Before = before-after-wanted;
    };
    #mkUnitSectionReconnect = description: {
    #  Description = description;
    #  After = before-after-wanted;
    #};

    mkServiceSection = vpn-args: {
      Type = "forking";
      Environment = service-env;
      ExecStart = "${protonvpn-cli} ${vpn-args}";
    };

    installSection = {
      WantedBy = before-after-wanted;
    };
  in { 
    #protonvpn-disconnect = {
    #  Unit = mkUnitSectionDisconnect "protonvpn-cli disconnect before sleep";
    #  Service = mkServiceSection "d";
    #  Install = installSection;
    #};

    #protonvpn-reconnect = {
    #  Unit = mkUnitSectionReconnect "protonvpn-cli reconnect after sleep";
    #  Service = mkServiceSection "c --p2p";
    #  Install = installSection;
    #};
  };
}

