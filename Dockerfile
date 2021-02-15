# Contains the fastgc and cutadapt libraries
FROM ubuntu:18.04

RUN apt-get update -qq \
  && apt-get install -qq openjdk-7-jre-headless unzip python3-cutadapt awscli jq python3-pip python3-dev \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 --no-cache-dir install --upgrade pip \
  && rm -rf /var/lib/apt/lists/* \
  && python -m pip install --upgrade awscli

ENV FASTQC_VERSION 0.11.5

RUN mkdir -p /opt/tools
WORKDIR /opt/tools

# install fastqc
RUN \
  wget -c http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v${FASTQC_VERSION}.zip && \
  unzip fastqc_v${FASTQC_VERSION}.zip && \
  cd FastQC && \
  chmod +x fastqc && \
  cp fastqc /usr/local/bin
