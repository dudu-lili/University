package com.redtourism.service.impl;

import com.redtourism.service.BaiduAgentService;
import com.redtourism.util.AccessTokenUtil;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.JsonNode;
import org.springframework.stereotype.Service;

@Service
public class BaiduAgentServiceImpl implements BaiduAgentService {
    private static final String API_URL = "https://agentapi.baidu.com/assistant/getAnswer";

    @Override
    public String getAnswer(String appId, String secretKey, String message) {
        try {
            System.setProperty("http.proxyHost", "your.proxy.server");
            System.setProperty("http.proxyPort", "8080");
            // 获取access_token
            String accessToken = AccessTokenUtil.getAccessToken();
            if (accessToken == null) {
                System.out.println("Failed to get access_token");
                return "Failed to get access_token";
            }
            System.out.println("access_token"+accessToken);

            // 构造请求URL
            String url = API_URL + "?appId=" + appId + "&secretKey=" + secretKey + "&access_token=" + accessToken;
            System.out.println("url"+url);
            // 构造请求体
            String requestBody = "{"
                    + "\"message\": {"
                    + "    \"content\": {"
                    + "        \"type\": \"text\","
                    + "        \"value\": {"
                    + "            \"showText\": \"" + message + "\""
                    + "        }"
                    + "    }"
                    + "},"
                    + "\"source\": \"" + appId + "\","
                    + "\"from\": \"openapi\","
                    + "\"openId\": \"user12345\"" // 替换为你的用户ID
                    + "}";
            System.out.println("url1"+requestBody);
            HttpClient client = HttpClients.createDefault();
            HttpPost post = new HttpPost(url);
            post.setHeader("Content-Type", "application/json");
            post.setEntity(new StringEntity(requestBody, "UTF-8"));

            HttpResponse response = client.execute(post);
            String responseText = EntityUtils.toString(response.getEntity(), "UTF-8");
            System.out.println("url2"+responseText);
            // 可以根据需要解析返回的JSON数据
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode rootNode = objectMapper.readTree(responseText);
            String status = rootNode.path("status").asText();
            if ("0".equals(status)) {
                return rootNode.path("data").path("content").get(0).path("data").asText();
            } else {
                return rootNode.path("message").asText();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "Error occurred during API call";
        }
    }
}
