FROM amazonlinux:latest

RUN yum update -y \
    && yum install \
    python3 \
    zip \
    -y

RUN mkdir /home/layers

RUN mkdir /home/python
