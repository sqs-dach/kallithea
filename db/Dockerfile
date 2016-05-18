#

FROM postgres:9.5

ADD docker/bootstrap-kallithea-db.sql /docker-entrypoint-initdb.d/bootstrap-kallithea-db.sql

CMD ["postgres"]
