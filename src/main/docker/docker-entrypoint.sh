#!/bin/sh

# Exit on non-zero return values
set -e

echo "Starting Spring boot app..."
java $JAVA_OPTS -DFOO=$(hostname) -Dlogging.file=/var/log/springboot.crud.sample.log -Djava.security.egd=file:/dev/./urandom -jar /app.jar