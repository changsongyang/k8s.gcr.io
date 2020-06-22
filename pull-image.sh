### cat pull-images.sh 
#!/bin/bash

#查看kubeadm安装，需要的镜像列表
kubeadm config images list

K8S-VERSION="v1.18.4"

images=(
    kube-apiserver:${K8S-VERSION}
    kube-controller-manager:${K8S-VERSION}
    kube-scheduler:${K8S-VERSION}
    kube-proxy:${K8S-VERSION}
    pause:3.2
    etcd:3.4.3-0
    coredns:1.6.7
)
for imageName in ${images[@]};
do
    docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/${imageName}
    docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/${imageName} k8s.gcr.io/${imageName}
    docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/${imageName}
done

docker image ls
