# ADD BASE IMAGE PHP
FROM php:apache-buster

LABEL author="AQF"

ENV ACCEPT_EULA=Y


# UTILITY INSTALL
RUN apt-get update && apt-get install -y gnupg2 && apt-get install -y apt-transport-https && apt install -y git \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 \
	&& apt-get install -y unixodbc-dev


# CONFIGURE OPEN SSL
RUN cp /etc/ssl/openssl.cnf /etc/ssl/openssl.cnf.ORI && \
    sed -i "s/\(MinProtocol *= *\).*/\1TLSv1.0 /" "/etc/ssl/openssl.cnf" && \
    sed -i "s/\(CipherString *= *\).*/\1DEFAULT@SECLEVEL=1 /" "/etc/ssl/openssl.cnf" && \
    (diff -u /etc/ssl/openssl.cnf.ORI /etc/ssl/openssl.cnf || exit 0)

# CONFIGURE APACHE HTACCESS
RUN a2enmod rewrite


# CONFIGURE COMPOSER
RUN set -eux && apt-get update && apt-get install -y libzip-dev zlib1g-dev && docker-php-ext-install zip
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/bin/composer

# NODE INSTALL
RUN curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install nodejs -y

#COPY PACKAGE JSON
WORKDIR /var/www/html
COPY package.json .

#INSTALL PACKAGE
RUN npm install

#COPY ALL FILE
COPY . /var/www/html/

EXPOSE 3000
# CMD [ "npm","run","dev" ]
