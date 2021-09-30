# training docker & kubernetes plan 


<img src="plan.png">

## till day3 revision 

<img src="rev.png">


### k8s master auth process
 
<img src="auth.png">

### checking client side software to connect k8s master 

```
kubectl  version --client 
Client Version: version.Info{Major:"1", Minor:"21", GitVersion:"v1.21.1", GitCommit:"5e58841cce77d4bc13713ad2b91fa0d961e69192", GitTreeState:"clean", BuildDate:"2021-05-12T14:18:45Z", GoVersion:"go1.16.4", Compiler:"gc", Platform:"darwin/amd64"}
```

### checking connection to master node 

```
 fire@ashutoshhs-MacBook-Air  ~/Desktop  kubectl  get  nodes  --kubeconfig admin.conf 
NAME         STATUS   ROLES                  AGE   VERSION
masternode   Ready    control-plane,master   17h   v1.22.2
minion1      Ready    <none>                 17h   v1.22.2
minion2      Ready    <none>                 17h   v1.22.2

```

### updating admin.conf to home directory of client users

<img src="home.png">

## k8s master node components 

### kube-apiserver 

<img src="apiserver.png">

### kube-schedular 

<img src="sch.png">

### the brain of k8s master is ETCD (Nosql db) key: value type

<img src="etcd.png">

## Intro to POD

<img src="pod.png">


### creating pod file instructions 

<img src="pod11.png">

### POD creation using yaml 

### checking syntax 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  ls
ashupod1.yaml
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  apply -f ashupod1.yaml  --dry-run
W0930 11:42:56.140800    4171 helpers.go:557] --dry-run is deprecated and can be replaced with --dry-run=client.
pod/ashupod-1 created (dry run)
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  apply -f ashupod1.yaml  --dry-run=client
pod/ashupod-1 created (dry run)

```


### deploying pod 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  apply -f ashupod1.yaml           
pod/ashupod-1 created
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  pods
NAME         READY   STATUS    RESTARTS   AGE
anshulpod    1/1     Running   0          24s
ashupod-1    1/1     Running   0          38s
manjupod-1   1/1     Running   0          33s
vinpod-1     1/1     Running   0          21s

```

### checking more details about pod 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  no   
NAME         STATUS   ROLES                  AGE   VERSION
masternode   Ready    control-plane,master   19h   v1.22.2
minion1      Ready    <none>                 19h   v1.22.2
minion2      Ready    <none>                 19h   v1.22.2
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  po  ashupod-1
NAME        READY   STATUS    RESTARTS   AGE
ashupod-1   1/1     Running   0          3m21s
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  po  ashupod-1  -o wide
NAME        READY   STATUS    RESTARTS   AGE     IP             NODE      NOMINATED NODE   READINESS GATES
ashupod-1   1/1     Running   0          3m27s   192.168.34.1   minion1   <none>           <none>

```

### checking all pods info 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  po    -o wide
NAME            READY   STATUS    RESTARTS   AGE     IP                NODE      NOMINATED NODE   READINESS GATES
anshulpod       1/1     Running   0          4m13s   192.168.34.3      minion1   <none>           <none>
arun-1          1/1     Running   0          2m45s   192.168.34.6      minion1   <none>           <none>
ashupod-1       1/1     Running   0          4m27s   192.168.34.1      minion1   <none>           <none>
ashutosh-pod1   1/1     Running   0          3m33s   192.168.179.200   minion2   <none>           <none>
kapil-1         1/1     Running   0          117s    192.168.179.202   minion2   <none>           <none>
mallikpod-1     1/1     Running   0          3m33s   192.168.34.5      minion1   <none>           <none>
manjupod-1      1/1     Running   0          4m22s   192.168.34.2      minion1   <none>           <none>
phanipod-1      1/1     Running   0          2m36s   192.168.179.201   minion2   <none>           <none>
preepod-1       1/1     Running   0          2m27s   192.168.34.7      minion1   <none>           <none>
pujithapod-1    1/1     Running   0          3m34s   192.168.34.4      minion1   <none>           <none>
sanjaypod-1     1/1     Running   0          109s    192.168.34.8      minion1   <none>           <none>
vinpod-1        1/1     Running   0          4m10s   192.168.179.199   minion2   <none>           <none>

```

### describe pod 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  describe  pod  ashupod-1
Name:         ashupod-1
Namespace:    default
Priority:     0
Node:         minion1/172.31.88.126
Start Time:   Thu, 30 Sep 2021 11:45:40 +0530
Labels:       <none>
Annotations:  cni.projectcalico.org/containerID: 51afca435d2be7d3b126cd9f83ee6e5c9ea5d71a02ea8148ef8dc9f74eadebf4
              cni.projectcalico.org/podIP: 192.168.34.1/32
              cni.projectcalico.org/podIPs: 192.168.34.1/32
Status:       Running
IP:           192.168.34.1
IPs:
  IP:  192.168.34.1
Containers:
  ashuc1:
    Container ID:  docker://41444ae95a499317a5f90f7bb4c2c2aa8174c1f16360765bc224431cd3e74f17
    Image:         alpine
    Image ID:      docker-pullable://alpine@sha256:e1c082e3d3c45cccac829840a25941e679c25d438cc8412c2fa221cf1a824e6a
    Port:          <none>
    
```

### checking output of container running inside pod 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  logs  ashupod-1  
PING localhost (127.0.0.1): 56 data bytes
64 bytes from 127.0.0.1: seq=0 ttl=255 time=0.039 ms
64 bytes from 127.0.0.1: seq=1 ttl=255 time=0.044 ms
64 bytes from 127.0.0.1: seq=2 ttl=255 time=0.059 ms
64 bytes from 127.0.0.1: seq=3 ttl=255 time=0.046 ms
64 bytes from 127.0.0.1: seq=4 ttl=255 time=0

```

### live output of pod 

```
kubectl  logs  -f  ashupod-1

```

### child process inside pod container 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  exec  -it  ashupod-1  -- sh 
/ # 
/ # 
/ # 
/ # date
Thu Sep 30 06:28:42 UTC 2021
/ # cal
   September 2021
Su Mo Tu We Th Fr Sa
          1  2  3  4
 5  6  7  8  9 10 11
12 13 14 15 16 17 18
19 20 21 22 23 24 25
26 27 28 29 30
                     
/ # whoami
root
/ # exit

```

