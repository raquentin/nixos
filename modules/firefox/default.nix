{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;
    profiles.race = {
      search.engines = {
        "Nix Packages" = {
          urls = [
            {
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["@np"];
        };
        "Nix Options" = {
          urls = [
            {
              template = "https://search.nixos.org/options";
              params = [
                {
                  name = "type";
                  value = "options";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }
          ];

          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = ["@no"];
        };
      };
      search.force = true;

      bookmarks = [
        {
          name = "toolbar";
          toolbar = true;
          bookmarks = [
            {
              name = "uni";
              bookmarks = [
                {
                  name = "piazza";
                  url = "https://piazza.com/class/m5izre67uns1n5";
                }
                {
                  name = "gradescope";
                  url = "https://www.gradescope.com/";
                }
                {
                  name = "canvas";
                  url = "https://gatech.instructure.com/courses";
                }
                {
                  name = "basecamp";
                  url = "https://3.basecamp.com/4261899/buckets/13381934/questions/3077765370";
                }
                {
                  name = "notion";
                  url = "https://www.notion.so/Race-Williams-Notebook-bd6c2841dd1a46a4a20de38806b66ebc";
                }
              ];
            }
          ];
        }
      ];

      settings = {
        "dom.security.https_only_mode" = true;
        "browser.download.panel.shown" = true;
        "identity.fxaccounts.enabled" = false;
        "bookmarks.tabs.loadBookmarksInTabs" = true;
      };

      userChrome = ''
        /* some css */
      '';

      extensions = with inputs.firefox-addons.packages.${pkgs.system}; [
        proton-pass
        ublock-origin
        df-youtube
        darkreader
        vimium
      ];
    };
  };
}
