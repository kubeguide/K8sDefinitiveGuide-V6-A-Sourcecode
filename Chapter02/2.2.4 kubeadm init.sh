# 获取默认的初始化参数文件
kubeadm config print init-defaults > init-config.yaml

# 下载所需的镜像
kubeadm config images list
kubeadm config images pull --config=init-config.yaml




# 基于之前创建的配置文件一键安装Master
kubeadm init --config=init-config.yaml

# root用户通过环境变量KUBECONFIG设置配置文件，指定为由kubeadm创建的配置文件admin.conf全路径
export KUBECONFIG=/etc/kubernetes/admin.conf

# 普通用户（非root）可以将admin.conf配置文件复制到用户HOME目录的.kube子目录下，并设置正确的文件权限
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# 验证kubectl能够正确连接Master
kubectl -n kube-system get configmap
