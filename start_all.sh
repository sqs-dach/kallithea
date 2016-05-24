#!/bin/bash

# start db container
db/start_psql.sh

# start web container
web/start_kallithea.sh

