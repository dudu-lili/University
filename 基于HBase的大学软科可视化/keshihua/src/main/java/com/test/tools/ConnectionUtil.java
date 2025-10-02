package com.test.tools;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.HBaseConfiguration;
import org.apache.hadoop.hbase.client.Connection;
import org.apache.hadoop.hbase.client.ConnectionFactory;
import org.springframework.stereotype.Component;

import java.io.IOException;
@Component
public class ConnectionUtil {
    public static Connection getConn() throws IOException {
        Configuration config = HBaseConfiguration.create();
        config.set("hbase.zookeeper.quorum","172.20.10.9, 172.20.10.10, 172.20.10.8");

        config.set("hbase.zookeeper.property.clientPort","2181");
        Connection connection = ConnectionFactory.createConnection(config);
        return connection;
    }
    public static void close(Connection conn) throws IOException {
        if (null != conn){
            conn.close();
        }
    }
}
