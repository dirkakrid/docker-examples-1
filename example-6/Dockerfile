FROM python:2.7

RUN apt-get update && apt-get install -y locales \
    apache2 apache2-dev && rm -r /var/lib/apt/lists/*

RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
RUN locale-gen

ENV LANG=en_US.UTF-8
ENV CC=gcc

RUN pip install mod_wsgi
RUN pip install Django

COPY ./ /app/

WORKDIR /app

RUN python example/manage.py collectstatic --noinput

USER www-data

CMD [ "mod_wsgi-express", "start-server", \
      "--log-to-terminal", "--processes", "5", "--threads", "3", \
      "--working-directory", "example", \
      "--url-alias", "/static", "example/htdocs", \
      "--application-type", "module", "example.wsgi" ]
