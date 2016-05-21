FROM python:2-slim

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq && \
    apt-get -y install rsyslog postfix && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install j2cli

RUN mkdir /templates
ADD virtual.j2 /templates/virtual.j2
ADD virtual-regexp.j2 /templates/virtual-regexp.j2
ADD mailname.j2 /templates/mailname.j2
ADD main.cf.j2 /templates/main.cf.j2

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 25

CMD ["sh", "-c", "service rsyslog start ; service postfix start ; tail -F /var/log/maillog"]

