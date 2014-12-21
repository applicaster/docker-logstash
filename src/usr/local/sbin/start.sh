#! /usr/bin/env bash

NAME=logstash
DEFAULT=/etc/sysconfig/$NAME

# Fail hard and fast
set -eo pipefail

export LOGSTASH_HEAP_SIZE=${LOGSTASH_HEAP_SIZE:-256}

# See contents of file named in $DEFAULT for comments
LS_HOME="/var/lib/logstash"
LS_HEAP_SIZE="${LOGSTASH_HEAP_SIZE}m"
LS_JAVA_OPTS="-Djava.io.tmpdir=${LS_HOME}"
LS_CONF_DIR=/etc/logstash/conf.d
LS_OPTS=""

# End of variables that can be overwritten in $DEFAULT

if [ -f "$DEFAULT" ]; then
  . "$DEFAULT"
fi

DAEMON="/opt/logstash/bin/logstash"
DAEMON_OPTS="agent -f ${LS_CONF_DIR} ${LS_OPTS}"

# Prepare environment
HOME="${HOME:-$LS_HOME}"
JAVACMD="/usr/bin/java"
JAVA_OPTS="${LS_JAVA_OPTS}"
cd "${LS_HOME}"
export HOME JAVACMD JAVA_OPTS LS_HEAP_SIZE LS_JAVA_OPTS LS_USE_GC_LOGGING DAEMON DAEMON_OPTS

su -s /bin/bash logstash -c "$DAEMON $DAEMON_OPTS"
