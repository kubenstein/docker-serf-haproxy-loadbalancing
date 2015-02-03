FROM ubuntu

# Configure serf
RUN apt-get update
RUN apt-get install -y unzip wget
RUN wget --no-check-certificat https://dl.bintray.com/mitchellh/serf/0.5.0_linux_amd64.zip -O serf.zip
RUN unzip serf.zip
RUN chmod +x serf
RUN mv serf /usr/bin/serf

# Configure HAProxy
RUN apt-get -y install haproxy
ADD default_haproxy.cfg /etc/haproxy/haproxy.cfg
RUN sed -i -e 's/ENABLED=0/ENABLED=1/' /etc/default/haproxy

# Configure supervisor
RUN apt-get install -qy supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add files 
ADD serf-member-join.sh /serf-member-join.sh
ADD serf-member-leave.sh /serf-member-leave.sh
ADD serf-start.sh /serf-start.sh
ADD loadbalancer-start.sh /loadbalancer-start.sh
RUN chmod 755 /serf*.sh /loadbalancer-start.sh

EXPOSE 80 9999 7946 7373
CMD ["supervisord", "-n"]