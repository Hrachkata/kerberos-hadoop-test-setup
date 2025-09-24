#!/bin/bash
# start krb5kdc in the background
krb5kdc &
sleep 5  # wait for KDC to initialize

# create test user and HTTP principal
kadmin.local <<EOF
addprinc -randkey nn/hadoop@EXAMPLE.COM
ktadd -k /tmp/nn.keytab nn/hadoop@EXAMPLE.COM

addprinc -randkey dn/hadoop@EXAMPLE.COM
ktadd -k /tmp/dn.keytab dn/hadoop@EXAMPLE.COM

addprinc -randkey HTTP/hadoop@EXAMPLE.COM
ktadd -k /tmp/http.keytab HTTP/hadoop@EXAMPLE.COM

addprinc -randkey hadoop/hadoop@EXAMPLE.COM
ktadd -k /tmp/client.keytab hadoop/hadoop@EXAMPLE.COM

addprinc -pw 123 test@EXAMPLE.COM
quit
EOF

cp /tmp/*.keytab /keytabs/
# keep container alive for debugging / volume copy
tail -f /dev/null
