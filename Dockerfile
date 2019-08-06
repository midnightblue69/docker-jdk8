FROM ubuntu:18.04

LABEL maintainer="lastjedi" \
      Version="0.2" \
      Description="Ubuntu 18.04 + JDK 8"
	  
# Never ask for confirmations
ENV DEBIAN_FRONTEND noninteractive 

RUN echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
    echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections
	
# Update packages 
RUN apt-get -y update && \
    apt-get -y --no-install-recommends install wget ca-certificates && \
    rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/local/openjdk-8
ENV JDK_TAR OpenJDK8U-jdk_x64_linux_hotspot_8u222b10.tar.gz
ENV JDK_URL https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u222-b10/${JDK_TAR} 

RUN mkdir -p "$JAVA_HOME" && cd ${JAVA_HOME} && \
    wget -q ${JDK_URL} --show-progress && \
    sha256sum ${JDK_TAR} && \
    wget -O- -q -T 1 -t 1 ${JDK_URL}.sha256.txt | sha256sum -c  &&  \
    tar -xf ${JDK_TAR} --directory "$JAVA_HOME" --no-same-owner --strip-components 1 && rm ${JDK_TAR}

ENV PATH=${JAVA_HOME}/bin:$PATH

RUN java -version
