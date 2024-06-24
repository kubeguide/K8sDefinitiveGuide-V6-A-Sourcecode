# 检查部署这个Deployment的历史记录
kubectl rollout history deployment/nginx-deployment

# 查看特定版本的详细信息
kubectl rollout history deployment/nginx-deployment --revision=3

# 撤销本次发布并回滚到上一个部署版本
kubectl rollout undo deployment/nginx-deployment

# 指定回滚到的部署版本号
kubectl rollout undo deployment/nginx-deployment --to-revision=2
