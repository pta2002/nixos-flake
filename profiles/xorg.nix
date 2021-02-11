{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.profiles.graphical;
in
{
  options.profiles.graphical = {
    enable = mkEnableOption "Enable the GUI profile";
  };


  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      (import ../overlays/awesome.nix)
      (import ../overlays/picom.nix)
    ];

    services.xserver = {
      enable = true;
      # TODO make this configurable!
      layout = "pt";

      displayManager.lightdm.enable = true;
      windowManager.awesome.enable = true;
      windowManager.awesome.package = pkgs.awesome-nightly;
    };

    # Have stow to manage dotfiles
    environment.systemPackages = with pkgs; [
      stow
      playerctl
      maim
      networkmanager
      gobjectIntrospection
      rofi
      picom-ibhagwan
      xclip
    ];

    sound.enable = true;
    hardware.pulseaudio.enable = true;
  };
}
