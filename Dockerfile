FROM arm32v7/ubuntu

RUN mkdir -p /config /var/www/olivetin/;

RUN apt-get update && \
    apt-get install -y openssh-client curl

EXPOSE 1337/tcp 

VOLUME /config
VOLUME /root/.ssh/

RUN curl -L -o /tmp/olivetin-arm.tar.gz https://github.com/jamesread/OliveTin/releases/download/2021-05-28/OliveTin-2021-05-28-linux-arm.tar.gz   && \
    mkdir /tmp/OliveTin && tar -zxvf /tmp/olivetin-arm.tar.gz -C /tmp/OliveTin --strip-components=1                                               && \
    mv /tmp/OliveTin/OliveTin /usr/bin/OliveTin                                                                                                   && \
    chmod +x /usr/bin/OliveTin                                                                                                                    && \
    mv /tmp/OliveTin/webui/* /var/www/olivetin/

ENTRYPOINT [ "/usr/bin/OliveTin" ]
