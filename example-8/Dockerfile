FROM python:2.7

RUN apt-get update && apt-get install -y locales \
    apache2 apache2-dev && rm -r /var/lib/apt/lists/*

RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
RUN locale-gen

ENV LANG=en_US.UTF-8
ENV CC=gcc

RUN pip install mod_wsgi
RUN pip install Django

ENV APP_HOMEDIR /app
ENV APP_DATADIR /data
ENV APP_TEMPDIR /tmp

COPY ./ $APP_HOMEDIR/

WORKDIR $APP_HOMEDIR

RUN mkdir $APP_DATADIR
RUN chmod 1777 $APP_DATADIR

USER www-data

RUN python example/manage.py collectstatic --noinput

CMD [ "./run.sh" ]
