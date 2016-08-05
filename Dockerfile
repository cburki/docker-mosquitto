FROM debian:jessie
MAINTAINER Christophe Burki, christophe.burki@gmail.com

# Install system requirements
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    wget && \
    apt-get autoremove -y && \
    apt-get clean

# Configure locales and timezone
RUN locale-gen en_US.UTF-8 en_GB.UTF-8 fr_CH.UTF-8 && \
    cp /usr/share/zoneinfo/Europe/Zurich /etc/localtime && \
    echo "Europe/Zurich" > /etc/timezone

# Install mosquitto
RUN wget -q -O /tmp/mosquitto-repo.gpg.key http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key && \
    apt-key add /tmp/mosquitto-repo.gpg.key && \
    wget -q -O /etc/apt/sources.list.d/mosquitto-jessie.list http://repo.mosquitto.org/debian/mosquitto-jessie.list && \
    apt-get update && apt-get install -y mosquitto

# s6 install and config
COPY bin/* /usr/bin/
COPY configs/etc/s6 /etc/s6/
RUN chmod a+x /usr/bin/s6-* && \
    chmod a+x /etc/s6/.s6-svscan/finish /etc/s6/mosquitto/run /etc/s6/mosquitto/finish

# install setup scripts and mosquitto configuration
COPY scripts/* /opt/
RUN chmod a+x /opt/setup.sh
COPY configs/mosquitto /opt/mosquitto/

# expose ports
EXPOSE 1883
EXPOSE 9883

CMD ["/usr/bin/s6-svscan", "/etc/s6"]
