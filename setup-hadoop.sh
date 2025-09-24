sleep 10
while [ ! -f /etc/security/keytabs/nn.keytab ]; do sleep 1; done
sudo sed -i 's/SERVER/test-kdc/g' /etc/krb5.conf 
sudo chown hadoop:hadoop /etc/security/keytabs/*.keytab || true 
sudo chmod 600 /etc/security/keytabs/*.keytab || true 
sudo rm -rf /tmp/hadoop-root/dfs/data/* 
sudo rm -rf /tmp/hadoop-root/dfs/name/* 
sudo mkdir -p /tmp/hadoop-root/dfs/data 
sudo mkdir -p /tmp/hadoop-root/dfs/name 
sudo chown -R hadoop:hadoop /tmp/hadoop-root 
sudo chmod -R 700 /tmp/hadoop-root 
hdfs namenode -format -force 
hdfs --daemon start namenode 
hdfs --daemon start datanode 
hdfs dfs -mkdir /root 
hdfs dfs -mkdir /root/testFolder1 
hdfs dfs -mkdir /root/testFolder2 
hdfs dfs -chown dr.who:supergroup /root 
hdfs dfs -chown dr.who:supergroup /root/testFolder1 
hdfs dfs -chown dr.who:supergroup /root/testFolder2 
kinit -kt /etc/security/keytabs/nn.keytab nn/hadoop@EXAMPLE.COM 
tail -f /dev/null