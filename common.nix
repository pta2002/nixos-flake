{ pkgs, home-manager, nixvim, lib, ... }@args:
{
  # Localization stuff
  time.timeZone = "Europe/Lisbon";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "pt-latin1";

  # Shell
  programs.fish.enable = true;

  # User config!
  users.users.pta2002 = {
    isNormalUser = true;
    password = "";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "video" "audio" ];
  };

  home-manager.useUserPackages = true;
  home-manager.users.pta2002 = import ./home.nix args;

  # Documentation
  documentation.dev.enable = true;
  environment.systemPackages = [ pkgs.manpages ];
}
