#FROM centos:7
FROM almalinux:8
RUN mkdir -p /python_api
#WORKDIR /python_api
RUN yum install python3 python3-pip -y
COPY requirements.txt ./requirements.txt 
RUN pip3 install -r requirements.txt
COPY python-api.py ./python-api.py
CMD ["python3", "python-api.py"]