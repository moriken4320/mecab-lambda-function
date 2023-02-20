FROM public.ecr.aws/sam/build-python3.8

RUN yum update -y \
    && yum install \
    zip

RUN mkdir /home/layers

RUN mkdir /home/python
