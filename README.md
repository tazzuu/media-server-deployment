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
./launch
```

Check that ssh access works

```bash
ssh -i dev-key ubuntu@10.122.12.69
```

### Multipass Resources

- https://canonical.com/multipass/docs/install-multipass
- https://canonical.com/multipass/docs/how-to-guides
- https://cloudinit.readthedocs.io/en/latest/howto/launch_multipass.html#launch-multipass
- https://dev.to/arc42/enable-ssh-access-to-multipass-vms-36p7
- https://github.com/alexellis/k3sup/issues/315
- https://www.linode.com/docs/guides/configure-and-secure-servers-with-cloud-init/

## Ansible Setup

Use Ansible to configure the server

Install Ansible

```bash
sudo apt install ansible
```
Run Playbook

```bash
ansible-playbook --private-key dev-key --user ubuntu -i $(./get-ip.sh), playbook.yaml
```

Debug the dev server with

```bash
ssh -i dev-key ubuntu@$(./get-ip.sh)
````
