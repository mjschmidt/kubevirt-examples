# Building the KubeVirt and CDI Environment

## Steps for adding KubeVirt environment:

### Create variable for KubeVirt version to deploy
```
export KV_VERSION="v0.24.0"
```

### Install Virtctl
```
curl -L -o virtctl https://github.com/kubevirt/kubevirt/releases/download/${KV_VERSION}/virtctl-${KV_VERSION}-linux-amd64
chmod +x virtctl
sudo mv virtctl /usr/bin
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
mkdir ~/kv && cd $_

wget https://github.com/kubevirt/kubevirt/releases/download/${KV_VERSION}/kubevirt-operator.yaml
kubectl create -f kubevirt-operator.yaml

wget https://github.com/kubevirt/kubevirt/releases/download/${KV_VERSION}/kubevirt-cr.yaml
kubectl create -f kubevirt-cr.yaml
```

### Check status of operator creation
```
watch -d kubectl get all -n kubevirt
```
<img src="images/KV_status_image.jpeg" width="600" height="300" align="center" />


## Steps for adding CDI environment:

### Create Minikube storage environment
```
mkdir ~/cdi && cd $_
wget https://raw.githubusercontent.com/kubevirt/kubevirt.github.io/master/labs/manifests/storage-setup.yml
kubectl create -f storage-setup.yml
```

### Create and deploy CDI operator to cluster
```
export VER="v1.11.0"

wget https://github.com/kubevirt/containerized-data-importer/releases/download/v1.11.0/cdi-operator.yaml
kubectl create -f cdi-operator.yaml

wget https://github.com/kubevirt/containerized-data-importer/releases/download/v1.11.0/cdi-cr.yaml
kubectl create -f cdi-cr.yaml
```
<img src="images/CDI_status_image.jpeg" width="600" height="300" align="center" />

### Create image with PVC to test VM creation
```
wget https://raw.githubusercontent.com/kubevirt/kubevirt.github.io/master/labs/manifests/pvc_fedora.yml
kubectl create -f pvc-fedora.yml
```

### Wait for CDI image import to complete
> (K8s pod importer-fedora-xxxxx will run then complete)
```
watch -d kubectl get all
```
<img src="images/watchk_1_status.jpeg" width="600" height="300" align="center" />

> Check to make sure PVC claim is bound
```
kubectl get pvc
```
<img src="images/pvc_status_image.jpeg" width="600" height="300" align="center" />

### Create VM and insert public key into yaml
```
wget https://raw.githubusercontent.com/kubevirt/kubevirt.github.io/master/labs/manifests/vm1_pvc.yml
cat << location of public key >>
```
then copy and paste in vm1-pvc.yml under ssh_authorized_keys section and apply to cluster
```
kubectl create -f vm1-pvc.yml
```

### Watch while VM is being created and/or watch machine spinup
```
watch -d kubectl get all
virtctl console vm1
```
<img src="images/watchk_2_status.jpeg" width="600" height="300" align="center" />

### Create nodeport service for SSH access
```
virtctl expose vmi vm1 --name=vm1-ssh --port=22 --type=NodePort
```

### Grab nodeport created and ssh into box
```
kubectl get all
fedora@<host machine ip> -p <service nodeport>
```
<img src="images/success.jpeg" width="600" height="300" align="center" />
