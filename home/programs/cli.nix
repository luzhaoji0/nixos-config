{ ... }:

{
  programs = {
    bat.enable = true;
    btop.enable = true;
    fd.enable = true;
    fastfetch.enable = true;
    gh.enable = true;
    jq.enable = true;
    lazygit.enable = true;

    ripgrep = {
      enable = true;
      arguments = [ "--smart-case" ];
    };

    tealdeer.enable = true;

    tmux = {
      enable = true;
      mouse = true;
      clock24 = true;
    };

    eza = {
      enable = true;
      enableFishIntegration = true;
      git = true;
      colors = "auto";
      extraOptions = [
        "--group-directories-first"
        "--classify=always"
      ];
    };
  };
}
