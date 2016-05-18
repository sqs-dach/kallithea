# Kallithea multi-container Docker application 

Example to run:
> `docker-compose up `

Docker compose bundle contains kallithea, a DVCS server written in Python, and a postgres server. The Kallithea admin login is `admin` and password is `admin99`, obviously please change it if you intend to use this for more than a quick evaluation.

This Docker compose bundle exposes port 3080 and has three volume export points such that one can make a permanent installation with ephemeral docker containers.
You have to adapt the volume path in docker-compose.yml to your paths.

**If you would like to run this in a more permanent fashion, please do the following steps:**

- create two directories on your docker host, e.g. `/opt/kal/data` and `/opt/kal/repos`
- set owners of those two folders to 48:48 (the www-data user id and group inside of the docker container)
