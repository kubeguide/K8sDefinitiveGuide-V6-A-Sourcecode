# completions=4来表示需要完成4个任务
apiVersion: batch/v1
kind: Job
metadata:
  name: job-sleep5
spec:
  completions: 4
  backoffLimit: 4
  template:
    spec:
      containers:
      - name: hello
        image: busybox
        imagePullPolicy: IfNotPresent
        command: ["sh", "-c", "echo hello && sleep 10"]
      restartPolicy: Never



# 设置suspend=true来挂起Job
kubectl patch job/job-sleep5 --type=strategic --patch '{"spec":{"suspend":true}}'


# 恢复Job的运行状态
kubectl patch job/job-sleep5 --type=strategic --patch '{"spec":{"suspend":false}}'
