FROM python:2.7

RUN apt-get update && apt-get install -y locales \
    apache2 apache2-dev cmake && rm -r /var/lib/apt/lists/*

RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
RUN locale-gen

ENV LANG=en_US.UTF-8
ENV CC=gcc

ENV NSS_WRAPPER_VERSION=1.0.3

RUN mkdir -p /tmp/build/nss_wrapper && \
    curl -SL -o /tmp/build/nss_wrapper.tar.gz \
     https://ftp.samba.org/pub/cwrap/nss_wrapper-$NSS_WRAPPER_VERSION.tar.gz && \
    tar -xC /tmp/build/nss_wrapper --strip-components=1 \
     -f /tmp/build/nss_wrapper.tar.gz && \
    cd /tmp/build/nss_wrapper && \
    mkdir obj && \
    cd obj  && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local/nss_wrapper -DLIB_SUFFIX=64 .. && \
    make && \
    make install && \
    rm -rf /tmp/build

RUN pip install mod_wsgi
RUN pip install Django

ENV APP_HOMEDIR /app
ENV APP_DATADIR /data
ENV APP_TEMPDIR /tmp

COPY ./ $APP_HOMEDIR/

WORKDIR $APP_HOMEDIR

RUN mkdir $APP_DATADIR
RUN chmod 1777 $APP_DATADIR

RUN mkdir -p /var/www
RUN chmod 1777 /var/www
ENV HOME=/var/www

USER www-data

RUN python example/manage.py collectstatic --noinput

CMD [ "./run.sh" ]
