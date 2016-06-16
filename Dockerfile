FROM  ubuntu:xenial
MAINTAINER gregspace@gmail.com

RUN apt-get update && apt-get install -y  wget

RUN wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add -
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt-get install -y python-software-properties software-properties-common postgresql-9.5 postgresql-client-9.5 postgresql-contrib-9.5

USER postgres

RUN /etc/init.d/postgresql start &&\
    psql --command "CREATE USER docker with SUPERUSER PASSWORD 'docker';" &&\
    createdb -O docker docker

RUN echo "host all  all     0.0.0.0/0   md5" >> /etc/postgresql/9.5/main/pg_hba.conf

RUN echo "listen_addresses='*'" >> /etc/postgresql/9.5/main/postgresql.conf

EXPOSE 5432

##add local volumes to allow bockup of config, logs and db
##VOLUME ["./etc/postgresql", /
#
CMD ["/usr/lib/postgresql/9.5/bin/postgres", "-D", "/var/lib/postgresql/9.5/main", "-c", "config_file=/etc/postgresql/9.5/main/postgresql.conf"]

## To Run with container in foreground:
## docker run --rm -P --name pg_test eg_postgresql:v1
#
## Working 
## TO test see 
## https://docs.docker.com/engine/examples/postgresql_service/
#
