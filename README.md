# Media Server Deployment

## Dev Server VM Setup

Use `multipass` for running dev server in a local vm for testing

### Install `multipass` and `jq`

```bash
snap install multipass jq
```

### Launch dev server

Create an ssh key to be used in the dev server VM

```bash
# create the dev ssh key
ssh-keygen -f dev-key
```

Launch the dev server VM

```bash
./launch-dev-server.sh
```

Check that ssh access works

```bash
ssh -i dev-key ubuntu@$(./get-ip.sh)
````

Delete the dev server with

```bash
./remove-dev-server.sh
```

### Multipass Resources

- https://canonical.com/multipass/docs/install-multipass
- https://canonical.com/multipass/docs/how-to-guides
- https://cloudinit.readthedocs.io/en/latest/howto/launch_multipass.html#launch-multipass
- https://dev.to/arc42/enable-ssh-access-to-multipass-vms-36p7
- https://github.com/alexellis/k3sup/issues/315
- https://www.linode.com/docs/guides/configure-and-secure-servers-with-cloud-init/

## Pre-Deployment Setup

On your real server you will need to (temporarily) disable the password for `sudo`

- https://askubuntu.com/questions/147241/execute-sudo-without-password

You will also need to create a local ssh key (`ssh-keygen`) and copy the public key to the remote server under `~/.ssh/authorized_keys`.

Make sure that when you installed Ubuntu onto the real server you elected to install and enable the OpenSSH server service.

## Server Deployment

Use Ansible to configure the server

Install Ansible locally on the system you want to deploy from (e.g. your laptop)

```bash
sudo apt install ansible
```
Run Playbook to run the tasks on the remote server (the one you are deploying to)

```bash
# using dev server
ansible-playbook --private-key dev-key --user ubuntu -i $(./get-ip.sh), playbook.yaml

# OR

# using your real server
ansible-playbook --private-key ~/.ssh/my-key --user $USER -i 192.168.1.2, playbook.yaml

# OR

# run it from within the server itself
ansible-playbook playbook.yaml --connection=local -i 127.0.0.1, --user $USER
```

## Post Deployment Steps

These need to be done manually so that you can inspect each step to make sure it matches your system requirements.

- resive the root volume
  - https://askubuntu.com/questions/1417938/ubuntu-does-not-use-full-disk-space-how-to-extend

```bash
sudo lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv
sudo resize2fs /dev/mapper/ubuntu--vg-ubuntu--lv
```

- disable swap in /etc/fstab (by commenting out the line that makes a swap volume)
- import your custom dotfiles
- format any new disks

```bash
# identify unformatted disk
sudo parted -l
# or lsblk -f

# make partition table
# PUT YOUR DISK HERE
sudo parted /dev/nvme1n1 mklabel gpt

# make partition
sudo parted -a opt /dev/nvme1n1 mkpart primary xfs 0% 100%

# format the partition ; NOTE we are addressing the partition here p1
sudo mkfs.xfs /dev/nvme1n1p1

# find UUID with lsblk -f and add to /etc/fstab with /dev/disk/by-id/
# mount with
sudo mount -a

# update permissions on mounted volume
sudo chown -R username /mnt/apps
sudo chgrp -R username /mnt/apps
```

- update Grub settings to fix potential boot / reboot issues if needed
  -
```bash
sudo nano /etc/default/grub

# GRUB_CMDLINE_LINUX_DEFAULT="reboot=bios"

sudo update-grub
```

- copy over your existing app configs from the old server to the new one (`rsync`) under the designated locations

- run some stress tests

```bash
# run this with `nice` if you dont want the system to lock up
stress-ng --matrix 0 -t 1m
```

- complete the Phoronix Test Suite installation and run a test

```bash
cd ~/phoronix-test-suite
sudo ./install-sh
# this downloads a lot of test files
phoronix-test-suite benchmark svt-av1
```

- make sure `smartd` is running the `smartmontools` daemon and check its status and configs to make sure they look right

```bash
sudo systemctl status smartd
# to restart
# sudo systemctl restart smartd
cat /etc/smartd.conf
```

- enable the firewall and allow services

```bash
sudo ufw enable
sudo ufw allow OpenSSH
sudo ufw allow Samba
# for the media services to communicate with each other
sudo ufw allow 9696
sudo ufw allow 7878
sudo ufw allow 8989
sudo ufw allow 8080
# for plex
sudo ufw allow 32400
```

- create the required subdirs on the app drive and scratch drive, copy over your old app and service configs to their appropriate config dirs

- set power saving mode in BIOS
  - or software

```bash
sudo powerprofilesctl set power-saver
```

