# training docker & kubernetes plan 


<img src="plan.png">

## Deploy javaweb in k8s 

<img src="javaweb.png">

## Info about tomcat web server 

<img src="tomcat.png">

### building docker image from github 

```
fire@ashutoshhs-MacBook-Air  ~  docker  build  -t  ashutomcat:webv1  https://github.com/redashu/javawebapp.git  
[+] Building 30.9s (3/8)                                                                                                        
 => [internal] load git source https://github.com/redashu/javawebapp.git                                                   1.4s
 => [internal] load metadata for docker.io/library/tomcat:latest                                                           4.0s 
 => [auth] library/tomcat:pull token for registry-1.docker.io                                                              0.0s 
 => [1/5] FROM docker.io/library/tomcat@sha256:0d985ff1e6cb81cdf3139336d95acb995621a5c79dfb4a705bc18e1e54134164           25.3s 
 => => resolve docker.io/library/tomcat@sha256:0d985ff1e6cb81cdf3139336d95acb995621a5c79dfb4a705bc18e1e54134164            0.0s 
 => => sha256:705bb4cb554eb7751fd21a994f6f32aee582fbe5ea43037db6c43d321763992b 5.15MB / 5.15MB                             8.6s
 => => sha256:0d985ff1e6cb81cdf3139336d95acb995621a5c79dfb4a705bc18e1e54134164 549B / 549B                                 0.0s
 => => sha256:ed3db1dbfce5598b4134a94ad2cc98d3481e827be3fbfaac617d769a9e53c22f 2.42kB / 2.42kB                             0.0s
 => => sha256:519df5fceacdeaadeec563397b1d9f4d7c29c9f6eff879739cab6f0c144f49e1 10.87MB / 10.87MB                          10.9s
 => => sha256:c662ee449a7e796f760eae7a6e9e45cad945ef08738910c9f058b3d63616bd09 12.85kB / 12.85kB                           0.0s
 => => sha256:df5590a8898bedd76f02205dc8caa5cc9863267dbcd8aac038bcd212688c1cc7 35.65MB / 54.93MB                          25.3s
 => => sha256:ccc287cbeddc96a0772397ca00ec85482a7b7f9a9fac643bfddd87b932f743db 19.92MB / 54.57MB                          25.3s
 => => sha256:39a2961e8351d92060fe0b7d3182dd4725fada0faa44b805531195caf32cb6cc 5.42MB / 5.42MB                            16.6s
 => => sha256:0287b7aa7f622adf289f6a1e45d59f58eedc65a4fd4a087fe0cad67d22da4382 211B / 211B                                17.9s
 => => sha256:165d4a436d89e57c90c317fc05e8112e56f6199c6732c9e1473359e8ba0e408d 6.29MB / 203.12MB                          25.3s

```

### testing app 

```
docker  run -itd  --name javaweb -p 1155:8080  df2c9abdb263
5ceab20709e697b12c2f053ae42a260110da4d73a9746fc2f68dba5a825f49b9
 fire@ashutoshhs-MacBook-Air  ~  docker  ps
CONTAINER ID   IMAGE          COMMAND             CREATED         STATUS         PORTS                                       NAMES
5ceab20709e6   df2c9abdb263   "catalina.sh run"   3 seconds ago   Up 2 seconds   0.0.0.0:1155->8080/tcp, :::1155->8080/tcp   javaweb


```

### checking it locally 

```
http://localhost:1155/oracle/
```

### pushing image to docker hub 

```
fire@ashutoshhs-MacBook-Air  ~  docker  tag  df2c9abdb263  dockerashu/tomcat:1stoct2021  
 fire@ashutoshhs-MacBook-Air  ~  
 fire@ashutoshhs-MacBook-Air  ~  
 fire@ashutoshhs-MacBook-Air  ~  docker login -u dockerashu
Password: 
Login Succeeded
 fire@ashutoshhs-MacBook-Air  ~  docker push  dockerashu/tomcat:1stoct2021
The push refers to repository [docker.io/dockerashu/tomcat]
29d11051a6f3: Pushing [==================================================>]   47.1kB
5f70bf18a086: Mounted from dockerashu/finalwebapp 
ea400e6407ed: Pushing  4.608kB
c87d045f4cdf: Mounted from library/tomcat 
10891c98559b: Mounted from library/tomcat 
73819629b437: Waiting 


```

### pushing image OCR 

### tagging 

```
docker  tag   df2c9abdb263  phx.ocir.io/axmbtg8judkl/tomcat:v1

```

### login 

```
fire@ashutoshhs-MacBook-Air  ~  docker login phx.ocir.io 
Username: axmbtg8judkl/learntechbyme@gmail.com
Password: 
Login Succeeded

```

### pushing 

```
docker push  phx.ocir.io/axmbtg8judkl/tomcat:v1 
The push refers to repository [phx.ocir.io/axmbtg8judkl/tomcat]
29d11051a6f3: Preparing 
5f70bf18a086: Preparing 

```

### namespace logic in k8s

<img src="ns.png">

### checking namespaces 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  namespace
NAME              STATUS   AGE
default           Active   41h
kube-node-lease   Active   41h
kube-public       Active   41h
kube-system       Active   41h
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  pods
No resources found in default namespace.
 fire@ashutoshhs-Mac
 
```

### creating custom namespace 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  create  namespace ashu-space 
namespace/ashu-space created
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get ns
NAME              STATUS        AGE
ashu-space        Active        15s
default           Active        41h

```

### setting default namespace 

```
kubectl  config  set-context --current --namespace=ashu-space
Context "kubernetes-admin@kubernetes" modified.
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  po                                             
No resources found in ashu-space namespace.

```

### creating pod of tomcat 

```
 kubectl run  tomcatpod  --image=dockerashu/tomcat:1stoct2021  --port 8080  --dry-run=client -o yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: tomcatpod
  name: tomcatpod
spec:
  containers:
  - image: dockerashu/tomcat:1stoct2021
    name: tomcatpod
    ports:
    - containerPort: 8080
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl run  tomcatpod  --image=dockerashu/tomcat:1stoct2021  --port 8080  --dry-run=client -o yaml  >tomcatwebapp.yaml
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  
 
 ```
 
 ### creating service nodeport yaml 
 
 ```
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  create service nodeport  ashusvc1     --tcp  1234:8080  --dry-run=client -o yaml 
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: ashusvc1
  name: ashusvc1
spec:
  ports:
  - name: 1234-8080
    port: 1234
    protocol: TCP
    targetPort: 8080
  selector:
    app: ashusvc1
  type: NodePort
status:
  loadBalancer: {}
  
```

### deploy yaml 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl apply -f  tomcatwebapp.yaml 
pod/tomcatpod created
service/ashusvc1 created
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl get  po
NAME        READY   STATUS    RESTARTS   AGE
tomcatpod   1/1     Running   0          7s
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl get  svc
NAME       TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
ashusvc1   NodePort   10.107.106.204   <none>        1234:32213/TCP   10s

```

### to pull private secure docker image we need to create secret in k8s

### secrets

<img src="secret.png">

### creating secret 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  create  secret 
Create a secret using specified subcommand.

Available Commands:
  docker-registry Create a secret for use with a Docker registry
  generic         Create a secret from a local file, directory or literal value
  tls             Create a TLS secret
  
  
  
====

kubectl  create  secret  docker-registry  ashusec111  --docker-server=phx.ocir.io  --docker-username=axmbt    --docker-password='1fVX#AYq<ZvYjN0'

```

### deploying 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl replace -f tomcatwebapp.yaml --force
pod "tomcatpod" deleted
service "ashusvc1" deleted
pod/tomcatpod replaced
service/ashusvc1 replaced
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  po
NAME        READY   STATUS    RESTARTS   AGE
tomcatpod   1/1     Running   0          8s
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  svc
NAME       TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
ashusvc1   NodePort   10.97.189.198   <none>        1234:31119/TCP   11s
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  secret
NAME                  TYPE                                  DATA   AGE
ashusec111            kubernetes.io/dockerconfigjson        1      6m8s
default-token-lkmrz   kubernetes.io/service-account-token   3      73m

```

### 

### task done 

```
4906  kubectl  create namespace ashuk8s1 --dry-run=client -o yaml 
 4907  kubectl  run  ashupod2 --image=ubuntu  --dry-run=client -o yaml 
 4908  docker pull ubuntu
 4909  docker run -it --rm  ubuntu sh 
 4910  kubectl  create service nodeport  ashutoshhsvc1 --tcp 1234:80  --dry-run=client -o yaml 
 4911  kubectl apply -f mytask.yaml
 4912  kubectl  get  ns
 4913  kubectl  get  all -n ashuk8s1 
 4914  ls
 4915  kubectl  cp logs.txt  ashupod2:/tmp/ -n ashuk8s1 
 4916  kubectl exec -it  ashupod2 -n ashuk8s1 -- bash 
 
 ```
 
 
 ### Introduction to new apiresource called  Deployment 
 
 <img src="dep.png">
 
 ### cleaning up 
 
 ```
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl delete all --all  -n ashuk8s1
pod "ashupod2" deleted
service "ashutoshhsvc1" deleted
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl delete ns  ashuk8s1 
namespace "ashuk8s1" deleted
                                                                                                 

```

### creating deployment 

```
kubectl  create  deployment  ashudep1 --image=dockerashu/oraclehttpd:29sep2021  --dry-run=client -o yaml  >ashudeploy.yaml

```

### template will be used by deployment to create pods

<img src="depp.png">

### 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl apply -f  ashudeploy.yaml 
deployment.apps/ashudep1 created
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl get deployments
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
ashudep1   1/1     1            1           8s
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl get deployment 
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
ashudep1   1/1     1            1           10s
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl get deploy    
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
ashudep1   1/1     1            1           13s
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  po 
NAME                        READY   STATUS    RESTARTS   AGE
ashudep1-5cc48f58d5-87j8m   1/1     Running   0          26s

```

### recreation check 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl delete po ashudep1-5cc48f58d5-87j8m
pod "ashudep1-5cc48f58d5-87j8m" deleted
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get po                            
NAME                        READY   STATUS    RESTARTS   AGE
ashudep1-5cc48f58d5-nhnxh   1/1     Running   0          4s

```

### to automatch selector or service to label of pod by deployment 
### create service in given way 

```
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get deploy
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
ashudep1   1/1     1            1           2m51s
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl expose deployment  ashudep1  --type NodePort  --port 80  --name ashusvc11122
service/ashusvc11122 exposed
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  svc
NAME           TYPE       CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
ashusvc11122   NodePort   10.102.169.138   <none>        80:31403/TCP   14s

```

### reality of deployment 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  deploy
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
ashudep1   2/2     2            2           7m57s
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  rs    
NAME                  DESIRED   CURRENT   READY   AGE
ashudep1-5cc48f58d5   2         2         2       8m3s
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  po
NAME                        READY   STATUS    RESTARTS   AGE
ashudep1-5cc48f58d5-f2th9   1/1     Running   0          77s
ashudep1-5cc48f58d5-nhnxh   1/1     Running   0          6m2s

```

### webapp to test deployment features in k8s

### creating webapp and svc

```
kubectl  create  deployment webapp --image=dockerashu/nginx:v009  --dry-run=client -o yaml   >webappp.yaml

kubectl  create  service nodeport  websvc --tcp 1235:80 --dry-run=client -o yaml

```

###

```
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  apply -f webappp.yaml 
deployment.apps/webapp created
service/websvc created
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get deploy
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
webapp   1/1     1            1           6s
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get svc   
NAME     TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
websvc   NodePort   10.111.252.63   <none>        1235:31053/TCP   9s

```

### External Loadbalancer

<img src="lb.png">

### pod scaling understanding 

<img src="scaling.png">

### manual horizontal scaling 

```
kubectl  scale deployment  webapp --replicas=3

```

### rolling updates 

<img src="rolling.png">

### updating image to upgrade application 

```
kubectl  set  image  deployment webapp  nginx=dockerashu/nginx:v0010
deployment.apps/webapp image updated

```

### rollback to previous version 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  rollout  undo deployment  webapp  
deployment.apps/webapp rolled back

```

### switching clusters 

```
fire@ashutoshhs-MacBook-Air  ~  kubectl  config get-contexts 
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
          kubernetes-admin@kubernetes   kubernetes   kubernetes-admin   ashu-space
*         minikube                      minikube     minikube           default
 fire@ashutoshhs-MacBook-Air  ~  kubectl  config   use-context   kubernetes-admin@kubernetes 
Switched to context "kubernetes-admin@kubernetes".
 fire@ashutoshhs-MacBook-Air  ~  
 fire@ashutoshhs-MacBook-Air  ~  kubectl  get  nodes
NAME         STATUS   ROLES                  AGE   VERSION
masternode   Ready    control-plane,master   47h   v1.22.2
minion1      Ready    <none>                 47h   v1.22.2
minion2      Ready    <none>                 47h   v1.22.2
 fire@ashutoshhs-MacBook-Air  ~  kubectl  config   use-context  minikube                     
Switched to context "minikube".
 fire@ashutoshhs-MacBook-Air  ~  kubectl  get  nodes                    
NAME       STATUS   ROLES                  AGE   VERSION
minikube   Ready    control-plane,master   16d   v1.21.2

```

## k8s revision 

<img src="revv.png">

## HPA 

<img src="hpa.png">

### deploy metrics server in k8s

```
kubectl  apply -f https://raw.githubusercontent.com/redashu/k8s/hpa/hpa/components.yaml
serviceaccount/metrics-server created
clusterrole.rbac.authorization.k8s.io/system:aggregated-metrics-reader created
clusterrole.rbac.authorization.k8s.io/system:metrics-server created
rolebinding.rbac.authorization.k8s.io/metrics-server-auth-reader created
clusterrolebinding.rbac.authorization.k8s.io/metrics-server:system:auth-delegator created
clusterrolebinding.rbac.authorization.k8s.io/system:metrics-server created
service/metrics-server created
deployment.apps/metrics-server created
apiservice.apiregistration.k8s.io/v1beta1.metrics.k8s.io created

```

### auto scaling rule 

```
fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  autoscale deploy  webapp --min=1  --max=50  --cpu-percent=80
horizontalpodautoscaler.autoscaling/webapp autoscaled
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  
 fire@ashutoshhs-MacBook-Air  ~/Desktop/k8sapps  kubectl  get  hpa
NAME     REFERENCE           TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
webapp   Deployment/webapp   <unknown>/80%   1         50        0          6s

```

### k8s dashboard 

[URL](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/)

###

```
 fire@ashutoshhs-MacBook-Air  ~  kubectl  get deploy -n kubernetes-dashboard
NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
dashboard-metrics-scraper   1/1     1            1           41s
kubernetes-dashboard        1/1     1            1           43s
 fire@ashutoshhs-MacBook-Air  ~  kubectl  get po  -n kubernetes-dashboard
NAME                                         READY   STATUS    RESTARTS   AGE
dashboard-metrics-scraper-856586f554-6whqc   1/1     Running   0          60s
kubernetes-dashboard-67484c44f6-kwfqz        1/1     Running   0          62s
 fire@ashutoshhs-MacBook-Air  ~  kubectl  get svc -n kubernetes-dashboard
NAME                        TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
dashboard-metrics-scraper   ClusterIP   10.99.183.129    <none>        8000/TCP   69s
kubernetes-dashboard        ClusterIP   10.110.177.206   <none>        443/TCP    76s
 fire@ashutoshhs-MacBook-Air  ~  kubectl  edit  svc kubernetes-dashboard   -n kubernetes-dashboard
service/kubernetes-dashboard edited
 fire@ashutoshhs-MacBook-Air  ~  kubectl  get svc -n kubernetes-dashboard                         
NAME                        TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)         AGE
dashboard-metrics-scraper   ClusterIP   10.99.183.129    <none>        8000/TCP        107s
kubernetes-dashboard        NodePort    10.110.177.206   <none>        443:32373/TCP   114s

```

### dashboard token 

```
kubectl  get secret -n kubernetes-dashboard
NAME                               TYPE                                  DATA   AGE
default-token-8hbjc                kubernetes.io/service-account-token   3      4m15s
kubernetes-dashboard-certs         Opaque                                0      4m12s
kubernetes-dashboard-csrf          Opaque                                1      4m12s
kubernetes-dashboard-key-holder    Opaque                                2      4m11s
kubernetes-dashboard-token-wb6xs   kubernetes.io/service-account-token   3      4m14s
 fire@ashutoshhs-MacBook-Air  ~  kubectl  describe  secret kubernetes-dashboard-token-wb6xs   -n kubernetes-dashboard
Name:         kubernetes-dashboard-token-wb6xs
Namespace:    kubernetes-dashboard
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: kubernetes-dashboard
              kubernetes.io/service-account.uid: 5c95938f-650e-40cf-90e4-b68de795e277

Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     1099 bytes
namespace:  20 bytes
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6ImFmMVRLc1o0NFByb1JXVFc0UGJHMG1OSkt1WGlQaU96MkpFZWRselB5WGsifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJrdWJlcm5ldGVzLWRhc2hib2FyZC10b2tlbi13YjZ4cyIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6IjVjOTU5MzhmLTY1MGUtNDBjZi05MGU0LWI2OGRlNzk1ZTI3NyIsInN1Y

```

### setting permission 

```
kubectl create clusterrolebinding dashboard-admin-sa1   --clusterrole=cluster-admin   --serviceaccount=kubernetes-dashboard:kubernetes-dashboard

```


