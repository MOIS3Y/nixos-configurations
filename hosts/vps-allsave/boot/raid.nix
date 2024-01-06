# █▀█ ▄▀█ █ █▀▄ ▀
# █▀▄ █▀█ █ █▄▀ ▄
# -- -- -- -- -- 

{ config, pkgs, ...}: {
  boot.swraid = {
    enable = true;
    mdadmConf = ''
      ARRAY /dev/md0 level=raid1 num-devices=2 metadata=0.90 UUID=8bb2622a:203030e8:ac926b66:e55a92b1
      ARRAY /dev/md1 level=raid1 num-devices=2 metadata=1.2 name=allsave:1 UUID=1408f414:46bd022f:a3be13b0:c1560046
      ARRAY /dev/md2 level=raid1 num-devices=2 metadata=1.2 name=allsave:2 UUID=4db185fa:54cf0828:89ed0f44:1b63382a
      ARRAY /dev/md3 level=raid1 num-devices=2 metadata=1.2 name=allsave:3 UUID=14c9d6da:2e618286:df380868:d8d07f27
    '';
  };
}
