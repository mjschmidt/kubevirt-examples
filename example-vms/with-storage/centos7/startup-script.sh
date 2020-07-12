#cloud-config

#package_upgrade: true

#packages:
#  - git
#  - xrdp
#  -

runcmd:
 - [ sh, -c, "yum groupinstall -y 'GNOME Desktop' 'Graphical Administration Tools'" ]
 - [ sh, -c, "ln -sf /lib/systemd/system/runlevel5.target /etc/systemd/system/default.target" ]
 - [ sh, -c, "rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm" ]
 - [ sh, -c, "yum -y install xrdp tigervnc-server" ]
 - [ sh, -c, "systemctl start xrdp" ]
 - [ sh, -c, "systemctl enable xrdp" ]
 - [ sh, -c, "firewall-cmd --permanent --add-port=3389/tcp" ]
 - [ sh, -c, "firewall-cmd --reload" ]
 - [ sh, -c, "reboot" ]

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
      - ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAr8clPM2ahKBLcZp1sh7++UlrPH/FBiDE8tKbw4oFlFkZAD5QSAyvHI+4JMqB6FefBP9Tm969wqPj5I9RBtqcI1fTQV6veR+DJ7bwHrIgXrqWYqLajuVFsAgUX96xvL8F46bo+kWBk1/cI/7qLW8/r5yt+HRo2QhKIVyqxaiwohdI8aAHUZUDuLtsjZl3l625Dj9eFCQE3d3ijC0eGS8ztPHqIY4f8om1BtyraypCGTUoiIJUGiJevg60E+l4Xh1E4m95pHgCiTI3Qifx09/6fmoIFLf+jq7q/KHx1/LlSiBC70SJniNywhtyfx6AMQ7ABC+RRMFznX9eorJwC6LJpQ== rsa-key-20181108 

