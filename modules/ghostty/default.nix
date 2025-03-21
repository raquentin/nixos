{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      theme = "grayscale";
      font-family = "JetBrains Mono";
      font-size = 20;
      shell-integration-features = "no-cursor";
      cursor-style-blink = false;
      window-padding-x = 6;
      window-padding-y = 6;
      window-decoration = "none";
    };

    themes = {
      grayscale = {
        background = "#000000";
        cursor-color = "#b1b1b1";
        foreground = "#ffffff";
        palette = [
          "0=#000000"
          "1=#ffffff"
          "2=#ffffff"
          "3=#e6e6e6"
          "4=#ffffff"
          "5=#ffffff"
          "6=#ffffff"
          "7=#a0a0a0"
          "8=#7e7e7e"
          "9=#ffffff"
          "10=#ffffff"
          "11=#ffffff"
          "12=#ffffff"
          "13=#ffffff"
          "14=#f5f5f5"
          "15=#ffffff"
        ];
        selection-background = "#989898";
        selection-foreground = "#b1b1b1";
      };
    };
  };
}
