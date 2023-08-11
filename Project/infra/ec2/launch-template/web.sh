#!/bin/bash
cat > index.html <<EOF
<H1>project01 version 1 </H1>
EOF
nohup busybox httpd -f -p ${server_port} &
