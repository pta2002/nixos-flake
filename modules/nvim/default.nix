{ pkgs, ... }:
{
  programs.nixvim = {
    enable = true;
    # For some reason this isn't working when defining it here
    # package = pkgs.neovim-nightly;

    colorschemes.gruvbox.enable = true;
    options = {
      number = true;                         # Show line numbers
      backup = false;                        # Don't create swap files
      mouse = "a";                           # Allow mouse usage
      completeopt = [ "menuone" "preview" ]; # Settings for autocomplete

      # Tab sizes
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smarttab = true;
      autoindent = true;
      cindent = true;

      wildmenu = true; # Autocomplete popup
      ignorecase = true; # Case-insensitive search
      hidden = true; # Switch buffers without saving

      foldlevel = 100; # Don't start with stuff collapsed!
    };

    globals.mapleader = " ";

    maps.normal = {
      # Convenient shift-less stuff
      "ç" = ":";
      "-" = "/";
    };

    maps.normalVisualOp = {
      # j and k move between visual lines
      "j" = "gj";
      "k" = "gk";
      "0" = "g0";
    };

    plugins = {
      lightline.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-table-mode
      tabular
      vim-markdown
      vim-ledger
      vim-commentary
      vim-surround
      vim-nix
      vim-toml
    ];
  };
}
