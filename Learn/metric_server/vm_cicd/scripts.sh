cd ~
mkdir metric-server
cd metric-server

helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm search repo metrics-server
helm pull metrics-server/metrics-server --version 3.8.2
tar -xzf metrics-server-3.8.2.tgz
helm install metric-server metrics-server -n kube-system

#Edit configuration metric server
kubectl -n kube-system edit deploy metric-server-metrics-server
# Add container params allow insucured requests
# --kubelet-insecure-tls=true