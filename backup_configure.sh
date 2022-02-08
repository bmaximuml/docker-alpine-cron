#!/usr/bin/env bash

# Author: Max Levine
# Date written: 02 02 2022? (This date is the first it was created on this laptop, should check git)
#
# Purpose: Create a set of cron files to be run once a day based on environment variables:
#
# Environment variables in use:
#  - $CRON_SOURCES # A comma separated list of 

error_diff_src_tgt() {
  echo "Error 1: Different number of sources and targets"
  exit 1
}


IFS=','
read -racron_sources <<EOF
${CRON_SOURCES}
EOF

read -racron_names <<EOF
${CRON_NAMES}
EOF

# if different length, raise error
[[ ${#cron_sources[*]} -ne ${#cron_names[*]} ]] \
  && error_diff_src_tgt

for num in {0..${#cron_sources[*]}}
do
  src=${cron_sources[$num]}
  name=${cron_names[$num]}
  cat << EOF > /etc/periodic/daily/${name}


#!/bin/sh

dt=$(date +\"%F_%H-%M-%S\")
mkdir -p /backups/${name}
tar cvf /backups/${name}/\${d}.tar ${src}

EOF

done
