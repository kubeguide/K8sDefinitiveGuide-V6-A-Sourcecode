# 为不同租户配置不同的环境
# namespace-development.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: development

# namespace-production.yaml
apiVersion: v1
kind: Namespace
metadata:
  name: production



# 为两个租户分别定义一个运行环境（context），并关联到各自的命名空间
kubectl config set-context ctx-dev --namespace=development --cluster=kubernetes-cluster --user=dev

kubectl config set-context ctx-prod --namespace=production --cluster=kubernetes-cluster --user=prod


# 将当前运行环境设置为ctx-dev
kubectl config use-context ctx-dev





# 为租户创建用户连接API Server的客户端CA证书

# 1. 创建用户的私钥和证书
openssl genrsa -out dev.key 2048
openssl req -new -key dev.key -out dev.csr

# 2. 用Kubernetes的CA根证书进行签名
openssl x509 -req -in dev.csr -CA /etc/kubernetes/pki/ca.crt -CAkey /etc/kubernetes/pki/ca.key -CAcreateserial -out dev.crt -days 500

# 3. 在kubeconfig中设置dev用户证书信息
kubectl config set-credentials dev --client-certificate=/root/dev.crt --client-key=/root/dev.key

# 4. 确认dev用户证书信息已经设置完成
kubectl config view
users:
- name: dev
  user:
    client-certificate: /root/dev.crt
    client-key: /root/dev.key


# 给dev用户进行授权，先切换到管理员的context
kubectl config use-context kubernetes-admin@kubernetes

# 创建development租户的role，并绑定到用户dev上
# 1. 创建Role
# develement-role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: development
  name: development-role
rules:
- apiGroups: ["", "extensions", "apps"]
  resources: ["deployments","configmaps","secrets","deamonsets","statefulset","pods", "services","jobs"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]

kubectl create -f develement-role.yaml

# 2. 创建RoleBinging，给dev用户授权development-role的角色
# development-role-binding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: development-role-binding
  namespace: development
subjects:
- kind: User
  name: dev
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: development-role
  apiGroup: rbac.authorization.k8s.io

kubectl create -f development-role-binding.yaml

# 切换到ctx-dev环境，验证dev用户可以在其命名空间中管理资源
kubectl config use-context ctx-dev
kubectl get pods

