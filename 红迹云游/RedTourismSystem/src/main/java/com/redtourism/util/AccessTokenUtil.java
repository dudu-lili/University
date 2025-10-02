package com.redtourism.util;

import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

public class AccessTokenUtil {
    private static final String TOKEN_URL = "https://openapi.baidu.com/oauth/2.0/token";
    private static final String GRANT_TYPE = "client_credentials";
    private static final String CLIENT_ID = "C3mdJu9B9KkTUlz9pDVN2ZJTbwThgu6B"; // 替换为你的client_id
    private static final String CLIENT_SECRET = "SpGSnmGJqy9U6GqicsensVkPM9UssgiA"; // 替换为你的client_secret

    public static String getAccessToken() {
        try {
            HttpClient client = HttpClients.createDefault();
            String url = TOKEN_URL + "?grant_type=" + GRANT_TYPE + "&client_id=" + CLIENT_ID + "&client_secret=" + CLIENT_SECRET;
            HttpGet request = new HttpGet(url);
            HttpResponse response = client.execute(request);
            String responseText = EntityUtils.toString(response.getEntity(), "UTF-8");

            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode rootNode = objectMapper.readTree(responseText);
            return rootNode.path("access_token").asText();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}