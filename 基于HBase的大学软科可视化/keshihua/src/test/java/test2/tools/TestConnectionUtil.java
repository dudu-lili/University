package test2.tools;

import com.test.tools.ConnectionUtil;
import org.junit.Test;

import java.io.IOException;


public class TestConnectionUtil {
    @Test
    public void test() throws IOException {
       System.out.println(ConnectionUtil.getConn());
    }
}
