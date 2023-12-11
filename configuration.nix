# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Nix Settings
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."luks-65d3eb80-568e-40af-9b60-65a54b2ad792".device = "/dev/disk/by-uuid/65d3eb80-568e-40af-9b60-65a54b2ad792";
  networking.hostName = "personal-laptop"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  # Recommend using nmtui to configure.
  networking.networkmanager = {
    enable = true;
    wifi.macAddress = "random";
  };

  # Enable docker daemon
  virtualisation.docker.enable = true;

  # Set your time zone.
  time.timeZone = "America/Argentina/Buenos_Aires";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_AR.UTF-8";
    LC_IDENTIFICATION = "es_AR.UTF-8";
    LC_MEASUREMENT = "es_AR.UTF-8";
    LC_MONETARY = "es_AR.UTF-8";
    LC_NAME = "es_AR.UTF-8";
    LC_NUMERIC = "es_AR.UTF-8";
    LC_PAPER = "es_AR.UTF-8";
    LC_TELEPHONE = "es_AR.UTF-8";
    LC_TIME = "es_AR.UTF-8";
  };

  # X11 / Wayland windowing settings
  #services.xserver = {
  #  enable = true;
  #  displayManager.sddm.enable = true;


  #  layout = "us";
  #  xkbVariant = "";
  #  xkbOptions = "ctrl:swapcaps";

  #  libinput.touchpad = {
  #    tapping = false;
  #    naturalScrolling = true;
  #    accelSpeed = "0.5";
  #    clickMethod = "clickfinger";
  #  };
  #};

  # Desktop Environment.
  #services.xserver.desktopManager.plasma5.enable = true;
  # services.xserver.windowManager.exwm.enable = true;

  fonts.packages = with pkgs; [
    font-awesome
    nerdfonts
  ];

  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
    xwayland.enable = true;
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  hardware = {
    opengl.enable = true;
    nvidia.modesetting.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  services.greetd = {
    enable = true;
    settings = {
      default_session.command = ''
       ${pkgs.greetd.tuigreet}/bin/tuigreet \
         --time \
         --cmd Hyprland
    '';
    };
  };

  # Below configs to stop systemd and kernel from writing over this.
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal";
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  security.polkit.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user0 = {
    isNormalUser = true;
    description = "user0";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    pavucontrol
    waybar
    dunst
    libnotify
    foot
    networkmanagerapplet
    fastfetch
    greetd.tuigreet
    qt6.qtwayland
    libsForQt5.qt5.qtwayland
  ];

  programs.steam = {
    enable = true;
    #remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    #dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  hardware.opengl.driSupport32Bit = true; # Enables support for 32bit libs that steam uses



  # Needed so zsh can complete system packages.
  environment.pathsToLink = [ "/share/zsh" ];

  #programs.vim.defaultEditor = true;

  # Must be enabled at the top, regardless of home-manager configs.
  programs.zsh.enable = true;

  home-manager.users.user0 = { pkgs, inputs, ... }: {
    # declared packages
    home.packages = with pkgs; [
      htop
      git

      # Doom emacs requirements
      emacs
      git
      ripgrep
      coreutils
      fd
      clang

      # Emacs config-specific stuff
      pandoc
      shellcheck
      iosevka
      cmake
      gnumake
      libtool
      nixfmt
      python3
      #isort
      #pipenv
      #python311Packages.nose
      #python311Packages.pytest

      mpv
      steam
      anki

      ansible
      yamllint
      ansible-lint

      brightnessctl
      pamixer
      wpaperd
      unzip
      fastfetch

      rofi-power-menu
    ];

    home.username = "user0";
    home.homeDirectory = "/home/user0";

    # TODO: Improve privacy settings automatically (https everywhere, don't collect data, don't ask for password)
    programs.firefox = {
      enable = true;
      profiles.default = {
        isDefault = true;
        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          bitwarden
          ublock-origin
          sponsorblock
          tridactyl
          youtube-shorts-block
        ];
        search = {
          default = "DuckDuckGo";
          force = true;
          order = [ "DuckDuckGo" "Wikipedia" "Google" ];
        };
      };
    };

    programs.git = {
      enable = true;
      userName = "raiden";
      userEmail = "raidenworley@gmail.com";
    };

    programs.zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = ./p10k-config;
          file = "p10k.zsh";
        }
      ];
      initExtra = ''
        export PATH=$PATH:~/.emacs.d/bin
      '';
    };

    home.file.".doom.d" = {
      enable = true;
      source = ./doom.d;
    };
    services.emacs = {
      enable = true;
      client.enable = true;
      defaultEditor = true;
    };
    home.file.hypr = {
      enable = true;
      source = ./hypr;
      target = ".config/hypr";
    };

    home.file.waybar = {
      enable = true;
      source = ./waybar;
      target = ".config/waybar";
    };

    home.file.foot = {
      enable = true;
      source = ./foot;
      target = ".config/foot";
    };

    home.file.wpaperd = {
      enable = true;
      source = ./wpaperd;
      target = ".config/wpaperd";
    };

    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      extraConfig = {
        display-drun = "Applications:";
        drun-display-format = "{name}";
        show-icons = true;
        icon-theme = "Papirus";
      };
      font = "Noto Sans 20";
      theme = ./rofi.rasi;
    };

    home.stateVersion = "23.05";
  };


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
