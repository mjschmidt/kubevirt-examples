mv ~/CentOS-7-x86_64-GenericCloud-1907.qcow2   /home/mjschm3/centos7/docker/
docker build -t mjschmidt/centos:7-x86_64-genericcloud-1907-2 .
mv /home/mjschm3/centos7/docker/CentOS-7-x86_64-GenericCloud-1907.qcow2 ~/
