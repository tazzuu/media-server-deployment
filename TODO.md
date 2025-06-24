- update grub /etc/default/grub
- tdarr
- snapraid runner
- add Intel transcode driver option for Plex docker compose

- separate repo for finalized docker compose app dir for reference
- apply hdparm for drive spin down https://wiki.archlinux.org/title/Hdparm
- try some of these https://web.archive.org/save/https://andrejacobs.org/b24/linux/spinning-down-seagate-hard-drives-in-ubuntu-20-04/
- try this https://github.com/Seagate/openSeaChest

- finish hdparm systemd service

- add https://github.com/tubearchivist/tubearchivist
  - also add a container for https://github.com/yt-dlp/yt-dlp


DONE

- ~~sonarr, radarr, etc., app docker compose templates~~
- ~~/etc/samba/smb.conf~~
- ~~update mount points for appdrive, media drive, cache drive~~
- ~~update kernel / GRUB for IOMMU~~
  - should work out of the box with defaults
- ~~fail2ban install~~
- ~~phoronix-test-suite~~
- ~~/etc/smartd.conf~~
- ~~/etc/snapraid.conf~~
- ~~smartmontools scripts~~
- ~~ufw setup~~
- ~~ASPM power management~~
  - needs to be done in BIOS, the OS one is lousy
- ~~fix reboot option ; https://askubuntu.com/questions/7114/why-cant-i-restart-shutdown~~
  - this randomly fixed itself somehow idk how
- ~~fix nvtop Intel config ; https://github.com/Syllo/nvtop/issues/363~~
  - Intel Arc 310 works with nvtop if you install nvtop from Snap instead of apt
- ~~figure out the requirements to get Plex to transcode to RAM since we have a lot of it~~

WONT DO

- ~~bashrc extras, inputrc extras, etc~~
- ~~immich~~
- ~~diskover~~
- ~~add Plex transcode cache volume~~
  - this needs to be configured inside the app, we already put the app on fast storage so thats good enough
- ~~maintainerr https://github.com/jorenn92/Maintainerr~~
  - had issues with installation skip this
- ~~lm-sensors~~
- ~~powerstat~~
