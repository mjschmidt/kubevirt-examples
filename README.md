# Building the KubeVirt and CDI Environment

## Steps for adding KubeVirt environment:

### Install Virtctl
```
chmod +x /versions/v0.24.0/virtctl
sudo mv /versions/v0.24.0/virtctl /usr/bin
```

### Create KubeVirt Namespace
```
kubectl create ns kubevirt
```

### Turn on emulation mode
```
kubectl create configmap -n kubevirt kubevirt-config --from-literal debug.useEmulation=true
```

### Create and deploy KubeVirt operator to cluster
```
kubectl create -f /versions/v0.24.0/kubevirt-operator.yaml
kubectl create -f /versions/v0.24.0/kubevirt-cr.yaml
```

### Check status of operator creation
```
watch -d kubectl get all -n kubevirt
```
<img src="images/KV_status_image.JPG" width="600" height="300" align="center" />


## Steps for adding CDI environment:

### Create Minikube storage environment
```
kubectl create -f /versions/v0.24.0/storage-setup.yml
```

### Create and deploy CDI operator to cluster
```
kubectl create -f /versions/v1.11.0/cdi-operator.yaml
kubectl create -f /versions/v1.11.0/cdi-cr.yaml
```
<img src="images/CDI_status_image.JPG" width="600" height="300" align="center" />

### Create image with PVC to test VM creation
```
kubectl create -f /tests/centos-pvc.yaml
```

### Wait for CDI image import to complete
> (K8s pod importer-centos-xxxxx will run then complete)
```
watch -d kubectl get all
```
<img src="images/watchk_1_status.JPG" width="600" height="150" align="center" />

> Check to make sure PVC claim is bound
```
kubectl get pvc
```
<img src="images/pvc_status.JPG" width="600" height="50" align="center" />

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
kubectl apply -f /tests/centos1-vm.yaml
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

