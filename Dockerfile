FROM ubuntu:16.04

RUN apt-get update \
## Install base environment
    && apt-get install -y wget postgresql postgresql-contrib

## Nodejs
# Prepare
WORKDIR /opt/
# Download
RUN wget https://nodejs.org/dist/v6.11.1/node-v6.11.1-linux-x64.tar.xz \
# Unpack
    && tar xf node-v6.11.1-linux-x64.tar.xz \
    && rm node-v6.11.1-linux-x64.tar.xz \
    && mv node-v6.11.1-linux-x64 node
# Install
WORKDIR /opt/node
RUN mv bin/* /usr/bin/ \
    && mv include/* /usr/include/ \
    && mv lib/* /usr/lib/ \
    && mv share/doc/* /usr/share/doc/ \
    && mv share/man/man1/* /usr/share/man/man1/ \
    && mv share/systemtap/* /usr/share/systemtap/



## RasaUI
# Installation
ADD . /opt/rasaui
WORKDIR /opt/rasaui

# Install server packages
RUN npm install \
# Setup user
    && useradd rasaui \
    && chown rasaui -R .

# Setup RasaUI configuration
ENV rasanluendpoint=http://localhost:5000
ENV rasacoreendpoint=http://localhost:5005

EXPOSE 5001

ENTRYPOINT bash -c 'hostname -I; rasaui -c "npm start"'
