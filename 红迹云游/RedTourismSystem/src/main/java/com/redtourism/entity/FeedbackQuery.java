package com.redtourism.entity;

import lombok.Data;

import java.time.LocalDate;
import java.util.Date;

@Data
public class FeedbackQuery {
    private String status;
    private Integer userId;
    private LocalDate startDate;
    private LocalDate endDate;
    private String keyword;
    private String feedbackType;
}
