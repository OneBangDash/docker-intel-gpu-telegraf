FROM alpine:latest

LABEL maintainer=onebangdash@gmail.com

WORKDIR ./opt/intel-gpu-telegraf
RUN echo "@testing https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk add --no-cache curl gpg telegraf igt-gpu-tools@testing net-tools vim

RUN rm -rf /var/cache/*

COPY ./opt/intel-gpu-telegraf /opt/intel-gpu-telegraf

CMD ["/usr/bin/telegraf", "--config", "/opt/intel-gpu-telegraf/telegraf.conf"]
