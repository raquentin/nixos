{
  pkgs,
  inputs,
  ...
}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    # redirect
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      # lsp
      lua-language-server # lua
      nil # nix
      gleam # gleam
      ocamlPackages.lsp # ocaml
      llvmPackages_19.clang-tools # c, cpp
      llvmPackages_19.libcxxClang # goto def cpp
      jdt-language-server # java
      tinymist # typst

      # fmt
      alejandra # nix
      black # python
      rustfmt # rust
      stylua # lua
      cmake-format #cmake

      # clipboard
      xclip
      wl-clipboard

      # c compiler
      zig
    ];

    plugins = with pkgs.vimPlugins; [
      # fzf
      telescope-nvim
      plenary-nvim

      # completion
      nvim-cmp
      cmp-buffer
      cmp-nvim-lsp
      cmp-path
      luasnip
      cmp_luasnip

      # lsp
      nvim-lspconfig

      # treesitter
      nvim-treesitter.withAllGrammars

      # fmt, lint
      conform-nvim
      nvim-lint
      guess-indent-nvim

      # which
      which-key-nvim

      # navigation
      neo-tree-nvim
      nvim-web-devicons
      harpoon

      # misc
      typst-preview-nvim
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./keymaps.lua}
      ${builtins.readFile ./options.lua}

      ${builtins.readFile ./plugins/colors.lua}
      ${builtins.readFile ./plugins/cmp.lua}
      ${builtins.readFile ./plugins/lsp.lua}
      ${builtins.readFile ./plugins/fmt.lua}
      ${builtins.readFile ./plugins/lint.lua}
      ${builtins.readFile ./plugins/treesitter.lua}
      ${builtins.readFile ./plugins/telescope.lua}
      ${builtins.readFile ./plugins/tree.lua}
      ${builtins.readFile ./plugins/which.lua}
      ${builtins.readFile ./plugins/harpoon.lua}
      ${builtins.readFile ./plugins/indent.lua}
    '';
  };
}
