# Building Centos VMs on K8s

> As a follow on from building Fedora VMs with KubeVirt and CDI @ [FedoraVM](https://github.com/nicholasadorr/centos-kubevirt/tree/master/fedora)

## View and modify Centos PVC

Centos image requires additional space compared to Fedora

> centos-pvc.yaml
```
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: "centos"
  labels:
    app: containerized-data-importer
  annotations:
    cdi.kubevirt.io/storage.import.endpoint: "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud-1907.qcow2"
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 8Gi #changed to 8Gi from 4Gi
  storageClassName: hostpath

```
## Apply PVC to bound to hostpath provisioner used previously

```
kubectl apply -f centos-pvc.yaml
# wait to complete image pull by CDI importer
watch -d kubectl get all
```
## Modify UserDataScript.sh appropriately with public key
```
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
```
## Apply centos1-vm.yaml
```
kubectl apply -f centos1-vm.yaml
# wait to complete VM creation process
watch -d kubectl get all
```

## Create nodeport service for SSH access
```
virtctl expose vmi centos1 --name=centos1-ssh --port=22 --type=NodePort
```

## Access VM via SSH
```
# grab service port
kubectl get all
user@<host machine ip> -p <nodeport service port>
```
