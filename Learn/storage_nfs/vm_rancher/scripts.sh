sudo -i

apt install nfs-kernel-server nfs-common -y

mkdir -p /data2/delete
mkdir -p /data2/retain

chmod -R 755 /data2
chown -R nobody:nogroup /data2

systemctl enable rpcbind
systemctl enable nfs-server

systemctl start rpcbind
systemctl start nfs-server

systemctl restart nfs-server

#Add following line to /etc/exports
/data2/retain 192.168.217.0/24(rw,sync,no_root_squash,no_all_squash)
/data2/delete 192.168.217.0/24(rw,sync,no_root_squash,no_all_squash)

systemctl restart nfs-server