#cloud-config

package_upgrade: false

packages:
  - git

users:
  - name: centos
    gecos: centos
    password: password
    lock-passwd: false
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - # Add PubKey Here
  - name: user
    gecos: user
    lock-passwd: false
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - # Add PubKey Here

