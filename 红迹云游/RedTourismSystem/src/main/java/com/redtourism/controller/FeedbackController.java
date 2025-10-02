package com.redtourism.controller;

import com.redtourism.entity.Admin;
import com.redtourism.entity.Feedback;
import com.redtourism.entity.FeedbackQuery;
import com.redtourism.entity.User;
import com.redtourism.service.FeedbackService;
import com.redtourism.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/feedback")
public class FeedbackController {

    @Autowired
    private FeedbackService feedbackService;


    /**
     * 用户提交新反馈
     * @param feedback 包含反馈内容的JSON对象（需包含title和content字段）
     * @param session 用于验证用户登录状态
     * @return 操作结果
     */
    @PostMapping("/submit")
    public ResponseResult<Feedback> submitFeedback(
            @RequestBody Feedback feedback,
            HttpSession session) {

        // 1. 用户登录校验
        User currentUser = (User) session.getAttribute("user");
        if (currentUser == null || !currentUser.isActive()) {
            return ResponseResult.fail("请先登录用户账号");
        }

        // 2. 参数校验（新增反馈类型校验，补充内容长度校验）
        if (feedback.getFeedbackType() == null || feedback.getFeedbackType().trim().isEmpty()) {
            return ResponseResult.fail("反馈类型不能为空");
        }
        if (feedback.getContent() == null || feedback.getContent().trim().isEmpty()) {
            return ResponseResult.fail("反馈内容不能为空");
        }
        if (feedback.getContent().length() > 1000) {
            return ResponseResult.fail("反馈内容不能超过1000字");
        }

        // 3. 设置用户ID和提交时间
        feedback.setUserId(currentUser.getId());
        feedback.setCreateTime(new Date()); // 添加提交时间

        // 4. 调用Service层处理
        boolean success = feedbackService.submitFeedback(feedback);

        return success ?
                ResponseResult.success(feedback) :
                ResponseResult.fail("反馈提交失败，请稍后再试");
    }


    // 管理员开始处理反馈
    @PostMapping("/process/{feedbackId}")
    public ResponseResult<Feedback> startProcessing(
            @PathVariable Integer feedbackId,
            HttpSession session) {

        // 从Session获取当前管理员
        Admin currentAdmin = (Admin) session.getAttribute("admin");
        if(currentAdmin == null) {
            return ResponseResult.fail("请先登录管理员账号");
        }

        // 调用Service处理业务
        boolean success = feedbackService.startProcessing(
                feedbackId,
                currentAdmin.getId()
        );

        return success ?
                ResponseResult.success() :
                ResponseResult.fail("处理失败");
    }

    // 标记为已解决
    @PostMapping("/resolve/{feedbackId}")
    public ResponseResult<Feedback> markResolved(
            @PathVariable Integer feedbackId) {

        // 标记解决不需要管理员ID（可根据需求调整）
        boolean success = feedbackService.markResolved(feedbackId);
        return success ?
                ResponseResult.success() :
                ResponseResult.fail("操作失败");
    }

    // 获取反馈列表（带查询参数）
    @GetMapping("/list")
    public ResponseResult<List<Feedback>> list(FeedbackQuery query) {
        // 校验userId：若存在且非合法整数，返回错误
        if (query.getUserId() != null && query.getUserId() < 0) {
            return ResponseResult.fail("用户ID不能为负数");
        }
        System.out.println("startDate: " + query.getStartDate()); // 打印日期对象
        System.out.println("endDate: " + query.getEndDate());
        return ResponseResult.success(feedbackService.getFeedbackList(query));
    }

    // 删除反馈
    @DeleteMapping("/delete/{feedbackId}")
    public ResponseResult<Void> deleteFeedback(
            @PathVariable Integer feedbackId,
            HttpSession session) {

        // 删除操作需要管理员权限
        if(session.getAttribute("admin") == null) {
            return ResponseResult.fail("无操作权限");
        }

        return feedbackService.deleteFeedback(feedbackId) ?
                ResponseResult.success() :
                ResponseResult.fail("删除失败");
    }
    //批量删除
    @DeleteMapping("/batch-delete")
    public ResponseResult<Void> batchDeleteFeedback(
            @RequestParam List<Integer> feedbackIds,
            HttpSession session) {

        if (session.getAttribute("admin") == null) {
            return ResponseResult.fail("无操作权限");
        }

        return feedbackService.batchDeleteFeedback(feedbackIds) ?
                ResponseResult.success() :
                ResponseResult.fail("删除失败");
    }
}