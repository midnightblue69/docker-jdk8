FROM ubuntu:17.10

LABEL maintainer="lastjedi" \
      Version="0.1" \
      Description="Ubuntu 17.10 + JDK 8"
	  
# Never ask for confirmations
ENV DEBIAN_FRONTEND noninteractive 

RUN echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
    echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections
	
# Update packages 
RUN apt-get -y update && \
    apt-get -y --no-install-recommends install software-properties-common && \
    add-apt-repository ppa:webupd8team/java && \
    apt-get update && \
    apt-get -y --no-install-recommends install oracle-java8-installer && \
    rm -rf /var/lib/apt/lists/*

# Export JAVA_HOME variable 
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
