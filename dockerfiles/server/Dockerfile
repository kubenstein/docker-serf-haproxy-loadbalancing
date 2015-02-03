FROM ubuntu

# Configure serf
RUN apt-get update
RUN apt-get install -y unzip wget
RUN wget --no-check-certificat https://dl.bintray.com/mitchellh/serf/0.5.0_linux_amd64.zip -O serf.zip
RUN unzip serf.zip
RUN chmod +x serf
RUN mv serf /usr/bin/serf

# Configure supervisor
RUN apt-get install -qy supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Configure nginx
RUN apt-get install -qy nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD nginx.conf /etc/nginx/sites-available/default
RUN mkdir -p /var/www/

# Add files 
ADD nginx-start.sh /nginx-start.sh
ADD serf-start.sh /serf-start.sh
RUN chmod 755 /serf-start.sh /nginx-start.sh

EXPOSE 8000 7946 7373

CMD ["supervisord", "-n"]