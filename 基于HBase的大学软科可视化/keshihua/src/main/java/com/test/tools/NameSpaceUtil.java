package com.test.tools;

import org.apache.hadoop.hbase.NamespaceDescriptor;
import org.apache.hadoop.hbase.client.Admin;
import org.apache.hadoop.hbase.client.Connection;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
@Component
public class NameSpaceUtil {
    public static List<String> listNamespace(Connection conn) throws IOException {
        List<String> nss=new ArrayList<String>();
        Admin admin=conn.getAdmin();
        NamespaceDescriptor[] namespaceDescriptors=admin.listNamespaceDescriptors();
        for (NamespaceDescriptor namespaceDescriptor:namespaceDescriptors){
            nss.add(namespaceDescriptor.getName());
        }
        admin.close();
        return nss;
    }
//    创建库
    public static Boolean createNamespace(Connection conn,String nameSpace) throws IOException {
        Admin admin = conn.getAdmin();
        NamespaceDescriptor build =NamespaceDescriptor.create(nameSpace).build();
        try {
            admin.createNamespace(build);
            return true;
        }catch (IOException e){
            e.printStackTrace();
            return false;
        }finally {
            admin.close();
        }
    }
}
