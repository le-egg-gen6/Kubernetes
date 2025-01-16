#Install kubectl for centralized node management
curl -LO https://dl.k8s.io/release/v1.20.7/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client

#Configure kubectl connect to k8s cluster
mkdir -p $HOME/.kube
scp vm-master1:~/.kube/config  $HOME/.kube/
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#Change config to connect to k8s cluster in .kube/config
#From 127.0.0.1 to 192.168.217.1(1,2,3) (master node)

#Install helm
cd ~
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
sudo chmod 700 get_helm.sh
./get_helm.sh

#Install NFS Storage
cd ~
mkdir nfs-storage
cd nfs-storage

helm repo add stable https://charts.helm.sh/stable
helm search repo nfs-client-provisioner
helm pull stable/nfs-client-provisioner --version 1.2.11
tar -xzf nfs-client-provisioner-1.2.11.tgz

cp nfs-client-provisioner/values.yaml nfs-delete-config.yaml
cp nfs-client-provisioner/values.yaml nfs-retain-config.yaml

kubectl create namespace "storage"

#change config of nfs-retain-config.yaml & nfs-delete-config.yaml
helm install nfs-storage-retain --namespace storage -f nfs-retain-config.yaml nfs-client-provisioner
helm install nfs-storage-delete --namespace storage -f nfs-delete-config.yaml nfs-client-provisioner