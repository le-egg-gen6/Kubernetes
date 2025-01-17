cd  ~
mkdir nginx-ingress
cd nginx-ingress

helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update
helm search repo nginx
helm pull nginx-stable/nginx-ingress --version 0.13.0
tar -xzf nginx-ingress-0.13.0.tgz
cp nginx-ingress/values.yaml value-nginx-ingress.yaml

vim value-nginx-ingress.yaml
# type: NodePort
# nodePort: 30080
# nodePort: 30443

kubectl create ns nginx-ingress
helm -n nginx-ingress install nginx-ingress -f value-nginx-ingress.yaml nginx-ingress
