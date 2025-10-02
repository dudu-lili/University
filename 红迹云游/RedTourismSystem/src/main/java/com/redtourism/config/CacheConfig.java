//package com.redtourism.config;
//import org.springframework.cache.CacheManager;
//import org.springframework.cache.annotation.EnableCaching;
//import org.springframework.cache.caffeine.CaffeineCacheManager;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import com.github.benmanes.caffeine.cache.Caffeine;
//import org.springframework.cache.CacheManager;
//import org.springframework.cache.caffeine.CaffeineCacheManager;
//
//import java.util.concurrent.TimeUnit;
//
//@Configuration
//@EnableCaching
//public class CacheConfig {
//    @Bean
//    public CacheManager cacheManager() {
//        CaffeineCacheManager manager = new CaffeineCacheManager();
//        manager.setCaffeine(Caffeine.newBuilder()
//                .expireAfterWrite(10, TimeUnit.MINUTES)
//                .maximumSize(1000));
//        return manager;
//    }
//}