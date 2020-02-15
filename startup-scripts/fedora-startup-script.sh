#cloud-config

package_upgrade: true

packages:
  - git

users:
  - name: fedora
    gecos: fedora
    password: password
    lock-passwd: false
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa 
  - name: nadorr
    gecos: nadorr
    lock-passwd: false
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa
  - name: mjschmidt
    gecos: mjschmidt
    lock-passwd: false
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    ssh_authorized_keys:
      - ssh-rsa 
