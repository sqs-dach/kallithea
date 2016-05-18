#
# TQ Kallithea docker image
#
# Based on Dockerfile from Peter Grace
# https://github.com/PeterGrace/kallithea
#

FROM python:2.7

RUN apt-get -y update
RUN apt-get -y install apache2 libapache2-mod-wsgi

RUN virtualenv /opt/kallithea
ENV PATH=/opt/kallithea/bin:$PATH
ENV VIRTUAL_ENV=/opt/kallithea
RUN pip install kallithea
RUN a2dissite 000-default

RUN apt-get -y install libsasl2-dev python-dev libldap2-dev libssl-dev
RUN pip install python-ldap
RUN apt-get -y autoremove
RUN apt-get -y install python-psycopg2
RUN pip install psycopg2

RUN mkdir /opt/kallithea/repos
ADD docker/production.ini /opt/kallithea/production.ini

ADD docker/kallithea.conf /etc/apache2/sites-available/kallithea.conf
ADD docker/dispatch.wsgi /opt/kallithea/dispatch.wsgi
RUN a2ensite kallithea

RUN mkdir /opt/kallithea/data

# We don't use a data volume so we reuse
# the UID/GID of apache from host system
# 
ENV NEWUID 48
ENV NEWGID 48
RUN usermod  -u ${NEWUID} www-data
RUN groupmod -g ${NEWGID} www-data
RUN usermod  -g ${NEWGID} www-data

RUN chown www-data.www-data -R /opt/kallithea

VOLUME ["/opt/kallithea/repos","/opt/kallithea/data","/var/log/apache2"]
EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
