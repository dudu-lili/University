package com.redtourism.service;



public interface EmailService {

    void sendSimpleEmail(String email, String subject, String text);
}
