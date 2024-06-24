# 暂停Deployment的更新操作
kubectl rollout pause deployment/nginx-deployment

# 更新容器的资源限制配置
kubectl set resources deployment nginx-deployment -c=nginx --limits=cpu=200m,memory=512Mi

# 恢复这个Deployment的部署操作
kubectl rollout resume deploy nginx-deployment
