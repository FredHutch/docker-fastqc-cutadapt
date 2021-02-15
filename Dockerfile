# Contains the fastgc and cutadapt libraries
FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq \
  && apt-get install -qq openjdk-8-jdk unzip cutadapt awscli jq python3-pip python3-dev wget pigz \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 --no-cache-dir install --upgrade pip \
  && rm -rf /var/lib/apt/lists/* \
  && python -m pip install --upgrade awscli

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN cd /root
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -f -p /root/miniconda
RUN rm Miniconda3-latest-Linux-x86_64.sh
RUN /root/miniconda/bin/conda install -c bioconda fastqc
ENV PATH="/root/miniconda/bin:${PATH}"

RUN cutadapt --version
RUN fastqc --version
RUN aws --version
