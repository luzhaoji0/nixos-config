{ ... }:

{
  programs.fish = {
    enable = true;
    shellAliases = {
      find = "fd";
      grep = "rg";
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    defaultCommand = "fd --type f --hidden --exclude .git";
    fileWidget.options = [ "--preview 'bat --color=always --line-range :200 {}'" ];
    changeDirWidget.command = "fd --type d --hidden --exclude .git";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
