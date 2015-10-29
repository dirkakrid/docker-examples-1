FROM debian:jessie

RUN apt-get update && \
    apt-get install -y apache2 libapache2-mod-wsgi && \
    rm -r /var/lib/apt/lists/*

COPY run.sh /app/
COPY wsgi.conf /etc/apache2/sites-enabled/000-default.conf

COPY hello.wsgi /app/

EXPOSE 80

CMD [ "/app/run.sh" ]
