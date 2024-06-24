# 查看DaemonSet的历史版本
kubectl -n kube-system rollout history daemonset fluentd

# 查看特定版本的详细信息
kubectl -n kube-system rollout history daemonset fluentd --revision=1

# 将DaemonSet回滚到上一个版本
kubectl -n kube-system rollout undo daemonset fluentd

# 指定需要回滚到的版本号
kubectl -n kube-system rollout undo daemonset fluentd --to-revision=2

# 将执行命令设置到CHANGE-CAUSE字段中
kubectl create -f fluentd-ds.yaml --record=true
