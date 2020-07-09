kubeadm config images list > /root/kubeadm-config-images-list

#获取 pause,etcd,coredns的版本
PauseVersion=`grep 'pause' /root/kubeadm-config-images-list |awk -F: '{print $2}'`
EtcdVersion=`grep 'etcd' /root/kubeadm-config-images-list |awk -F: '{print $2}'`
CorednsVersion=`grep 'coredns' /root/kubeadm-config-images-list |awk -F: '{print $2}'`

images=(
    kube-apiserver:${vK8sVersion}
    kube-controller-manager:${vK8sVersion}
    kube-scheduler:${vK8sVersion}
    kube-proxy:${vK8sVersion}
    pause:${PauseVersion}
    etcd:${EtcdVersion}
    coredns:${CorednsVersion}
)
for imageName in ${images[@]};
do
    docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/${imageName}
    docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/${imageName} k8s.gcr.io/${imageName}
done

docker image ls
