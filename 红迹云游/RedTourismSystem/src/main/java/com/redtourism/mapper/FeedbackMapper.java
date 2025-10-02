package com.redtourism.mapper;


import com.redtourism.entity.Feedback;
import com.redtourism.entity.FeedbackQuery;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface FeedbackMapper {
    int insertFeedback(Feedback feedback);
    int startProcessing(@Param("feedbackId") Integer feedbackId, @Param("adminId") Integer adminId);
    int markResolved(Integer feedbackId);
    List<Feedback> selectFeedback(FeedbackQuery query);
    int deleteFeedback(Integer feedbackId);
    int batchDeleteFeedback(@Param("list") List<Integer> feedbackIds);
}