#!/bin/sh

# 11/2/16, created by Clay Smith
# Installs New Relic Infrastructure using apt or yum
# From: https://docs.newrelic.com/docs/infrastructure/new-relic-infrastructure/installation/install-infrastructure-linux

printenv

if [ -z "$NEWRELIC_LICENSE_KEY" ]; then
    echo "error: Need to set NEWRELIC_LICENSE_KEY"
    exit 1
fi  

if hash apt-get 2>/dev/null
then
     echo "apt detected..."
     echo "license_key: $NEWRELIC_LICENSE_KEY" | sudo tee -a /etc/newrelic-infra.yml
     curl https://75aae388e7629eec895d26b0943bbfd06288356953c5777d:@packagecloud.io/install/repositories/newrelic/infra-beta/script.deb.sh | sudo bash
     sudo apt-get install newrelic-infra -y
elif hash yum 2>/dev/null
then
     echo "yum detected..."
     echo "license_key: $NEWRELIC_LICENSE_KEY" | sudo tee -a /etc/newrelic-infra.yml
     curl https://75aae388e7629eec895d26b0943bbfd06288356953c5777d:@packagecloud.io/install/repositories/newrelic/infra-beta/script.rpm.sh | sudo bash
     sudo yum install newrelic-infra -y
else
     echo "error: no supported package manager detected"
     exit 1
fi
