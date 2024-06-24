# 为Deployment设置新的镜像名称
kubectl set image deployment/nginx-deployment nginx=nginx:1.9.1

kubectl edit deployment/nginx-deployment

# 查看Deployment的更新过程
kubectl rollout status deployment/nginx-deployment

# 查看Deployment nginx-deployment的详细事件信息
kubectl describe deployments/nginx-deployment
