kubectl apply -f app-v1-deployment.yaml
kubectl apply -f app-v2-deployment.yaml
kubectl apply -f haproxy-config.yaml -f haproxy-deployment.yaml
kubectl port-forward svc/haproxy 3000:80