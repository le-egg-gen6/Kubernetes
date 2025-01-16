#Fix issue on all master node
sudo -i
vim /etc/kubernetes/manifests/kube-apiserver.yaml
# Add config --feature-gates=RemoveSelfLink=false