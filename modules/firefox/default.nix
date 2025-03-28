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
            {
              name = "mail";
              bookmarks = [
                {
                  name = "tuta";
                  url = "https://app.tuta.com";
                }
                {
                  name = "purely";
                  url = "https://inbox.purelymail.com";
                }
                {
                  name = "gt";
                  url = "https://mail.gatech.edu";
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
        @-moz-document url(chrome://browser/content/browser.xhtml){

          :root:not([inFullscreen]){
            --uc-bottom-toolbar-height: calc(39px + var(--toolbarbutton-outer-padding) )
          }

          :root[uidensity="compact"]:not([inFullscreen]){
            --uc-bottom-toolbar-height: calc(32px + var(--toolbarbutton-outer-padding) )
          }

          #browser,
          #customization-container{ margin-bottom: var(--uc-bottom-toolbar-height,0px) }

          #nav-bar{
            position: fixed !important;
            bottom: 0px;
            /* For some reason -webkit-box behaves internally like -moz-box, but can be used with fixed position. display: flex would work too but it breaks extension menus. */
            display: -webkit-box;
            width: 100%;
            z-index: 1;
          }
          #nav-bar-customization-target{ -webkit-box-flex: 1; }

          :root[lwtheme] #nav-bar{
            background-image: linear-gradient(var(--toolbar-bgcolor),var(--toolbar-bgcolor)), var(--lwt-additional-images,var(--toolbar-bgimage)) !important;
            background-position: top,var(--lwt-background-alignment);
            background-repeat: repeat,var(--lwt-background-tiling);
          }
          :root[lwtheme-image] #nav-bar{
            background-image: linear-gradient(var(--toolbar-bgcolor),var(--toolbar-bgcolor)),var(--lwt-header-image), var(--lwt-additional-images,var(--toolbar-bgimage)) !important;
          }

          /* Fix panels sizing */
          .panel-viewstack{ max-height: unset !important; }

          #urlbar[breakout][breakout-extend]{
            display: flex !important;
            flex-direction: column-reverse;
            bottom: 0px !important; /* Change to 3-5 px if using compact_urlbar_megabar.css depending on toolbar density */
            top: auto !important;
          }

          .urlbarView-body-inner{ border-top-style: none !important; }

          @media (-moz-platform: linux){
            #notification-popup[side="top"]{
              margin-top: calc(-2 * var(--panel-padding-block) - 40px - 32px - 8.5em) !important;
            }
            #permission-popup[side="top"]{
              margin-top: calc(-2 * var(--panel-padding-block) - 2.5em);
            }
          }
        }
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
