# FROM ethereum/client-go:latest

# RUN apk add --update git bash python3 musl-dev gcc python3-dev py3-netifaces nodejs nodejs-npm nano
# RUN npm install -g truffle
# RUN npm install random-bytes --save
# RUN pip3 install web3 websocket-client pyyaml

FROM debian:stable-slim as builder

ENV GOREL go1.7.3.linux-amd64.tar.gz
ENV PATH $PATH:/usr/local/go/bin

RUN apt-get update &&  apt-get install -y
RUN apt-get update && apt-get install -y software-properties-common unzip wget git make gcc libsodium-dev build-essential libdb-dev zlib1g-dev libtinfo-dev sysvbanner wrk psmisc
#RUN add-apt-repository -y ppa:ethereum/ethereum &&  apt-get update && apt-get install -y solc
#RUN wget -q https://github.com/jpmorganchase/constellation/releases/download/v0.0.1-alpha/ubuntu1604.zip && unzip ubuntu1604.zip

#RUN cp ubuntu1604/constellation-node /usr/local/bin && chmod 0755 /usr/local/bin/constellation-node
#RUN cp ubuntu1604/constellation-enclave-keygen /usr/local/bin && chmod 0755 /usr/local/bin/constellation-enclave-keygen

RUN wget -q https://storage.googleapis.com/golang/${GOREL} && tar -xvzf ${GOREL} && mv go /usr/local/go && rm ${GOREL}
RUN git clone https://github.com/jpmorganchase/quorum.git
RUN cd quorum >/dev/null && git checkout tags/v1.1.0 && make all && cp build/bin/geth /usr/local/bin/ && cp build/bin/bootnode /usr/local/bin/bootnode

#COPY entrypoint.sh entrypoint.sh
#RUN chmod +x entrypoint.sh && chown quorum entrypoint.sh && chown -R quorum /home/quorum
#USER quorum
#VOLUME ["/home/quorum/config"]
#EXPOSE 8545
#EXPOSE 46656

#FROM alpine
#FROM node:slim

FROM debian:stable-slim

RUN apt-get -qq update -y
RUN apt-get upgrade -y
RUN apt-get update -qq && apt-get install -qq -y git bash python3 musl-dev gcc python3-dev python3-pip dnsutils nano curl
# RUN apk add --update git bash python3 musl-dev gcc python3-dev py3-netifaces nodejs nodejs-npm nano
RUN pip3 install web3 websocket-client pyyaml

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs

COPY --from=builder /usr/local/bin /usr/local/bin
COPY --from=builder /usr/local/bin/ /root/files/

COPY .ethash /root/.ethash
COPY files /root/files
RUN cd root/files && npm install
RUN chmod +x /root/files/start_eth_node.sh
RUN chmod +x /root/files/start_bootstrap.sh
RUN chmod +rwx /root/files/start_eth_contract_deployer.sh

RUN chmod 777 /root/files/geth

# ENTRYPOINT ["/home/quorum/entrypoint.sh"]
