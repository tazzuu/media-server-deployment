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

## Ansible Setup

Use Ansible to configure the server

Install Ansible

```bash
sudo apt install ansible
```
Run Playbook

```bash
# using dev server
ansible-playbook --private-key dev-key --user ubuntu -i $(./get-ip.sh), playbook.yaml

# OR

# using your real server
ansible-playbook --private-key ~/.ssh/my-key --user $USER -i 192.168.1.2, playbook.yaml
```

## Post Deployment Steps

These need to be done manually

- resive the root volume
  - https://askubuntu.com/questions/1417938/ubuntu-does-not-use-full-disk-space-how-to-extend

```bash
sudo lvextend -l +100%FREE /dev/mapper/ubuntu--vg-ubuntu--lv
```
- disable swap in /etc/fstab
- import dotfiles