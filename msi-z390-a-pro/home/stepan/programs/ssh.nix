# █▀ █▀ █░█ ▀
# ▄█ ▄█ █▀█ ▄
# -- -- -- --

{ config, pkgs, ... }:
  let
    ispkeys = "${config.home.homeDirectory}/.ssh/ispkeys";
    public = "${config.home.homeDirectory}/.ssh/public";
    self = "${config.home.homeDirectory}/.ssh/self";
  in {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      # isp:
      "isp" = {
        user = "s.zhukovskii";
        identityFile = "${ispkeys}/ISP_ecdsa";
        certificateFile = "${ispkeys}/ISP_ecdsa-cert.pub";
        port = 22;
        hostname = "ssh.ispsystem.net";
      };
      "services.isptech.ru" = {
        user = "admserv";
        identityFile = "${ispkeys}/ISP_ecdsa";
        port = 2222;
        hostname = "185.60.134.99";
      };
      "git.isptech.ru" = {
        identityFile = "${ispkeys}/ISP_GITEA_ecdsa";
        identitiesOnly = true;
        port = 22;
        hostname = "git.isptech.ru";
      };
      # public:
      "github.com" = {
        identityFile = "${public}/MOIS3Y_GITHUB_ecdsa";
        identitiesOnly = true;
        port = 22;
        hostname = "github.com";
      };
      # self:
      "allsave" = {
        user = "admserv";
        identityFile = "${self}/ALLSAVE_ecdsa";
        port = 22;
        hostname = "192.168.1.100";
      };
      "git.zhukovsky.me" = {
        user = "git";
        identityFile = "${self}/GITEA_ecdsa";
        identitiesOnly = true;
        port = 22;
        hostname = "git.zhukovsky.me";
      };
      "gliese" = {
        user = "admdns";
        identityFile = "${self}/GLIESE_ecdsa";
        port = 22;
        hostname = "94.103.94.187";
      };
      "solar" = {
        user = "admserv";
        identityFile = "${self}/SOLAR_ecdsa";
        port = 2222;
        hostname = "188.120.255.34";
      };
      # ... add more matchers here:
    };
  };
}
