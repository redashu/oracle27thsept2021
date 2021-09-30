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



