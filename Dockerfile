# Logstash

FROM centos

RUN yum update -y && yum clean all

Add ./src /

RUN chmod +x /usr/local/sbin/start.sh

RUN rpm --import http://packages.elasticsearch.org/GPG-KEY-elasticsearch \
 && yum install -y logstash \
 && yum clean all

VOLUME ["/etc/logstash"]

ENTRYPOINT ["/usr/local/sbin/start.sh"]
