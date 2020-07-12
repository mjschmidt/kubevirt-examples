# Building Centos VMs on K8s

> Creating a CentOS VM

## Quick Start

### Update your startup-script.sh
Make sure you replace the public rsa key in the startup script with your public rsa key otherwise you will not be allowed to ssh to the vm

### Create the PVC and allow CDI to import CentOS7 bas image
Create the PVC

```kubectl create -f pvc-centos.yaml```

Verfiy that CDI is populating the pvc with the CentOS7 image
```
kubectl get all
```
You should see the following output
```
NAME                           READY   STATUS    RESTARTS   AGE
pod/importer-example-centos7   1/1     Running   0          31s

NAME                      AGE    PHASE
cdi.cdi.kubevirt.io/cdi   2d9h   Deployed

NAME                               AGE
cdiconfig.cdi.kubevirt.io/config   2d9h```
```

### Edit your vmi-centos.yaml file to include your startup-script.sh
Assuming you have alreadyed edited your startup-script.sh, enter the base64 encodded contents of that file into your vmi file.
```
cat startup-script.sh | base64 -w0
```

### Delete the encircled contents file and replace with your output from the previous command

<img src="../../../images/replace-userdata.PNG"/>

### Launch the Virtual Machine Instnace
```kubectl create -f vmi-centos.yaml```

### Verify that your Kubevirt machine has launched
```kubectl get all```
You should see the following output
```NAME                            READY   STATUS    RESTARTS   AGE
pod/virt-launcher-myvmi-sn726   1/1     Running   0          15s

NAME                      AGE    PHASE
cdi.cdi.kubevirt.io/cdi   2d9h   Deployed

NAME                               AGE
cdiconfig.cdi.kubevirt.io/config   2d9h

NAME                                       AGE   PHASE       IP            NODENAME
virtualmachineinstance.kubevirt.io/myvmi   15s   Scheduled   10.42.2.246   ip-10-113-61-217

NAME                               AGE   VOLUME
virtualmachine.kubevirt.io/myvmi   15s
```

### Be patient and expose your VM's services
This can take minutes to over an hour to launch depending on your backend fabric. This greatly affects the performance of the vm.

To expose your VM's port 22 (ssh) and 3389 (RDP) use virctl's expose command. Or the following service yaml.
```
apiVersion: v1
items:
- apiVersion: v1
  kind: Service
  metadata:
    annotations:
      field.cattle.io/publicEndpoints: '[{"addresses":["10.113.61.172"],"port":30575,"protocol":"TCP","serviceName":"mjschm3:myvmi-rdp","allNodes":true}]'
    creationTimestamp: "2020-07-12T01:11:20Z"
    name: myvmi-rdp
    resourceVersion: "1865799"
    selfLink: /api/v1/namespaces/mjschm3/services/myvmi-rdp
    uid: ed1df86f-0ca8-45bf-865b-f410bb64727c
  spec:
    clusterIP: 10.43.49.94
    externalTrafficPolicy: Cluster
    ports:
    - nodePort: 30575
      port: 3389
      protocol: TCP
      targetPort: 3389
    selector:
      kubevirt.io/domain: centos1
    sessionAffinity: None
    type: NodePort
  status:
    loadBalancer: {}
- apiVersion: v1
  kind: Service
  metadata:
    annotations:
      field.cattle.io/publicEndpoints: '[{"addresses":["10.113.61.172"],"port":32171,"protocol":"TCP","serviceName":"mjschm3:myvmi-ssh","allNodes":true}]'
    creationTimestamp: "2020-07-12T00:47:13Z"
    name: myvmi-ssh
    resourceVersion: "1855162"
    selfLink: /api/v1/namespaces/mjschm3/services/myvmi-ssh
    uid: 092e2596-c78b-4584-bbf9-1a7937646b07
  spec:
    clusterIP: 10.43.17.207
    externalTrafficPolicy: Cluster
    ports:
    - nodePort: 32171
      port: 22
      protocol: TCP
      targetPort: 22
    selector:
      kubevirt.io/domain: myvmi
    sessionAffinity: None
    type: NodePort
  status:
    loadBalancer: {}
kind: List
metadata:
  resourceVersion: ""
  selfLink: ""
```
