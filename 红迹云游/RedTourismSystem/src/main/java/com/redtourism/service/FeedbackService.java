package com.redtourism.service;

import com.redtourism.entity.Feedback;
import com.redtourism.entity.FeedbackQuery;
import java.util.List;

public interface FeedbackService {
    
    /**
     * 提交用户反馈
     * @param feedback 包含用户ID、反馈类型和内容的反馈对象
     * @return 操作是否成功
     */
    boolean submitFeedback(Feedback feedback);

    /**
     * 开始处理指定反馈
     * @param feedbackId 要处理的反馈ID
     * @return 操作是否成功（自动获取当前管理员ID）
     */
    boolean startProcessing(Integer feedbackId, Integer adminId);

    /**
     * 标记反馈为已解决
     * @param feedbackId 要解决的反馈ID
     * @return 操作是否成功
     */
    boolean markResolved(Integer feedbackId);

    /**
     * 获取反馈列表（支持多条件查询）
     * @param query 包含状态、用户ID、时间范围、关键词、反馈类型的查询条件
     * @return 匹配的反馈列表
     */
    List<Feedback> getFeedbackList(FeedbackQuery query);

    /**
     * 删除指定反馈
     * @param feedbackId 要删除的反馈ID
     * @return 操作是否成功
     */
    boolean deleteFeedback(Integer feedbackId);

    /**
     * 批量删除反馈
     * @param feedbackIds 要删除的反馈ID列表
     * @return 操作是否成功
     */
    boolean batchDeleteFeedback(List<Integer> feedbackIds);
}