# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.enableCryptodisk = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # boot.loader.efi.canTouchEfiVariables = true;
  # Define on which hard drive you want to install Grub.
  boot.loader.grub.device = "/dev/nvme0n1"; # or "nodev" for efi only

  boot.initrd.luks.devices = [
    { 
      name = "crypted";
      device = "/dev/nvme0n1p2";
      preLVM = true;
    }
  ];

  networking.hostName = "alobar"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Select internationalisation properties.
  # i18n = {
  #   defaultLocale = "en_US.UTF-8";
  # };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    ack
    acpid
    arandr
    aspell
    bash
    bash-completion
    bashCompletion
    chkrootkit
    coreutils
    dmenu
    dpkg
    dropbox
    dunst
    enpass
    entr
    file
    firefox
    fzf
    gcc
    ghc
    gimp
    gitAndTools.gitFull
    gnumake
    gnupg
    google-chrome
    gzip
    haskellPackages.ghc-mod
    haskellPackages.hoogle
    haskellPackages.idris
    haskellPackages.xmobar
    htop
    i3lock
    keybase
    keychain
    maim
    mercurialFull
    mosh
    mupdf
    nixui
    nix-zsh-completions
    opensc
    openvpn
    pavucontrol
    pcmanfm
    pg_top
    pigz
    platinum-searcher
    postgresql
    psmisc
    readline
    redshift
    rsync
    silver-searcher
    skype
    slock
    slop
    sox
    spotify
    stdenv
    taskwarrior
    tmux
    tor
    tree
    unrar
    vim
    wget
    which
    xautoclick
    xautolock
    xcape
    xfce.terminal
    xfce.thunar
    xz
    zeal
    zip
    zsh
    zsh-autosuggestions
    zsh-completions
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  services = {
    printing = {
      enable = true;
      drivers = [
        pkgs.splix
        pkgs.cups-bjnp
        pkgs.cups-filters
        pkgs.canon-cups-ufr2
        pkgs.gutenprint
      ];
    };
    openssh.enable = true;
    redshift = {
      enable = false;
      latitude = "40.7127";
      longitude = "74.0059";
    };
    xserver = {
      enable = true;
      layout = "us";
      xkbOptions = "ctrl:swapcaps";
      synaptics = {
        enable = true;
        dev = "/dev/input/event*";
        vertTwoFingerScroll = true;
        accelFactor = "0.01";
        buttonsMap = [ 1 3 2 ];
      };
      # XMonad forever
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };
  users = {
    extraUsers.matt = {
      isNormalUser = true;
      home = "/home/matt";
      extraGroups = [ "wheel" "networkmanager" ];
      uid = 1000;
      shell = "/run/current-system/sw/bin/zsh";
    };
  };
  programs = {
    light = {
      enable = true;
    };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
    };
  };

  hardware = {
   pulseaudio.enable = true;
   pulseaudio.support32Bit = true; # This might be needed for Steam games
  };
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
