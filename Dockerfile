FROM zabbix/zabbix-server-pgsql:ubuntu-7.0.11

USER root

RUN export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get -y install iputils-ping fping dnsutils telnet netcat-traditional && \
#  apt-get -y install netcat && \
  cd /usr/sbin; ln -s /usr/bin/fping && \
  chown root:zabbix /usr/bin/fping && \
  chmod u+s /usr/bin/fping && \
  apt-get clean all && \
  unset DEBIAN_FRONTEND

USER zabbix

RUN echo 'alias nocomments="sed -e :a -re '"'"'s/<\!--.*?-->//g;/<\!--/N;//ba'"'"' | sed -e :a -re '"'"'s/\/\*.*?\*\///g;/\/\*/N;//ba'"'"' | grep -v -P '"'"'^\s*(#|;|--|//|$)'"'"'"' >> ~/.bashrc

WORKDIR /etc/zabbix
