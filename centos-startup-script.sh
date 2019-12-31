#cloud-config

package_upgrade: true

packages:
  - git

#if something goes wrong this is the issue
write_files:
-   content: |
        # My new /etc/sysconfig/samba file
        #
        #         SMBDOPTIONS="-D"
    owner: root:root
    path: /etc/sysconfig/64bit_strstr_via_64bit_strstr_sse2_unaligned

users:
  - name: centos
    gecos: centos
    password: password
    lock-passwd: false
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - ssh-rsa 
  - name: mjschmidt
    gecos: mjschmidt
    lock-passwd: false
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - ssh-rsa
  - name: nadorr
    gecos: nadorr
    lock-passwd: false
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - ssh-rsa
