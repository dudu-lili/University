////package com.test.tools;
////
////import org.apache.hadoop.hbase.Cell;
////import org.apache.hadoop.hbase.CellUtil;
////import org.apache.hadoop.hbase.TableName;
////import org.apache.hadoop.hbase.client.*;
////import org.apache.hadoop.hbase.util.Bytes;
////
////import java.io.IOException;
////
////public class DataUtil {
////    //操作表的
////    public static Table getTable(Connection coon, String tableName, String nameSpace) throws IOException {
////        TableName tableName1=TableName.valueOf(nameSpace, tableName);
////        return coon.getTable(tableName1);
////    }
////    //增加数据，放入数据到hbase
////    public static void put(Connection conn,String tableName,String nameSpace,String rowkey,String cf,String cq,String value) throws IOException {
////        Table table=getTable(conn, tableName, nameSpace);
////        Put put=new Put(Bytes.toBytes(rowkey));
////        put.addColumn(Bytes.toBytes(cf), Bytes.toBytes(cq), Bytes.toBytes(value));
////        table.put(put);
////        table.close();
////    }
////    //查询
////    public static void get(Connection conn,String tableName,String nameSpace,String rowkey,String cf,String cq,String value) throws IOException {
////        Table table=getTable(conn, tableName, nameSpace);
////        Get get=new Get(Bytes.toBytes(rowkey));
////        Result result=table.get(get);
////        while (result!=null){
////            Cell[] cells=result.rawCells();
////            for (Cell cell:cells){
////                String row=Bytes.toString(CellUtil.cloneRow(cell));
////                String family=Bytes.toString(CellUtil.cloneFamily(cell));
////                String qualifier=Bytes.toString(CellUtil.cloneQualifier(cell));
////                String Value=Bytes.toString(CellUtil.cloneValue(cell));
////                System.out.println(String.format("行：%s    列族：%s    列名：%s    值：%s",row,family,qualifier,Value));
////            }
////        }
////        table.close();
////    }
////    // 扫描整个表
////    public static void scanAll(Connection conn, String tableName, String nameSpace) throws IOException {
////        TableName tableNameObj = TableName.valueOf(nameSpace, tableName);
////        try (Table table = conn.getTable(tableNameObj)) {
////            Scan scan = new Scan();
////            ResultScanner scanner = table.getScanner(scan);
////            for (Result result : scanner) {
////                for (Cell cell : result.listCells()) {
////                    String row = Bytes.toString(CellUtil.cloneRow(cell));
////                    String family = Bytes.toString(CellUtil.cloneFamily(cell));
////                    String qualifier = Bytes.toString(CellUtil.cloneQualifier(cell));
////                    String value = Bytes.toString(CellUtil.cloneValue(cell));
////                    System.out.println(String.format("行：%s    列族：%s    列限定符：%s    值：%s", row, family, qualifier, value));
////                }
////            }
////            scanner.close();
////        }
////    }
////}
//
//package com.test.tools;
//
//import org.apache.hadoop.hbase.Cell;
//import org.apache.hadoop.hbase.CellUtil;
//import org.apache.hadoop.hbase.TableName;
//import org.apache.hadoop.hbase.client.*;
//import org.apache.hadoop.hbase.util.Bytes;
//import org.springframework.stereotype.Component;
//
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.List;
//@Component
//public class DataUtil {
//    // 操作表的
//    public static Table getTable(Connection conn, String tableName, String nameSpace) throws IOException {
//        TableName tableName1 = TableName.valueOf(nameSpace, tableName);
//        return conn.getTable(tableName1);
//    }
//
//    // 增加数据，放入数据到hbase
//    public static void put(Connection conn, String tableName, String nameSpace, String rowkey, String cf, String cq, String value) throws IOException {
//        Table table = getTable(conn, tableName, nameSpace);
//        Put put = new Put(Bytes.toBytes(rowkey));
//        put.addColumn(Bytes.toBytes(cf), Bytes.toBytes(cq), Bytes.toBytes(value));
//        table.put(put);
//        table.close();
//    }
//
//    // 查询
//    public static List<String> get(Connection conn, String tableName, String nameSpace, String rowkey, String cf, String cq) throws IOException {
//        List<String> results = new ArrayList<>();
//        Table table = getTable(conn, tableName, nameSpace);
//        Get get = new Get(Bytes.toBytes(rowkey));
//        Result result = table.get(get);
//        if (result != null) {
//            Cell[] cells = result.rawCells();
//            for (Cell cell : cells) {
//                String row = Bytes.toString(CellUtil.cloneRow(cell));
//                String family = Bytes.toString(CellUtil.cloneFamily(cell));
//                String qualifier = Bytes.toString(CellUtil.cloneQualifier(cell));
//                String value = Bytes.toString(CellUtil.cloneValue(cell));
//                results.add(String.format("行：%s    列族：%s    列名：%s    值：%s", row, family, qualifier, value));
//            }
//        }
//        table.close();
//        return results;
//    }
//
//    // 扫描整个表
//    public static List<String> scanAll(Connection conn, String tableName, String nameSpace) throws IOException {
//        List<String> results = new ArrayList<>();
//        TableName tableNameObj = TableName.valueOf(nameSpace, tableName);
//        try (Table table = conn.getTable(tableNameObj)) {
//            Scan scan = new Scan();
//            ResultScanner scanner = table.getScanner(scan);
//            for (Result result : scanner) {
//                for (Cell cell : result.listCells()) {
//                    String row = Bytes.toString(CellUtil.cloneRow(cell));
//                    String family = Bytes.toString(CellUtil.cloneFamily(cell));
//                    String qualifier = Bytes.toString(CellUtil.cloneQualifier(cell));
//                    String value = Bytes.toString(CellUtil.cloneValue(cell));
//                    results.add(String.format("行：%s    列族：%s    列限定符：%s    值：%s", row, family, qualifier, value));
//                }
//            }
//            scanner.close();
//        }
//        return results;
//    }
//}
package com.test.tools;

import org.apache.hadoop.hbase.Cell;
import org.apache.hadoop.hbase.CellUtil;
import org.apache.hadoop.hbase.TableName;
import org.apache.hadoop.hbase.client.*;
import org.apache.hadoop.hbase.util.Bytes;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Component
public class DataUtil {
    // 操作表的
    public static Table getTable(Connection conn, String tableName, String nameSpace) throws IOException {
        TableName tableName1 = TableName.valueOf(nameSpace, tableName);
        return conn.getTable(tableName1);
    }

    // 增加数据，放入数据到hbase
    public static void put(Connection conn, String tableName, String nameSpace, String rowkey, String cf, String cq, String value) throws IOException {
        Table table = getTable(conn, tableName, nameSpace);
        Put put = new Put(Bytes.toBytes(rowkey));
        put.addColumn(Bytes.toBytes(cf), Bytes.toBytes(cq), Bytes.toBytes(value));
        table.put(put);
        table.close();
    }

    // 查询
    public static List<String> get(Connection conn, String tableName, String nameSpace, String rowkey, String cf, String cq) throws IOException {
        List<String> results = new ArrayList<>();
        Table table = getTable(conn, tableName, nameSpace);
        Get get = new Get(Bytes.toBytes(rowkey));
        Result result = table.get(get);
        if (result != null) {
            Cell[] cells = result.rawCells();
            for (Cell cell : cells) {
                String row = Bytes.toString(CellUtil.cloneRow(cell));
                String family = Bytes.toString(CellUtil.cloneFamily(cell));
                String qualifier = Bytes.toString(CellUtil.cloneQualifier(cell));
                String value = Bytes.toString(CellUtil.cloneValue(cell));
                results.add(String.format("行：%s    列族：%s    列名：%s    值：%s", row, family, qualifier, value));
            }
        }
        table.close();
        return results;
    }

    // 扫描整个表
    public static List<String> scanAll(Connection conn, String tableName, String nameSpace) throws IOException {
        List<String> results = new ArrayList<>();
        TableName tableNameObj = TableName.valueOf(nameSpace, tableName);
        try (Table table = conn.getTable(tableNameObj)) {
            Scan scan = new Scan();
            ResultScanner scanner = table.getScanner(scan);
            for (Result result : scanner) {
                for (Cell cell : result.listCells()) {
                    String row = Bytes.toString(CellUtil.cloneRow(cell));
                    String family = Bytes.toString(CellUtil.cloneFamily(cell));
                    String qualifier = Bytes.toString(CellUtil.cloneQualifier(cell));
                    String value = Bytes.toString(CellUtil.cloneValue(cell));
                    results.add(String.format("行：%s    列族：%s    列限定符：%s    值：%s", row, family, qualifier, value));
                }
            }
            scanner.close();
        }
        return results;
    }
    public String convertToCSV(List<Result> results) {
        StringBuilder csv = new StringBuilder();
        for (Result result : results) {
            // 获取 'cf' 列族下 'name' 列的值，如果为 null，则使用 "N/A"
            String name = Bytes.toString(result.getValue(Bytes.toBytes("cf"), Bytes.toBytes("name"))) != null ?
                    Bytes.toString(result.getValue(Bytes.toBytes("cf"), Bytes.toBytes("name"))) : "N/A";

            // 获取 'cf' 列族下 '分数' 列的值，如果为 null，则使用 "N/A"
            String score = Bytes.toString(result.getValue(Bytes.toBytes("cf"), Bytes.toBytes("分数"))) != null ?
                    Bytes.toString(result.getValue(Bytes.toBytes("cf"), Bytes.toBytes("分数"))) : "N/A";

            csv.append(name).append(",");
            csv.append(score).append("\n");
        }
        return csv.toString();
    }
}