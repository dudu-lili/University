package com.redtourism.service.impl;

import com.redtourism.service.FileStorageService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileStorageServiceImpl implements FileStorageService {
    @Override
    public String storeFile(MultipartFile file) {
        // 实现文件存储逻辑
        // 返回文件存储路径
        return "uploads/" + file.getOriginalFilename();
    }
}