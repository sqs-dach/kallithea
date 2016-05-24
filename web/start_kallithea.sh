#!/bin/bash
docker rm tqkall
docker run -dp 3080:80 --name tqkall --link tqkallpsql:db -v /var/hg/kallithea:/opt/kallithea/repos -v /var/log/kallithea:/var/log/apache2 tq/kallithea
