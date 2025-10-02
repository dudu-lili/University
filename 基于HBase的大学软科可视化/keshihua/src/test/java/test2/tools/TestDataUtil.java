package test2.tools;

import com.test.tools.ConnectionUtil;
import com.test.tools.DataUtil;
import com.test.tools.TableUtil;
import org.apache.hadoop.hbase.client.Connection;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.*;

public class TestDataUtil {
    private Connection conn;
    @Before
    public void init() throws IOException {
        conn = ConnectionUtil.getConn();
    }
    @After
    public void close() throws IOException {
        ConnectionUtil.close(conn);
    }
    @Test
    public void TestPut() throws IOException {
//        DataUtil.put(conn,"student", null, "r1","cf1","name","xiaoming");存入一行数据
        String csvFile = "E:\\Java\\projects\\keshihua\\src\\main\\java\\com\\2024daxue.csv"; // 替换为你的CSV文件路径
        String tableName = "student_1";
        String columnFamily = "cf";
        // 使用UTF-8编码读取文件
        BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(csvFile), "UTF-8"));
        String line;
        br.readLine();//跳过标题行
        while ((line = br.readLine()) != null) {
            String[] data = line.split(","); // 假设CSV的每个字段由逗号分隔
            if (data.length > 0) {
                String rowKey = data[0]; // 假设第一列是行键
                // 假设CSV文件的列顺序是：排名,中文名,英文名,标签,地址,行业,分数,办学层次,Logo
                DataUtil.put(conn, tableName, null, rowKey, columnFamily, "name", data[1]);
                DataUtil.put(conn, tableName, null, rowKey, columnFamily, "英文名", data[2]);
                DataUtil.put(conn, tableName, null, rowKey, columnFamily, "标签", data[3]);
                DataUtil.put(conn, tableName, null, rowKey, columnFamily, "地址", data[4]);
                DataUtil.put(conn, tableName, null, rowKey, columnFamily, "行业", data[5]);
                DataUtil.put(conn, tableName, null, rowKey, columnFamily, "分数", data[6]);
                DataUtil.put(conn, tableName, null, rowKey, columnFamily, "办学层次", data[7]);
                DataUtil.put(conn, tableName, null, rowKey, columnFamily, "Logo", data[8]);
//                // Logo列是URL，可能不需要存储在HBase中，或者可以存储为二进制数据
//                if (data.length > 8) {
//                    DataUtil.put(conn, tableName, null, rowKey, columnFamily, "Logo", data[8]);
//                }
            }
        }
        br.close();
    }
//    @Test
//    public void TestGet() throws IOException {
//         DataUtil.get(conn, "student", null);
//    }
    @Test
    public void testScanAll() throws IOException {
        DataUtil.scanAll(conn, "student", null);
    }
}
