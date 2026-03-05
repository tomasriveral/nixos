# adapted from https://github.com/contre95/dotfiles/blob/main/dotfiles/nixos/programs/librewolf.nix
{ pkgs, config, ... }:
{
  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = 1;
    MOZ_USE_XINPUT2 = 1;
    MOZ_DBUS_REMOTE = 1;
  };
  programs.librewolf = {
    enable = true;
    settings = {
        "browser.profiles.enabled" = true;
        # disabled until i find something that uses it.
        "webgl.disabled" = true;
        # settings = lib.mapAttrs' (n: lib.nameValuePair "pref.${n}") {
        "app.update.auto" = true; # disable auto update
        #"dom.security.https_only_mode" = true; # force https
        "extensions.pocket.enabled" = false; # disable pocket
        #"browser.quitShortcut.disabled" = true; # disable ctrl+q
        "browser.download.panel.shown" = true; # show download panel
        "signon.rememberSignons" = false; # disable saving passwords
        "identity.fxaccounts.enabled" = false; # disable librewolf accounts
        "app.shield.optoutstudies.enabled" = false; # disable shield studies
        "browser.shell.checkDefaultBrowser" = false; # don't check if default browser
        #"browser.bookmarks.restore_default_bookmarks" = false; # don't restore default bookmarks
        # Download handling
        #"browser.download.dir" = "/home/meain/down"; # default download dir
        "browser.startup.page" = 3; # restore previous session
        # UI changes
        # "browser.uidensity" = 1; # enable dense UI
        #"general.autoScroll" = true; # enable autoscroll
        # "browser.compactmode.show" = true; # enable compact mode
        # "browser.tabs.firefox-view" = false; # enable librewolf view
        #"startup.homepage_welcome_url" =
        #  "https://metrics.internal.contre.io/d/cUITC74Vksd/podman-revamped?orgId=1&from=2026-02-23T19:29:26.304Z&to=2026-02-23T19:59:26.304Z&timezone=browser&var-Filters=&var-namespace=alloy&var-level=error&var-level=debug&var-level=info&var-level=warn&refresh=5s&kiosk=true"; # disable welcome page
        "browser.newtabpage.enabled" = true; # disable new tab page
        "full-screen-api.ignore-widgets" = true; # fullscreen within window
        "browser.toolbars.bookmarks.visibility" = "always"; # hide bookmarks toolbar
        "browser.aboutConfig.showWarning" = false; # disable warning about about:config
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false; # disable picture in picture button

        # Privacy
        "privacy.resistFingerprinting" = true;
        # "privacy.clearOnShutdown.cache" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearHistory.cookiesAndStorage" = false;
        "privacy.clearHistory.historyFormDataAndDownloads" = false;
        "privacy.clearHistory.cache" = false;
        "privacy.clearOnShutdown_v2.siteSettings" = false;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
        "services.sync.prefs.sync.privacy.clearOnShutdown_v2.history" = false;
        "services.sync.prefs.sync.privacy.clearOnShutdown_v2.siteSettings" = false;
        "services.sync.prefs.sync.privacy.clearOnShutdown_v2.sessions" = false;
        "services.sync.prefs.sync.privacy.clearOnShutdown_v2.cookies" = false;
        "services.sync.prefs.sync.privacy.clearOnShutdown.history" = false;
        "services.sync.prefs.sync.privacy.clearOnShutdown.siteSettings" = false;
        "services.sync.prefs.sync.privacy.clearOnShutdown.sessions" = false;
        "services.sync.prefs.sync.privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "browser.discovery.enabled" = false; # disable discovery
        "browser.search.suggest.enabled" = true; # disable search suggestions
        "browser.contentblocking.category" = "custom"; # set tracking protection to custom
        "dom.private-attribution.submission.enabled" = false; # stop doing dumb stuff mozilla
        "browser.protections_panel.infoMessage.seen" = true; # disable tracking protection info

        # Theme
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "layout.css.color-mix.enabled" = true;

        # Disable telemetry
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "browser.ping-centre.telemetry" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "browser.translations.automaticallyPopup" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;

        "browser.tabs.loadInBackground" = true; # open new tab in background
        "browser.tabs.loadBookmarksInTabs" = true; # open bookmarks in new tab
        "browser.tabs.warnOnOpen" = false; # don't warn when opening multiple tabs
        "browser.tabs.warnOnQuit" = false; # don't warn when closing multiple tabs
        "browser.tabs.warnOnClose" = false; # don't warn when closing multiple tabs
        "browser.tabs.loadDivertedInBackground" = false; # open new tab in background
        "browser.tabs.warnOnCloseOtherTabs" = false; # don't warn when closing multiple tabs
        "browser.tabs.closeWindowWithLastTab" = false; # don't close window when last tab is closed

        # other
        "media.autoplay.default" = 0; # enable autoplay on open
        "devtools.toolbox.host" = "right"; # move devtools to right
        "devtools.theme" = "dark";
        # "browser.ssb.enabled" = true; # enable site specific browser
        "media.rdd-vpx.enabled" = true; # enable hardware acceleration
        "devtools.cache.disabled" = true; # disable caching in devtools
        "media.ffmpeg.vaapi.enabled" = true; # enable hardware acceleration

        # Fonts
        "font.size.fixed.x-western" = 15;
        "font.minimum-size.x-western" = 13;
        "font.size.variable.x-western" = 15;
        "font.size.monospace.x-western" = 15;
        "browser.display.use_document_fonts" = 1;
        "browser.link.open_newwindow.restriction" = 0;
        #
        # "browser.fixup.domainsuffixwhitelist.home" = true;
        # "browser.fixup.domainwhitelist.internal.contre.io" = true;
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org";
        # "keyword.enable" = false; # Disable search when typing unexistent TLD

    };
    policies = {
      ExtensionSettings = {
        # the extension id should be from the manifesto and not a random name.
        # if you dont know it. Put a random name. It will fail. Go to about:polices#error and the error will give you the correct id. 
        "enhancerforyoutube@maximerf.addons.mozilla.org" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/enhancer-for-youtube/latest.xpi";
        };

        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
        };

        "adnauseam@rednoise.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/adnauseam/latest.xpi";
          installation_mode = "force_installed";
        };
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "blocked";
        };
        "{08d5243b-4236-4a27-984b-1ded22ce01c3}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/3729287/gruvboxgruvboxgruvboxgruvboxgr-1.0.xpi";
          installation_mode = "force_installed";
        };
        "trackmenot@mrl.nyu.edu" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/trackmenot/latest.xpi";
          installation_mode = "force_installed";
        };
      };
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      DisablePocket = true;
      DisableAccounts = true;
      DisableFirefoxScreenshots = true;
      # OverrideFirstRunPage = "";
      # OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "always"; # alternatives: "always" or "newtab"
      DisplayMenuBar = "never"; # alternatives: "always", "never" or "default-on"
      SearchBar = "unified"; # alternative: "separate"
    };
    profiles.work = {
      id = 0;
      # userChrome = builtins.readFile ./userChrome.css;
      # userContent = builtins.readFile ./userChrome.css;
      extensions = {
        force = true;
        settings = {
          "adnauseam@rednoise.org".settings = {
            # Core behavior
            filteringEnabled = true;
        
            hidingAds = true;
            blockingMalware = true;
            clickingAds = true;
        
            # Privacy
            disableClickingForDNT = true;
            blockSocialMediaWidgets = false;
        
            # Filter lists
            selectedFilterLists = [
              "adnauseam-filters"
              "easylist"
              "easyprivacy"
              "ublock-badware"
              "ublock-privacy"
              "ublock-unbreak"
            ];
        
            # Advanced
            advancedUserEnabled = false;
            dynamicFilteringEnabled = false;
        
            # UI
            showIconBadge = true;
            parseTextAds = true;
            eventLogging = false;
          };
            "trackmenot@mrl.nyu.edu".settings = {
              enabled = true;

              # Query behavior
              runAtStartup = true;
              useTab = false;               # don't open visible tab
              showQueries = false;          # don't display fake queries

              # Frequency (seconds between bursts)
              timeout = 600;                # 10 minutes
              burstEnabled = true;
              burstTimeout = 20;           # burst interval
              burstCount = 5;

              # Query source
              useRssFeeds = true;           # use dynamic trending feeds
              useUserQueries = false;       # don't mix your real queries
              useBlackList = true;

              # Search engines to generate noise for
              searchEngines = {
                google = true;
                bing = false;
                yahoo = false;
                baidu = false;
                duckduckgo = false;
              };

              # Logging
              enableLogging = false;
            };
              "sponsorBlocker@ajay.app".settings = {

                # Core behavior
                isEnabled = true;
                autoSkip = false;
                showSkipNotice = true;
                # this does not work
                # Segment categories (auto-skip behavior)
                categoryChooser = {
                  Sponsor = {
                    enabled = true;
                    skipOption = "manualSkip";
                  };
                  intro = {
                    enabled = true;
                    actionType = 2;
                  };
                  outro = {
                    enabled = true;
                    actionType = 2;
                  };
                  selfpromo = {
                    enabled = true;
                    actionType = 2;
                  };
                  interaction = {
                    enabled = true;
                    actionType = 1; # 1 = manual skip
                  };
                  music_offtopic = {
                    enabled = false;
                    actionType = 0;
                  };
                  preview = {
                    enabled = false;
                    actionType = 0;
                  };
                };

                # Privacy
                disableTelemetry = true;
                showDonationLink = false;

                # UX
                showUpsells = false;
                hideSkipButtonPlayerControls = false;

                # Advanced
                useLocalCache = true;
                trackViewCount = false;
          };
        };
      };
      search = {
        force = true;
        default = "quant";
        privateDefault = "qant";
        order = [
          "q"
          "map"
          "np"
          "nw"
          "bookmarks"
          "tabs"
          "history"
        ];
        engines = {
          # don't need these default ones
          "amazondotcom-es".metaData.hidden = true;
          "bing".metaData.hidden = true;
          "ebay".metaData.hidden = true;
          "metager".metaData.hidden = true; # dont work
          "mojeek".metaData.hidden = true; # dont work
          "seerx".metaData.hidden = true;
          "perplexity".metaData.hidden = true;
          "google".metaData.hidden = true;
          "startpage".metaData.hidden = true;
          "duckduckgo".metaData.hidden = true;
          "quant" = {
            urls = [
              {
                template = "https://www.qwant.com/";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "q" ];
          };
          "OpenStreeetMap" = {
            urls = [
              {
                template = "https://www.openstreetmap";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "map" ];
          };
          "Home Manager Options" = {
            urls = [
              {
                template = "https://home-manager-options.extranix.com/";
                params = [
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "hm" ];
          };
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
            definedAliases = [ "np" ];
          };
          "Nix Wiki" = {
            urls = [
              {
                template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
              }
            ];
            definedAliases = [ "nw" ];
          };
          "Repology" = {
            urls = [
              {
                template = "https://repology.org/projects/?search={searchTerms}";
              }
            ];
            definedAliases = [ "rp" ];
          };
        };
      };
    };
    profiles.other = {
      id = 1;
      # userChrome = builtins.readFile ./userChrome.css;
      # userContent = builtins.readFile ./userChrome.css;
      extensions = {
        force = true;
        settings = {
          "adnauseam@rednoise.org".settings = {
            # Core behavior
            filteringEnabled = true;
        
            hidingAds = true;
            blockingMalware = true;
            clickingAds = true;
        
            # Privacy
            disableClickingForDNT = true;
            blockSocialMediaWidgets = false;
        
            # Filter lists
            selectedFilterLists = [
              "adnauseam-filters"
              "easylist"
              "easyprivacy"
              "ublock-badware"
              "ublock-privacy"
              "ublock-unbreak"
            ];
        
            # Advanced
            advancedUserEnabled = false;
            dynamicFilteringEnabled = false;
        
            # UI
            showIconBadge = true;
            parseTextAds = true;
            eventLogging = false;
          };
            "trackmenot@mrl.nyu.edu".settings = {
              enabled = true;

              # Query behavior
              runAtStartup = true;
              useTab = false;               # don't open visible tab
              showQueries = false;          # don't display fake queries

              # Frequency (seconds between bursts)
              timeout = 600;                # 10 minutes
              burstEnabled = true;
              burstTimeout = 20;           # burst interval
              burstCount = 5;

              # Query source
              useRssFeeds = true;           # use dynamic trending feeds
              useUserQueries = false;       # don't mix your real queries
              useBlackList = true;

              # Search engines to generate noise for
              searchEngines = {
                google = true;
                bing = false;
                yahoo = false;
                baidu = false;
                duckduckgo = false;
              };

              # Logging
              enableLogging = false;
            };
              "sponsorBlocker@ajay.app".settings = {

                # Core behavior
                isEnabled = true;
                autoSkip = false;
                showSkipNotice = true;
                # this does not work
                # Segment categories (auto-skip behavior)
                categoryChooser = {
                  Sponsor = {
                    enabled = true;
                    skipOption = "manualSkip";
                  };
                  intro = {
                    enabled = true;
                    actionType = 2;
                  };
                  outro = {
                    enabled = true;
                    actionType = 2;
                  };
                  selfpromo = {
                    enabled = true;
                    actionType = 2;
                  };
                  interaction = {
                    enabled = true;
                    actionType = 1; # 1 = manual skip
                  };
                  music_offtopic = {
                    enabled = false;
                    actionType = 0;
                  };
                  preview = {
                    enabled = false;
                    actionType = 0;
                  };
                };

                # Privacy
                disableTelemetry = true;
                showDonationLink = false;

                # UX
                showUpsells = false;
                hideSkipButtonPlayerControls = false;

                # Advanced
                useLocalCache = true;
                trackViewCount = false;
          };
        };
      };
      search = {
        force = true;
        default = "quant";
        privateDefault = "qant";
        order = [
          "q"
          "map"
          "np"
          "nw"
          "bookmarks"
          "tabs"
          "history"
        ];
        engines = {
          # don't need these default ones
          "amazondotcom-es".metaData.hidden = true;
          "bing".metaData.hidden = true;
          "ebay".metaData.hidden = true;
          "metager".metaData.hidden = true; # dont work
          "mojeek".metaData.hidden = true; # dont work
          "seerx".metaData.hidden = true;
          "perplexity".metaData.hidden = true;
          "google".metaData.hidden = true;
          "startpage".metaData.hidden = true;
          "duckduckgo".metaData.hidden = true;
          "quant" = {
            urls = [
              {
                template = "https://www.qwant.com/";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "q" ];
          };
          "OpenStreeetMap" = {
            urls = [
              {
                template = "https://www.openstreetmap";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            definedAliases = [ "map" ];
          };
          "Onche.org" = {
            urls = [
              {
              template = "https://onche.org/forum/1/blabla-general/search?by=topic&q={searchTerms}";
              }
            ];
            definedAliases = [ "on" ];
          };
        };
      };
      
    };

  };
}
