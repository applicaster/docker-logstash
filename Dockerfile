# Logstash

FROM centos

ENV confd_version 0.7.1

RUN yum update -y && yum clean all

# Install confd - https://github.com/kelseyhightower/confd
RUN curl -L https://github.com/kelseyhightower/confd/releases/download/v${confd_version}/confd-${confd_version}-linux-amd64 -o /usr/local/bin/confd; \
    chmod 0755 /usr/local/bin/confd; \
    mkdir -p /etc/confd/{conf.d,templates}

Add ./src /

RUN chmod +x /usr/local/sbin/start.sh

RUN rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch \
 && yum install -y logstash \
 && yum clean all

EXPOSE 2222

VOLUME ["/etc/logstash"]

ENTRYPOINT ["/usr/local/sbin/start.sh"]
