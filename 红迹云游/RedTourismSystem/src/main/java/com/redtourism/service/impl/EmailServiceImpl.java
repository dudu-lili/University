package com.redtourism.service.impl;

import com.redtourism.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailServiceImpl implements EmailService {

    @Autowired
    private JavaMailSender javaMailSender;

//    /**
//     * 发送简单文本邮件
//     * @param to 收件人邮箱地址
//     * @param subject 邮件主题
//     * @param text 邮件正文
//     */
    @Override
    public void sendSimpleEmail(String to, String subject, String content) {
//        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setFrom("1223499973@qq.com"); // 明确设置发件人
            message.setTo(to);
            message.setSubject(subject);
            message.setText(content);

            javaMailSender.send(message);
    }
}
