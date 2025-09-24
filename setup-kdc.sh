#!/bin/bash
# start krb5kdc in the background
krb5kdc &
sleep 5  # wait for KDC to initialize

# create test user and HTTP principal
kadmin.local <<EOF
addprinc -pw testpw testuser
addprinc -randkey HTTP/localhost@EXAMPLE.COM
ktadd -k /tmp/hadoop-http.keytab HTTP/localhost@EXAMPLE.COM
quit
EOF

cp /tmp/hadoop-http.keytab /keytabs/
# keep container alive for debugging / volume copy
tail -f /dev/null
