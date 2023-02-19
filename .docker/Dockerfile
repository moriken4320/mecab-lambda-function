FROM amazonlinux:2

RUN yum -y update && \
    yum -y install git make automake gcc gcc-c++ libstdc++-static which wget tar zip

# Install MeCab
RUN cd /tmp \
        && wget "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7cENtOXlicTFaRUE" -O mecab-0.996.tar.gz \
        && tar zxfv mecab-0.996.tar.gz \
        && cd mecab-0.996 \
        && ./configure --with-charset=utf8 \
        && make \
        && make install

# Install Ipadic
RUN cd /tmp \
        && wget "https://drive.google.com/uc?export=download&id=0B4y35FiV1wh7MWVlSDBCSXZMTXM" -O mecab-ipadic-2.7.0-20070801.tar.gz \
        && tar zxfv mecab-ipadic-2.7.0-20070801.tar.gz \
        && cd mecab-ipadic-2.7.0-20070801 \
        && ./configure --with-charset=utf8 \
        && make \
        && make install
