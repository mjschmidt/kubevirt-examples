# centos-kubevirt

## Getting the .qcow2 files
images for centos are found here https://cloud.centos.org/centos/7/images/

I use this one specifically https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1907.qcow2

## Actually doing a thing

### Install Kubevirt to your Cloud
https://kubevirt.io/user-guide/docs/latest/administration/intro.html

### Cloud-Init
you must copy and past the output of cloud-init (startup) into yaml
```
cat startup-script | base64 -w0
```
###Esposing a vm using virtctl
```
virtctl expose vmi myvmi  --port=22 --name=ssh --type=NodePort
```

### Additional cloud-init in progress
```
/etc/sysconfig/64bit_strstr_via_64bit_strstr_sse2_unaligned
```
