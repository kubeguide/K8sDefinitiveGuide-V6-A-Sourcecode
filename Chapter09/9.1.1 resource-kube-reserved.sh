# 修改kubelet的systemd服务描述文件配置
# cat /usr/lib/systemd/system/kubelet.service
[Unit]
Description=kubelet: The Kubernetes Node Agent
Documentation=https://kubernetes.io/docs/
Wants=network-online.target
After=network-online.target
[Service]
Slice=kubeonly.slice
ExecStart=/usr/bin/kubelet
Restart=always
StartLimitInterval=0
RestartSec=10
[Install]
WantedBy=multi-user.target

# 重启kubelet服务
systemctl daemon-reload
systemctl restart kubelet.service



# 修改kubelet配置文件，开启并设置kube-reserved预留资源的相关信息
---
kind: KubeletConfiguration
cgroupDriver: systemd
volumeStatsAggPeriod: 0s
enforceNodeAllocatable:
  - pods
  - kube-reserved
kubeReserved:
  cpu: 500m
  memory: 1Gi
  ephemeral-storage: 1Gi
kubeReservedCgroup: /kubeonly



# 配置system-reserved预留资源
# 修改kubelet配置文件中的相关内容
---
kind: KubeletConfiguration
cgroupDriver: systemd
volumeStatsAggPeriod: 0s
enforceNodeAllocatable:
  - pods
  - kube-reserved
  - system-reserved
kubeReserved:
  cpu: 500m
  memory: 1Gi
  ephemeral-storage: 1Gi
kubeReservedCgroup: /kubeonly
systemReserved:
  cpu: 500m
  memory: 1Gi
  ephemeral-storage: 1Gi
systemReservedCgroup: /system

# 重启kubelet服务
systemctl daemon-reload
systemctl restart kubelet.service




# 配置Pod驱逐的预留资源
---
kind: KubeletConfiguration
evictionSoft:
  memory.available: 300Mi
  nodefs.available: 1Gi
  imagefs.available: 1Gi
evictionSoftGracePeriod:
  memory.available: 1m30s
  nodefs.available: 2m
  imagefs.available: 2m
evictionHard:
  memory.available: 100Mi
  nodefs.available: 500Mi
  nodefs.inodesFree: 5%
  imagefs.available: 500Mi
evictionMinimumReclaim:
  memory.available: 0Mi
  nodefs.available: 100Mi
  imagefs.available: 200Mi
evictionMaxPodGracePeriod: 30
