{ lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = true;
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";

  users.users.yuki = {
    isNormalUser = true;
    description = "Yuki";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOlfm/2hTW84618dIX5y99IxgqQG6LtZ+JGTFIJjZNtb"
    ];
  };

  programs.fish.enable = true;
  programs.nix-ld.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      AuthenticationMethods = "publickey";
      PubkeyAuthentication = true;
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "codex" ];

  system.stateVersion = "26.05";
}
