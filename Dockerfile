FROM oraclelinux:8.4
# base image for python app 
# docker image will be pulled from docker HUb 
LABEL name=ashutoshh
LABEL email=ashutoshh@linux.com
# label is like image designer info optional field
RUN  yum  install python3 -y 
# to get shell during image build time 
# we use RUN instruction - here yum is a software installer in OL
RUN  mkdir  /mycode
# creating a directory 
COPY oracle.py  /mycode/oracle.py 
# copy data from Client to Docker engine machine during image build time
# location of file must be same as Dockerfile location
CMD  ["python3","/mycode/oracle.py"]
# CMD is to define the default process of this image if not define by user
