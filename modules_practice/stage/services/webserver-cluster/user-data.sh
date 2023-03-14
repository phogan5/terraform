#!/bin/bash

cat > index.html <<EOF
<h1>Hello, World</h1>
<p>DB Address: ${db_address}</p>
<p>DB Port: ${db_port}</p>
EOF

sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable --now httpd