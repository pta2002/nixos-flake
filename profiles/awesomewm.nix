{ config, lib, ... }:
{
  options.profiles.awesomewm = {
    enable = mkEnableOption "Enable my awesomewm setup";
  };
}
