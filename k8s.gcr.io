### cat pull-images.sh 
#!/bin/bash
images=(
    kube-apiserver:v1.18.0
    kube-controller-manager:v1.18.0
    kube-scheduler:v1.18.0
    kube-proxy:v1.18.0
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

### docker images
REPOSITORY                           TAG                 IMAGE ID            CREATED             SIZE
k8s.gcr.io/kube-proxy                v1.18.0             43940c34f24f        7 days ago          117MB
k8s.gcr.io/kube-apiserver            v1.18.0             74060cea7f70        7 days ago          173MB
k8s.gcr.io/kube-controller-manager   v1.18.0             d3e55153f52f        7 days ago          162MB
k8s.gcr.io/kube-scheduler            v1.18.0             a31f78c7c8ce        7 days ago          95.3MB
k8s.gcr.io/pause                     3.2                 80d28bedfe5d        6 weeks ago         683kB
k8s.gcr.io/coredns                   1.6.7               67da37a9a360        2 months ago        43.8MB
k8s.gcr.io/etcd                      3.4.3-0             303ce5db0e90        5 months ago        288MB

### cat save-images.sh 
#!/bin/bash
images=(
    kube-apiserver:v1.18.0
    kube-controller-manager:v1.18.0
    kube-scheduler:v1.18.0
    kube-proxy:v1.18.0
    pause:3.2
    etcd:3.4.3-0
    coredns:1.6.7
)
for imageName in ${images[@]};
do
    docker save -o `echo ${imageName}|awk -F ':' '{print $1}'`.tar k8s.gcr.io/${imageName}
done

### tar czvf kubeadm-images-1.18.0.tar.gz *.tar

### cat load-image.sh 
#!/bin/bash
ls /root/kubeadm-images-1.18.0 > /root/images-list.txt
cd /root/kubeadm-images-1.18.0
for i in $(cat /root/images-list.txt)
do
     docker load -i $i
done
