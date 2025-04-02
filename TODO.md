- update grub /etc/default/grub
- tdarr
- snapraid runner
- add Intel transcode driver option for Plex docker compose
- fix reboot option ; https://askubuntu.com/questions/7114/why-cant-i-restart-shutdown
- lm-sensors
- powerstat
- maintainerr https://github.com/jorenn92/Maintainerr

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


WONT DO

- ~~bashrc extras, inputrc extras, etc~~
- ~~immich~~
- ~~diskover~~
- ~~add Plex transcode cache volume~~
  - this needs to be configured inside the app, we already put the app on fast storage so thats good enough