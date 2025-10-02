package test2.tools;

import com.test.tools.ConnectionUtil;
import com.test.tools.NameSpaceUtil;
import com.test.tools.TableUtil;
import org.apache.hadoop.hbase.client.Connection;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;

public class TestTableUtil {
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
    public void TestCreatTable() throws IOException {
        System.out.println(TableUtil.createTable(conn, "student_1", null, "cf"));
    }
}
