#Install Rancher to monitoring k8s cluster 
docker run --name rancher-server -d --restart=unless-stopped -p 6860:80 -p 6868:443 --privileged rancher/rancher:v2.7.6
