package com.test.tools;

import org.apache.hadoop.hbase.HColumnDescriptor;
import org.apache.hadoop.hbase.HTableDescriptor;
import org.apache.hadoop.hbase.TableName;
import org.apache.hadoop.hbase.client.Admin;
import org.apache.hadoop.hbase.client.Connection;
import org.springframework.stereotype.Component;

import java.io.IOException;
@Component
//创建表
public class TableUtil {
    public static Boolean createTable(Connection conn,String tableName, String nameSpace,String ...cfs) throws IOException {
        if (cfs.length<1){
            return false;
        }
        TableName tableName1=TableName.valueOf(nameSpace, tableName);//库名，表名
        Admin admin=conn.getAdmin();

        HTableDescriptor hTableDescriptor=new HTableDescriptor(tableName1);//描述表的信息
        for (String cf: cfs){//增加列簇
            HColumnDescriptor hColumnDescriptor=new HColumnDescriptor(cf);
            hTableDescriptor.addFamily(hColumnDescriptor);
        }
        admin.createTable(hTableDescriptor);
        admin.close();
        return true;
    }
}
