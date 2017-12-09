FROM ubuntu
 
# install python packages
RUN apt-get update && apt-get -y install python python-dev python-pip
 
# install python libraries
RUN pip install mock-server tornado==4.2
 
# create directory
RUN mkdir api
 
EXPOSE 8888
 
CMD ["mock-server","--address=0.0.0.0","--dir=api"]
