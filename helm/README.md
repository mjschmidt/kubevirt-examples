
# KubeVirt
<img src="../images/helm-kubevirt.png" align="left" width="500px" height="250px"/>
<img align="left" width="0" height="192px" hspace="10"/>
<br></br><br></br>

> Utilizing KubeVirt to run a Fedora VM on top of Kubernetes

[![Under Development](https://img.shields.io/badge/under-development-skyblue.svg)](https://github.com/cez-aug/github-project-boilerplate) [![Public Domain](https://img.shields.io/badge/public-domain-lightgrey.svg)](https://creativecommons.org/publicdomain/zero/1.0/)

<br><br><br>

## Goals
> _The goal of this folder is to create the helm charts nessisary to launch KubeVirt Virtual Machines, the actual launching of the operator is not in scope for what we are trying to accomplish.

## Project Dependencies
* Minikube 1.5.2+
* Kubectl 1.16.2+
* Docker 19.03.5+
* KubeVirt v0.24.0+
* CDI v1.11.0+

## Current Progress & Steps

- [x] **Create Virtual Machine only if PVC is pre provisioned**
- [ ] **Increase the flexibility of the VM helm charts**
  - [x] Configurable Name
  - [x] Configurable Namespace
  - [x] Configurable static labels
  - [ ] User added dynamic labels
  - [x] Set running or dormant state
  - [x] Configurable memory
  - [x] Configurable CPU
  - [ ] Configurable Cloud InIt Script
    - [ ] Set Cloud init via variables
    - [ ] Set Cloud init via kubernetes secret
  - [ ] Add optional ssh exposed kubernetes service
  - [ ] Add optional vnc exposed kubernetes service
- [ ] **Create an example of rdp enabled VM and contribute it back to KubeVirt**
  - [ ] Fedora Workstation/Gnome
  - [ ] Cinnamon Desktop
- [ ] **Create a CDI enabled PVC with a seperate helm chart**
- [ ] **Increase flexibility of the CDI enabled PVC helm chart**
  - [ ] Make the OS configurable via differnt 
  - [ ] Set if statements that allow people to state desired OS rather than S3:// endpoints for a limited number of preset options
    - [ ] CentOS8 (if it works)
    - [ ] Fedorra 30
    - [ ] Ubuntu
    - [ ] RHEL
  - [ ] Enable choice between container image disk or pvc with helm if statement
- [ ] **Create one chart to rule them all that successfully deploys the PVC, then after an appropriate amount of time deploys the VM**

## Usage
1) Edit and create the nessisary pvc ahead of time from within the pre reqs folder'

```
kubectl create -f prereqs/pvc_fedora_vm.yml
```
2) Wait for the CDI pod to load in the Fedorra OS

3) Deploy the helm chart

```
helm install your-helm-deployment-name ./vm-chart/
```

## Helm chart Configuration

The following table lists the configurable parameters of the Airflow chart and their default values.

| Parameter                                | Description                                             | Default                   |
|------------------------------------------|---------------------------------------------------------|---------------------------|
| `kubevirt.namespace`                     | Namespace the VM will be deployed to                    | ```default```             |
| `kubevirt.name`                          | Virtual Machine Name                                    | ```vm```                  |
| `kubevirt.labels.size`                   | Just a label to give external pulling entifies more info| ```small```               |
| `kubevirt.labels.domain`                 | Just a label to give external pulling entifies more info| ```test-vm```             |
| `kubevirt.labels.distro`                 | Just a label to give external pulling entifies more info| ```linux```               |
| `kubevirt.labels.os`                     | Just a label to give external pulling entifies more info| `linux`                   |
| `kubevirt.running`                       | Vm deployed in a running state of in a stopped state    | `running`                 |
| `kubevirt.memory`                        | Denotes how much memory is allocated to vm              | `4096M`                   |
| `kubevirt.cpu`                           | Denotes how many cpus are allocated to vm               | `2`                       |
| `kubevirt.storage.cloud.init`            | Add a base64 encoded cloud init script to your vm       | `nothing`                 |

## Clean up
When you are finished with the vm & pvc
```
helm del your-helm-deployment-name
kubectl delete -f prereqs/pvc_fedora_vm.yml
```
