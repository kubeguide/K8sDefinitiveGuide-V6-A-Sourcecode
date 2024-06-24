# 安装kubeadm和kubelet
yum install kubelet kubeadm --disableexcludes=kubernetes

# 启动kubelet服务，并设置为开机自启动
systemctl enable --now kubelet

# 运行kubeadm join命令加入集群，“--token”和“--discovery-token-ca- cert-hash”的值需要从成功安装Master时的提示信息中复制
kubeadm join 192.168.18.10:6443 --token 2m54ly.s8g4lv2urk0dcuvi \
    --discovery-token-ca-cert-hash sha256:159400c88042d63dc7188db587c81efd1282d4bb16f00d316120ebcd278a333f




# 获取默认配置
kubeadm config print join-defaults > join.config.yaml

# 基于配置文件执行kubeadm join命令将本Node加入集群
kubeadm join --config=join.config.yaml




# 在Master上通过kubectl get nodes命令确认新的Node已加入集群
kubectl get nodes

# 将Master配置为Node
kubectl taint nodes --all node-role.kubernetes.io/master-
