FROM ubuntu:16.04

RUN dpkg --add-architecture i386
RUN apt-get update  \
    && apt-get upgrade -y \
    && apt-get install -y \
        apache2 \
        apache2-doc \
        ant \
        git \
        lib32gcc1 \
        lib32stdc++6 \
        libapache2-mod-php \
        libcurl4-gnutls-dev:i386 \
        libstdc++6:i386 \
        php \
        php-curl \
        php-dev \
        php-xdebug \
        php-xml \
        python2.7 \
        python-pip \
        python-matplotlib \
        software-properties-common
    RUN  \
        apt-get install -y openjdk-8-jdk && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /var/www/html/
RUN rm -rf *
RUN git clone --recurse-submodules https://github.com/Dash-Industry-Forum/DASH-IF-Conformance.git \
    && chown -R www-data:www-data /var/www/ \
    && echo 'www-data ALL=NOPASSWD: ALL' >> /etc/sudoers
RUN /usr/sbin/a2enmod headers \
    && /usr/sbin/a2enmod proxy_http

EXPOSE 80/tcp
STOPSIGNAL SIGWINCH
CMD ["/usr/sbin/apache2ctl", "-DFOREGROUND"]
