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
<img src="images/KV_status_image.JPG" width="600" height="300" align="center" />


## Steps for adding CDI environment:

### Create and deploy CDI operator to cluster
```
mkdir ~/cdi && cd $_

wget https://github.com/kubevirt/containerized-data-importer/releases/download/v1.12.0/cdi-operator.yaml
kubectl create -f cdi-operator.yaml

wget https://github.com/kubevirt/containerized-data-importer/releases/download/v1.12.0/cdi-cr.yaml
kubectl create -f cdi-cr.yaml
```
<img src="images/CDI_status_image.JPG" width="600" height="300" align="center" />

## Create Minikube storage environment

### Build image into PVC to test VM creation
```
mkdir ~/fedora && cd $_
vim pvc_fedora1.yml
```

### PVC details:
```
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: fedora1
  labels:
    app: containerized-data-importer
  annotations:
    cdi.kubevirt.io/storage.import.endpoint: "https://download.fedoraproject.org/pub/fedora/linux/releases/30/Cloud/x86_64/images/Fedora-Cloud-Base-30-1.2.x86_64.raw.xz"
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
```

### Create the PVC with Fedora image
```
kubectl create -f pvc_fedora1.yml
```

### Wait for CDI image import to complete
> (K8s pod importer-fedora1-xxxxx will run then complete)
```
watch -d kubectl get all
```
<img src="images/watchk_1_status.JPG" width="600" height="150" align="center" />

> Check to make sure PVC claim is bound
```
kubectl get pvc
```
<img src="images/pvc_status.JPG" width="600" height="50" align="center" />

### Create VM and add public key
```
vim vm_fedora1.yml
```

### VM details:
```
apiVersion: kubevirt.io/v1alpha3
kind: VirtualMachine
metadata:
  generation: 1
  labels:
    kubevirt.io/os: linux
  name: fedora1
spec:
  running: true
  template:
    metadata:
      creationTimestamp: null
      labels:
        kubevirt.io/domain: fedora1
    spec:
      domain:
        cpu:
          cores: 2
        devices:
          disks:
          - disk:
              bus: virtio
            name: disk0
          - cdrom:
              bus: sata
              readonly: true
            name: cloudinitdisk
        machine:
          type: q35
        resources:
          requests:
            memory: 2048M
      volumes:
      - name: disk0
        persistentVolumeClaim:
          claimName: fedora1
      - cloudInitNoCloud:
          userData: |
            #cloud-config
            hostname: fedora1
            ssh_pwauth: True
            disable_root: false
            ssh_authorized_keys:
            - ssh-rsa << Place Public Key Here >>
        name: cloudinitdisk
```

### Apply to cluster and watch for creation
```
kubectl create -f vm_fedora1.yml
watch -d kubectl get all
virtctl console fedora1
```
<img src="images/watchk_2_status.JPG" width="600" height="300" align="center" />

### Create nodeport service for SSH access
```
virtctl expose vmi fedora1 --name=fedora1-ssh --port=22 --type=NodePort
```

### Grab nodeport created and ssh into box
```
kubectl get all
ssh fedora@<host machine ip> -p <service nodeport>
```
<img src="images/success.JPG" width="600" height="150" align="center" />
