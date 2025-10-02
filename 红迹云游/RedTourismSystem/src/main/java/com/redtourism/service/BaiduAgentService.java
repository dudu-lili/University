package com.redtourism.service;

public interface BaiduAgentService {
    String getAnswer(String appId, String secretKey, String message);
}