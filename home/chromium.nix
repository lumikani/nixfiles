{ lib, hostUse, ... }:
{
  programs.chromium = lib.mkIf (hostUse == "work") {
    enable = true;

    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
      { id = "gcbommkclmclpchllfjekcdonpmejbdp"; } # https everywhere
      { id = "aeblfdkhhhdcdjpifhhbdiojplfjncoa"; } # 1password
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      { id = "fihnjjcciajhdojfnbdddfaoknhalnja"; } # I don't care about cookies
      { id = "fmkadmapgofadopljbjfkapdkoienihi"; } # react devtools
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
      { id = "bcjindcccaagfpapjjmafapmmgkkhgoa"; } # json formatter
    ];
  };
}
