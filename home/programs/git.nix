{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      pull.rebase = true;
      user = {
        name = "卢昭霁";
        email = "344803675+luzhaoji0@users.noreply.github.com";
      };
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };
}
