{ pkgs, home-manager, nixvim, ... }:
{
  # Localization stuff
  time.timeZone = "Europe/Lisbon";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "pt-latin1";

  # Graphical stuff
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.awesome.enable = true;
    layout = "pt";
  };

  # Sound stuff
  sound.enable = true;
  hardware.pulseaudio.enable = true;

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
  home-manager.users.pta2002 = import ./home.nix { inherit pkgs; } // {
    imports = [ nixvim.homeManagerModules.nixvim ];
  };

  # Documentation
  documentation.dev.enable = true;
  environment.systemPackages = [ pkgs.manpages ];
}
