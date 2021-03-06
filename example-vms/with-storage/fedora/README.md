<img src="fedora-logo.png" align="left" width="192px" height="192px"/>
<img align="left" width="0" height="192px" hspace="10"/>

> Example of launching a Fedora VM with Storage on Kubernetes

[![Under Development](https://img.shields.io/badge/innersourced-development-skyblue.svg)](https://github.com/cezaraugusto/github-template-guidelines) [![Public Domain](https://img.shields.io/badge/public-domain-lightgrey.svg)](https://creativecommons.org/publicdomain/zero/1.0/) [![Travis](https://img.shields.io/badge/build-none-red.svg)](http://github.com/cezaraugusto/github-template-guidelines)

Fedora is basically CentOS, just a more cloud friendly, upstream version :alien:

<br>
<p align="center">
<strong>Templates included:</strong>
<a href="/.github/README.md">README</a> • <a href="/.github/CONTRIBUTING.md">CONTRIBUTING </a> • <a href="/.github/PULL_REQUEST_TEMPLATE.md">PULL REQUEST</a> • <a href="/.github/ISSUE_TEMPLATE.md">ISSUE TEMPLATE</a> • <a href="/.github/CONTRIBUTORS.md">CONTRIBUTORS</a>
</p>
<br>

## Installing

Clone this project and name it accordingly:

``git clone git@github.com:cezaraugusto/github-template-guidelines.git MY-PROJECT-NAME && cd MY-PROJECT-NAME``

# Getting Started

This project is a collection of [boilerplate](http://whatis.techtarget.com/definition/boilerplate) (template) files with resumed guidelines for `README`, `CONTRIBUTING` and `CONTRIBUTORS` documentation. It also includes a basic `ISSUE_TEMPLATE` and `PULL_REQUEST_TEMPLATE` which are now [allowed by GitHub](https://github.com/blog/2111-issue-and-pull-request-templates). All templates are filled under `.github/` folder. This `README` itself is a fork of the `README` [template](.github/README.md).

## Usage

1. After installing, remove this file `rm README.md`.
2. Move the `README` template file located under `.github/` to the main directory `mv .github/README.md .` :cool:
3. Follow the basic usage guidelines in each file or make it your way. *The world is yours*.

## Useful Resources :thumbsup:

> References for starting a Project

* [Helping people contribute to your Project](https://help.github.com/articles/helping-people-contribute-to-your-project/)
* [Am I Ready to Open Source it?](https://gist.github.com/PurpleBooth/6f1ba788bf70fb501439#file-am-i-ready-to-open-source-this-md)

> `README` References

* [How To Write A Readme](http://jfhbrook.github.io/2011/11/09/readmes.html)
* [How to Write a Great Readme](https://robots.thoughtbot.com/how-to-write-a-great-readme)
* [Eugene Yokota - StackOverflow Answer](http://stackoverflow.com/a/2304870)

> `CONTRIBUTING` References

* [Setting Guidelines for Repository Contributors](https://help.github.com/articles/setting-guidelines-for-repository-contributors/)
* [Contributor Covenant](http://contributor-covenant.org/)

> `CHANGELOG` References

> This boilerplate intentionally did not provide any `CHANGELOG` file as example, since [this tool](https://github.com/skywinder/github-changelog-generator) could make it automatically, fulfilling the file's objective. If you still want to keep it handwritten, to keep you (and your project) sane, I'd recommend you to follow the references below:

* [Semantic Versioning 2.0.0](http://semver.org/)
* [Keep a Changelog](http://keepachangelog.com/)

> `ISSUE_TEMPLATE` and `PULL_REQUEST_TEMPLATE` References

* [Creating an Issue Template for your repository](https://help.github.com/articles/creating-an-issue-template-for-your-repository/)
* [Creating a Pull Request Template for your repository](https://help.github.com/articles/creating-a-pull-request-template-for-your-repository/)
* [Awesome GitHub Templates](https://github.com/devspace/awesome-github-templates)

> `CONTRIBUTORS` References

* [All Contributors](https://github.com/kentcdodds/all-contributors/)
* [All Contributors (CLI)](https://github.com/jfmengels/all-contributors-cli)

## Contributors

<!-- Contributors START
Cezar_Augusto cezaraugusto http://cezaraugusto.net doc example prReview
Nathalia_Bruno nathaliabruno http://nathaliabruno.com doc prReview
Billie_Thompson PurpleBooth http://purplebooth.co.uk example
Contributors END -->

<!-- Contributors table START -->
| [![Cezar Augusto](https://avatars.githubusercontent.com/cezaraugusto?s=100)<br /><sub>Cezar Augusto</sub>](http://cezaraugusto.net)<br />[📖](git@github.com:cezaraugusto/You-Dont-Know-JS/commits?author=cezaraugusto) 💡 👀 | [![Nathalia Bruno](https://avatars.githubusercontent.com/nathaliabruno?s=100)<br /><sub>Nathalia Bruno</sub>](http://nathaliabruno.com)<br />[📖](git@github.com:cezaraugusto/You-Dont-Know-JS/commits?author=nathaliabruno) 👀 | [![Billie Thompson](https://avatars.githubusercontent.com/PurpleBooth?s=100)<br /><sub>Billie Thompson</sub>](http://purplebooth.co.uk)<br />💡 |
| :---: | :---: | :---: |
<!-- Contributors table END -->

This project follows the [all-contributors](https://github.com/kentcdodds/all-contributors) specification.
Contributions of any kind welcome!

## License
[![CC0](https://i.creativecommons.org/p/zero/1.0/88x31.png)](https://creativecommons.org/publicdomain/zero/1.0/)

To the extent possible under law, [Cezar Augusto](http://cezaraugusto.net) has waived all copyright and related or neighboring rights to this work.













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
mv kubevirt-operator.yaml operator-kubevirt.yaml
kubectl create -f operator-kubevirt.yaml

wget https://github.com/kubevirt/kubevirt/releases/download/${KV_VERSION}/kubevirt-cr.yaml
mv kubevirt-cr.yaml cr-kubevirt.yaml
kubectl create -f cr-kubevirt.yaml
```

### Check status of operator creation
```
watch -d kubectl get all -n kubevirt
```
<img src="images/KV_status_image.JPG" width="600" height="300" align="center" />


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

wget https://github.com/kubevirt/containerized-data-importer/releases/download/v1.11.0/operator-cdi.yaml
mv operator-cdi.yaml operator-cdi.yaml
kubectl create -f operator-cdi.yaml

wget https://github.com/kubevirt/containerized-data-importer/releases/download/v1.11.0/cr-cdi.yaml
mv cr-cdi.yaml cr-cdi.yaml
kubectl create -f cr-cdi.yaml
```
<img src="images/CDI_status_image.JPG" width="600" height="300" align="center" />

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
<img src="images/watchk_1_status.JPG" width="600" height="150" align="center" />

> Check to make sure PVC claim is bound
```
kubectl get pvc
```
<img src="images/pvc_status.JPG" width="600" height="50" align="center" />

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
<img src="images/watchk_2_status.JPG" width="600" height="300" align="center" />

### Create nodeport service for SSH access
```
virtctl expose vmi vm1 --name=vm1-ssh --port=22 --type=NodePort
```

### Grab nodeport created and ssh into box
```
kubectl get all
fedora@<host machine ip> -p <service nodeport>
```
<img src="images/success.JPG" width="600" height="150" align="center" />
