{ pkgs, nixvim, laptop, lib, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "pta2002";
  home.homeDirectory = "/home/pta2002";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";

  home.sessionVariables.EDITOR = "nvim";

  programs.nixvim.package = pkgs.neovim-nightly;

  imports = [
    nixvim.homeManagerModules.nixvim
    ./modules/nvim

    ./modules/git.nix
    ./modules/fish.nix
    ./modules/kitty.nix
    ./modules/starship.nix
  ];

  home.packages = with pkgs; [
    # Development
    ninja ripgrep gcc gdb gnumake

    # Utils
    hledger hledger-web htop unzip libqalculate

    # Work
    pandoc zoom-us libreoffice

    # Entertainment
    spotify vlc
  ] ++ (lib.optionals laptop [
    brightnessctl
    acpid
    acpi
  ]);

  # imports = [
  #   ./modules/awesome.nix
  #   ./modules/theme.nix
  #   ./modules/zathura.nix

  #   ./user.nix
  #   ./machines/mercury.nix
  # ];
}
