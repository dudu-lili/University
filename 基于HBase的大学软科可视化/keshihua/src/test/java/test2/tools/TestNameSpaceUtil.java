package test2.tools;

import com.test.tools.ConnectionUtil;
import com.test.tools.NameSpaceUtil;
import org.apache.hadoop.hbase.client.Connection;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.IOException;
import java.util.List;

public class TestNameSpaceUtil {
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
    public void TestlistNamespace() throws IOException {
        List<String> strings= NameSpaceUtil.listNamespace(conn);
        System.out.println(strings);
    }
    @Test
    public void TestCreatNamespace() throws IOException {
        Boolean ns=NameSpaceUtil.createNamespace(conn, "ns");
        System.out.println(ns);
    }
}
