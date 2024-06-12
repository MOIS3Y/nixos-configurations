# █▀ █░█ █▀▀ ▄▀█ █▀█ ▄▄ █▀▀ ▄▀█ █▄░█ █▀▄ █▄█ ▀
# ▄█ █▄█ █▄█ █▀█ █▀▄ ░░ █▄▄ █▀█ █░▀█ █▄▀ ░█░ ▄
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

# modified theme for sddm display manager:
# required: libsForQt5.qt5.qtgraphicaleffects in systemPackages

{ pkgs, ... }: 
let
  iniFmt = pkgs.formats.ini { };
  customConfig = {
    General = {
      Background="Backgrounds/cat-leaves.png";
      DimBackgroundImage="0.0";
      ScaleImageCropped="true";
      ScreenWidth="1920";
      ScreenHeight="1080";
      FullBlur="false";
      PartialBlur="true";
      BlurRadius="100";
      HaveFormBackground="false";
      FormPosition="left";
      BackgroundImageHAlignment="center";
      BackgroundImageVAlignment="center";
      MainColor="#cdd6f4";
      AccentColor="#89b4fa";
      BackgroundColor="#313244";
      OverrideLoginButtonTextColor="#1e1e2e";
      InterfaceShadowSize="6";
      InterfaceShadowOpacity="0.6";
      RoundCorners="20";
      ScreenPadding="0";
      Font="Noto Sans";
      FontSize="";
      ForceRightToLeft="false";
      ForceLastUser="true";
      ForcePasswordFocus="true";
      ForceHideCompletePassword="false";
      ForceHideVirtualKeyboardButton="false";
      ForceHideSystemButtons="false";
      AllowEmptyPassword="false";
      AllowBadUsernames="false";
      Locale="";
      HourFormat="HH:mm";
      DateFormat="\"dddd, d MMMM yyyy\"";
      HeaderText="NixOS";
      TranslatePlaceholderUsername="";
      TranslatePlaceholderPassword="";
      TranslateShowPassword="";
      TranslateLogin="";
      TranslateLoginFailedWarning="";
      TranslateCapslockWarning="";
      TranslateSession="";
      TranslateSuspend="";
      TranslateHibernate="";
      TranslateReboot="";
      TranslateShutdown="";
      TranslateVirtualKeyboardButton="";
    };
  };
  cfgFile = iniFmt.generate "theme.conf.user" customConfig;
in
  with pkgs; stdenv.mkDerivation rec {
    pname = "sugar-candy";
    version = "v1.6.1";
    userConfig = cfgFile;
    nativeBuildInputs = [ libsForQt5.qt5.wrapQtAppsHook ];
    propagatedBuildInputs = [
      libsForQt5.qt5.qtgraphicaleffects
      libsForQt5.qt5.qtquickcontrols
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtsvg
    ];
    src = fetchFromGitHub {
      name = "sugar-candy";
      owner = "MOIS3Y";
      repo = "sugar-candy";
      rev = "${version}";
      hash = "sha256-xRVeJC3qeJJtmtbQYkgsqk7dqs09jrIt+ug+ZeqAPnI=";
    };
    phases = [ "unpackPhase" "installPhase" ];
    installPhase = ''
      mkdir -p $out
      cp -r $src/* $out/
      cp $userConfig $out/theme.conf.user
    '';
    onCheck = false;
  }
