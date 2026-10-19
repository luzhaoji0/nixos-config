{ pkgs, ... }:

{
  imports = [
    ./programs/cli.nix
    ./programs/git.nix
    ./programs/neovim.nix
    ./programs/shell.nix
  ];

  home = {
    username = "yuki";
    homeDirectory = "/home/yuki";
    stateVersion = "26.05";

    packages = with pkgs; [
      age
      codex
      ghostty.terminfo
      procs
      unzip
    ];
  };

  programs.home-manager.enable = true;
}
