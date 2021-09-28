# training docker & kubernetes plan 


<img src="plan.png">

## day1 revision 

<img src="rev.png">

## quick revision of toc

<img src="rev1.png">


### building dockerfile  based image 

```
[ashu@ip-172-31-81-194 pythonapp]$ ls
Dockerfile  oracle.py  python.dockerfile
[ashu@ip-172-31-81-194 pythonapp]$ docker  build  -t  ashupython:v2  -f python.dockerfile  . 
Sending build context to Docker daemon  4.608kB
Step 1/6 : FROM python
 ---> a5210955ee89
Step 2/6 : LABEL name=ashutoshh
 ---> Running in af164902965c
Removing intermediate container af164902965c
 ---> a69c0323c413
Step 3/6 : LABEL email=ashutoshh@linux.com
 ---> Running in 8381b7c8c00e
Removing intermediate container 8381b7c8c00e
 ---> 1fbe05de1107
Step 4/6 : RUN  mkdir  /mycode
 ---> Running in 2f22064fd0e2
Removing intermediate container 2f22064fd0e2
 ---> 9c15b31fd8c4
Step 5/6 : COPY oracle.py  /mycode/oracle.py
 ---> f3c1467f4aae
Step 6/6 : CMD  ["python","/mycode/oracle.py"]
 ---> Running in 3fef07533e48
Removing intermediate container 3fef07533e48
 ---> dd2aa7a277d8
Successfully built dd2aa7a277d8
Successfully tagged ashupython:v2

```

###  building java image 

```
[ashu@ip-172-31-81-194 ashuimages]$ cd  javaapp/
[ashu@ip-172-31-81-194 javaapp]$ ls
Dockerfile  hello.java
[ashu@ip-172-31-81-194 javaapp]$ docker  build  -t  ashujava:v1  . 
Sending build context to Docker daemon  3.072kB
Step 1/7 : FROM openjdk
 ---> ff693b5bd1bb
Step 2/7 : LABEL email=ashutoshh@linux.com
 ---> Running in b0bc8d62164d
Removing intermediate container b0bc8d62164d
 ---> df7a12bd0f3e
Step 3/7 : RUN mkdir  /code
 ---> Running in 6946dd324cfb
Removing intermediate container 6946dd324cfb
 ---> e6503795fb99
Step 4/7 : ADD  hello.java  /code/hello.java
 ---> 083f1286fb1d
Step 5/7 : WORKDIR /code
 ---> Running in 18aa8393ec24
Removing intermediate container 18aa8393ec24
 ---> c1bb14be0de9
Step 6/7 : RUN  javac hello.java
 ---> Running in cd4825e22643
Removing intermediate container cd4825e22643
 ---> 10453e65fd2e
Step 7/7 : CMD ["java","myclass"]
 ---> Running in f19f677fe6af
Removing intermediate container f19f677fe6af
 ---> e533a6b006f9
Successfully built e533a6b006f9
Successfully tagged ashujava:v1

```

### creating container 

```
[ashu@ip-172-31-81-194 ashuimages]$ docker  run -it -d --name ashujc1 e533a6b006f9  
21758a46b82dc0bc124bf202ef477758a2c11f3cab98b72299d9d1e61552aad2
[ashu@ip-172-31-81-194 ashuimages]$ docker  ps
CONTAINER ID   IMAGE            COMMAND            CREATED          STATUS          PORTS     NAMES
21758a46b82d   e533a6b006f9     "java myclass"     4 seconds ago    Up 2 seconds              ashujc1
d7fff65e4cca   manjupython:v3   "ping localhost"   14 minutes ago   Up 14 minutes             manjuc4
[ashu@ip-172-31-81-194 ashuimages]$ docker  logs -f  ashujc1 


```

### kill all the running containers

```
[ashu@ip-172-31-81-194 ashuimages]$ docker kill   $(docker  ps  -q)
83e4066daee8
fa5e26da8367
f4a0a9217edf
f6e24b2e0ef5
21758a46b82d
d7fff65e4cca
[ashu@ip-172-31-81-194 ashuimages]$ docker  ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES

```

### to remove all non running containers

```
[ashu@ip-172-31-81-194 ashuimages]$ docker  rm  $(docker  ps -a  -q)
f465ee98f14e
83e4066daee8
```

## Image sharing 

<img src="regis.png">

### docker hub image name reality 

<img src="imgname.png">

## remove image from docker engine 

```
[ashu@ip-172-31-81-194 ashuimages]$ docker  rmi  alpine
Untagged: alpine:latest
Untagged: alpine@sha256:e1c082e3d3c45cccac829840a25941e679c25d438cc8412c2fa221cf1a824e6a

```

## Pushing image to docker hub 

### tagging 

```
[ashu@ip-172-31-81-194 ashuimages]$ docker  tag  790a07433486  dockerashu/oraclepython:v1 
```

### login to docker hub

```
[ashu@ip-172-31-81-194 ashuimages]$ docker  login  -u  dockerashu 
Password: 
WARNING! Your password will be stored unencrypted in /home/ashu/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded

```

### pushing 

```
[ashu@ip-172-31-81-194 ashuimages]$ docker  push dockerashu/oraclepython:v1
The push refers to repository [docker.io/dockerashu/oraclepython]
3673ba613c8e: Pushed 
7f7f462a944b: Pushed 
4412995ff4d8: Pushed 
e2eb06d8af82: Mounted from library/alpine 
v1: digest: sha256:e5e4492124c337ca1bdc88e02817865dbf361936bee12e26e413e3853a12f097 size: 1154

```

### logout docker hub from terminal 

```
[ashu@ip-172-31-81-194 ashuimages]$ docker  logout 
Removing login credentials for https://index.docker.io/v1/

```

### checking image build history 

```
[ashu@ip-172-31-81-194 ashuimages]$ docker  history  790a07433486 
IMAGE          CREATED       CREATED BY                                      SIZE      COMMENT
790a07433486   2 hours ago   /bin/sh -c #(nop)  CMD ["python3" "/mycode/o…   0B        
92450f2d864a   2 hours ago   /bin/sh -c #(nop) COPY file:6e29d47c004b1169…   231B      
52b7ec80e4e4   2 hours ago   /bin/sh -c mkdir  /mycode                       0B        
9c39eab9f353   2 hours ago   /bin/sh -c apk  add python3                     48.3MB    
137c5896571a   2 hours ago   /bin/sh -c #(nop)  LABEL email=ashutoshh@lin…   0B        
556d0839c01a   2 hours ago   /bin/sh -c #(nop)  LABEL name=ashutoshh         0B        
14119a10abf4   4 weeks ago   /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B        
<missing>      4 weeks ago   /bin/sh -c #(nop) ADD file:aad4290d27580cc1a…   5.6MB 

```

### remove image docker engine 

```
 177  docker  rmi  $(docker  images -q) 
  178  docker  rmi  $(docker  images -q)  -f
  
```


