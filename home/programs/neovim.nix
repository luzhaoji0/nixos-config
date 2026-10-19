{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    nixpkgs.pkgs = pkgs;

    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      signcolumn = "yes";
      cursorline = true;
      termguicolors = true;
      mouse = "a";
      undofile = true;
      ignorecase = true;
      smartcase = true;
      splitright = true;
      splitbelow = true;
      scrolloff = 8;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      updatetime = 250;
      wrap = false;
    };

    extraPackages = with pkgs; [
      cargo
      clippy
      fd
      fzf
      nixd
      nixfmt
      pyrefly
      ripgrep
      ruff
      rust-analyzer
      rustc
      rustfmt
    ];

    env.RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
    };

    plugins = {
      blink-cmp.enable = true;
      gitsigns.enable = true;
      lualine.enable = true;
      lspconfig.enable = true;
      oil.enable = true;
      web-devicons.enable = true;

      fzf-lua = {
        enable = true;
        keymaps = {
          "<leader>ff" = "files";
          "<leader>fg" = "live_grep";
        };
      };

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          bash
          json
          lua
          markdown
          markdown_inline
          nix
          python
          rust
          toml
          vim
          vimdoc
          yaml
        ];
      };

      rustaceanvim = {
        enable = true;
        settings.server.default_settings.rust-analyzer.check.command = "clippy";
      };

      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lsp_format = "fallback";
            timeout_ms = 500;
          };
          formatters_by_ft = {
            nix = [ "nixfmt" ];
            python = [ "ruff_organize_imports" "ruff_format" ];
            rust = [ "rustfmt" ];
          };
        };
      };
    };

    lsp.servers = {
      nixd.enable = true;
      pyrefly.enable = true;
      ruff.enable = true;
    };

    keymaps = [
      { mode = "n"; key = "<leader>e"; action = "<cmd>Oil<CR>"; options.desc = "File explorer"; }
      { mode = "n"; key = "gd"; action = "<cmd>lua vim.lsp.buf.definition()<CR>"; options.desc = "Go to definition"; }
      { mode = "n"; key = "gr"; action = "<cmd>lua vim.lsp.buf.references()<CR>"; options.desc = "References"; }
      { mode = "n"; key = "K"; action = "<cmd>lua vim.lsp.buf.hover()<CR>"; options.desc = "Hover"; }
      { mode = "n"; key = "<leader>ca"; action = "<cmd>lua vim.lsp.buf.code_action()<CR>"; options.desc = "Code action"; }
      { mode = "n"; key = "<leader>rn"; action = "<cmd>lua vim.lsp.buf.rename()<CR>"; options.desc = "Rename"; }
      { mode = "n"; key = "<leader>d"; action = "<cmd>lua vim.diagnostic.open_float()<CR>"; options.desc = "Line diagnostics"; }
    ];
  };
}
