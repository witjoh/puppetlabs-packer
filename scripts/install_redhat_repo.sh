#!/bin/bash
#
# This script isntalls the local mirror of the
# redhat installation repo on a docker images.
# It will exit on all other distros, where the
# default work
#
# The repository URI should be passed as first argument
#
cat << EOF > /etc/yum.repos.d/local_mirror.repo
[redhat_install]
name='local mirror redhat'
baseurl=$1
gpgcheck=0
EOF

  
