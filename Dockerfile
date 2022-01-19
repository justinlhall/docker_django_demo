FROM python:2.7.16-buster

RUN apt-get update -y
RUN apt-get install -y default-mysql-client
RUN apt-get install -y libaio1
RUN apt-get install -y libconfig-inifiles-perl
RUN apt-get install -y libdbd-mysql-perl
RUN apt-get install -y libdbi-perl
RUN apt-get install -y libreadline5
RUN apt-get install -y libterm-readkey-perl
RUN apt-get install -y mariadb-client-10.3
RUN apt-get install -y mariadb-client-core-10.3
RUN apt-get install -y mariadb-common
RUN apt-get install -y dos2unix
RUN sed '/st_mysql_options options;/a unsigned int reconnect;' /usr/include/mysql/mysql.h -i.bkp

# Install required python packages
COPY requirements.txt . 
RUN pip install -r requirements.txt

# Create and set working dir
RUN mkdir -p /django
WORKDIR /django

# Additional python packages only used in docker
RUN pip install coverage