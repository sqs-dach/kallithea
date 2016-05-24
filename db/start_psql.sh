#!/bin/bash
docker rm tqkallpsql
docker run -d --name tqkallpsql -e "POSTGRES_PASSWORD=pgpass99" -v /var/hg/kallithea_psql:/var/lib/postgresql/data tq/kallithea_psql
