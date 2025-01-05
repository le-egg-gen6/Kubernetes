#Gen SSH-Key Pair
ssh-keygen

ssh-copy-id vm_master1
ssh-copy-id vm_master2
ssh-copy-id vm_master3

ssh-copy-id vm_worker1
ssh-copy-id vm_worker2
ssh-copy-id vm_worker3

cd ~
mkdir k8s_installation
cd k8s_installation

git clone https://github.com/kubernetes-sigs/kubespray.git --branch release-2.26

cd ~/k8s_installation/kubespray
cp -rf inventory/sample inventory/vm-cluster

cd ~/k8s_installation/kubespray/inventory/vm-cluster
vi hosts.ini #edit hosts.yaml like file i provided in this repo

#Change network plugin configuration (not needed)
cd ~/k8s_installation/kubespray/inventory/vm-cluster/group_vars/k8s_cluster
vi k8s-cluster.yml #change kube_network_plugin: calico -> kube_network_plugin: flannel

#Install Docker
sudo apt-get update
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker lenn

#Create docker-container from kubespray image, install k8s_cluster inside this container
docker run --rm -it --mount type=bind,source=/home/lenn/k8s_installation/kubespray/inventory/vm-cluster,dst=/inventory \
  --mount type=bind,source=/home/lenn/.ssh/id_rsa,dst=/root/.ssh/id_rsa \
  --mount type=bind,source=/home/lenn/.ssh/id_rsa,dst=/home/lenn/.ssh/id_rsa \
  quay.io/kubespray/kubespray:v2.26.0 bash 

#Run ansible playbook for initialize k8s cluster (inside kubespray image))
ansible-playbook -i /inventory/hosts.ini cluster.yml --user=lenn --ask-pass --become --ask-become-pass

#root_username: lenn
#root_password: lenn
