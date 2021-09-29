# training docker & kubernetes plan 


<img src="plan.png">

## Docker Revision 

<img src="rev.png">

## httpd based webapplication contaienrization 

<img src="httpd.png">

## Systemd is not supported by Docker COntainer 

<img src="systemd.png">

## building docker image of httpd app server

```
ashu@ip-172-31-81-194 ashuimages]$ ls
cppapp  html-sample-app  javaapp  pythonapp
[ashu@ip-172-31-81-194 ashuimages]$ cd  html-sample-app/
[ashu@ip-172-31-81-194 html-sample-app]$ ls
assets      elements.html  html5up-phantom.zip  images      LICENSE.txt
Dockerfile  generic.html   httpd.dockerfile     index.html  README.txt
[ashu@ip-172-31-81-194 html-sample-app]$ docker  build  -t  dockerashu/oraclehttpd:29sep2021 -f httpd.dockerfile  . 
Sending build context to Docker daemon  2.099MB
Step 1/6 : FROM oraclelinux:8.4
 ---> fcf3cbfc22ac
Step 2/6 : LABEL  email=ashutoshh@linux.com
 ---> Running in 05be72a110ff
Removing intermediate container 05be72a110ff
 ---> bc502292a030
Step 3/6 : RUN  yum  install httpd -y
 ---> Running in a0fdf2add807
Oracle Linux 8 BaseOS Latest (x86_64)            58 MB/s |  36 MB     00:00    
Oracle Linux 8 Application Stream (x86_64)       77 MB/s |  27 MB     00:00    

```

### creating container 

```
[ashu@ip-172-31-81-194 html-sample-app]$ docker  run -d -p 5555:80  dockerashu/oraclehttpd:29sep2021
670a6fac7b1ebbfc4fee9ad2f41e2ba5990828b1ff0e3402adb7213a2ba73dec
[ashu@ip-172-31-81-194 html-sample-app]$ docker  ps
CONTAINER ID   IMAGE                              COMMAND                  CREATED         STATUS         PORTS                                   NAMES
670a6fac7b1e   dockerashu/oraclehttpd:29sep2021   "/bin/sh -c 'httpd -…"   3 seconds ago   Up 2 seconds   0.0.0.0:5555->80/tcp, :::5555->80/tcp   sad_albattani

```

### push 

```
266  docker login 
  267  docker  push  dockerashu/oraclehttpd:29sep2021
  268  docker logout 
  
```



