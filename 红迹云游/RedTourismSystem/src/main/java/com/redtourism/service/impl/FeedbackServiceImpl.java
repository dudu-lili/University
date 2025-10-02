package com.redtourism.service.impl;

import com.redtourism.entity.Feedback;
import com.redtourism.entity.FeedbackQuery;
import com.redtourism.mapper.FeedbackMapper;
import com.redtourism.service.FeedbackService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 反馈业务逻辑实现类
 * 处理用户反馈的全生命周期管理（提交、处理、解决、查询、删除）
 */
@Service
public class FeedbackServiceImpl implements FeedbackService {

    @Autowired
    private FeedbackMapper feedbackMapper; // 持久层操作接口

    /**
     * 管理员开始处理指定反馈
     * @param feedbackId 要处理的反馈ID（必须存在）
     * @param adminId 执行操作的管理员ID（从Session中获取）
     * @return 操作是否成功（影响行数>0为true）
     * @implNote 更新反馈状态为processing，记录处理人ID和处理时间
     */
    @Override
    public boolean startProcessing(Integer feedbackId, Integer adminId) {
        // 调用Mapper层执行状态更新操作
        // 参数校验应在Controller层完成
        return feedbackMapper.startProcessing(feedbackId, adminId) > 0;
    }

    /**
     * 用户提交新反馈
     * @param feedback 包含用户ID、反馈类型、内容等信息的反馈对象
     * @return 操作是否成功（影响行数>0为true）
     * @implNote 插入新记录时自动设置：
     * - status为pending（待处理）
     * - create_time为当前时间
     * - process_time和resolve_time为null
     */
    @Override
    public boolean submitFeedback(Feedback feedback) {
        // 参数校验（非空、长度等）应在Controller层完成
        return feedbackMapper.insertFeedback(feedback) > 0;
    }

    /**
     * 标记反馈为已解决状态
     * @param feedbackId 要解决的反馈ID（必须存在且状态为processing）
     * @return 操作是否成功（影响行数>0为true）
     * @implNote 更新反馈状态为resolved，记录解决时间
     */
    @Override
    public boolean markResolved(Integer feedbackId) {
        return feedbackMapper.markResolved(feedbackId) > 0;
    }

    /**
     * 获取符合条件的反馈列表（支持多条件组合查询）
     * @param query 包含以下查询条件的对象：
     *             - status：反馈状态（pending/processing/resolved）
     *             - userId：提交用户ID
     *             - startTime/endTime：提交时间范围
     *             - keyword：标题/内容关键词
     *             - feedback_type: 反馈类型
     * @return 匹配的反馈列表（按创建时间倒序）
     * @implNote 返回结果包含：
     * - 反馈基本信息
     * - 当前处理状态
     * - 操作管理员名称（如果有）
     */
    @Override
    public List<Feedback> getFeedbackList(FeedbackQuery query) {
        return feedbackMapper.selectFeedback(query);
    }

    /**
     * 删除指定反馈记录
     * @param feedbackId 要删除的反馈ID（必须存在且未被解决）
     * @return 操作是否成功（影响行数>0为true）
     * @implNote 物理删除（可根据需求改为逻辑删除）
     */
    @Override
    public boolean deleteFeedback(Integer feedbackId) {
        return feedbackMapper.deleteFeedback(feedbackId) > 0;
    }

    /**
     * 批量删除反馈记录
     * @param feedbackIds 要删除的反馈ID列表（每个ID都需要有效）
     * @return 操作是否成功（总影响行数>0为true）
     * @implNote 使用批量删除SQL提高性能
     */
    @Override
    public boolean batchDeleteFeedback(List<Integer> feedbackIds) {
        return feedbackMapper.batchDeleteFeedback(feedbackIds) > 0;
    }
}