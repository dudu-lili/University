package com.redtourism.controller;

import com.redtourism.entity.Comment;
import com.redtourism.entity.User;
import com.redtourism.service.CommentService;
import com.redtourism.service.UserService;
import com.redtourism.util.ResponseResult;
import com.redtourism.util.SensitiveWordFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping({"/comment"})
public class CommentController {
    @Autowired
    private CommentService commentService;

    @Autowired
    private UserService userService;

    @Autowired
    private SensitiveWordFilter sensitiveWordFilter = new SensitiveWordFilter();

    public CommentController() {
        sensitiveWordFilter = new SensitiveWordFilter();
    }

    @GetMapping("/getAll")
    public ResponseResult<List<Comment>> getAllComments() {
        try {
            List<Comment> comments = commentService.getAllComments();
            return ResponseResult.success(comments);
        } catch (Exception e) {
            return ResponseResult.fail("获取评论失败: " + e.getMessage());
        }
    }
    @DeleteMapping("/delete/{id}")
    public ResponseResult<Void> deleteComment(@PathVariable Integer id) {
        try {
            commentService.delete(id);
            return ResponseResult.success("评论删除成功");
        } catch (Exception e) {
            return ResponseResult.fail("评论删除失败: " + e.getMessage());
        }
    }
    @PostMapping({"/add"})
    public ResponseResult<Void> addComment(@RequestBody Comment comment, HttpSession session) {
        User user = (User)session.getAttribute("user");

        if (user == null || !user.isActive()) {
            return ResponseResult.fail("用户未登录或已被禁用");
        } else {
            System.out.println(comment);
            comment.setUserId(user.getId());
            comment.setCreateTime(new Date());
            // 敏感词检查
            if (sensitiveWordFilter.contains(comment.getContent())) {
                return ResponseResult.fail("该评论包含敏感词!");
            }
            comment.setUserId(user.getId());
            comment.setCreateTime(new Date());

            try {
                System.out.println("111"+comment);
                this.commentService.add(comment);
                return ResponseResult.success("评论成功");
            } catch (Exception var5) {
                return ResponseResult.fail("评论失败: " + var5.getMessage());
            }
        }
    }

    @GetMapping({"/list"})
    public ResponseResult<List<Comment>> getCommentList(@RequestParam Integer routeId) {
        try {
            List<Comment> comments = this.commentService.getCommentsByRouteId(routeId);
            return ResponseResult.success(comments);
        } catch (Exception var3) {
            return ResponseResult.fail("获取评论失败: " + var3.getMessage());
        }
    }

    @DeleteMapping({"/{id}"})
    public ResponseResult<Void> delete(@PathVariable Integer id, HttpSession session) {
        this.commentService.delete(id);
        User user = (User)session.getAttribute("user");
        List<Comment> commentList = this.commentService.listByUserId(user.getId());
        session.setAttribute("commentList", commentList);
        return ResponseResult.success();
    }
    //获取路线评论列表
    @GetMapping("/formattedList/{routeId}")
    public ResponseResult<String> getFormattedComments(@PathVariable Integer routeId) {
        try {
            List<Comment> comments = commentService.getCommentsByRouteId(routeId);
            for (Comment comment : comments) {
                System.out.println(comment.toString());
            }
            String formattedHtml = formatCommentsToHtml(comments);

            return ResponseResult.success(formattedHtml);
        } catch (Exception e) {
            return ResponseResult.fail("获取评论失败: " + e.getMessage());
        }
    }

    private String formatCommentsToHtml(List<Comment> comments) {
        if (comments == null || comments.isEmpty()) {
            return "<div class='text-center py-4 text-muted'>暂无评论</div>";
        }

        StringBuilder sb = new StringBuilder();
        sb.append("<div class='list-group'>");

        for (Comment comment : comments) {
            Integer userId = comment.getUserId();
            String username = userService.getUsernameById(userId); // 调用UserService获取用户名
            if (username == null) {
                username = "匿名用户";
            }
            sb.append("<div class='list-group-item comment-item'>")
                    .append("<div class='d-flex justify-content-between align-items-center mb-2 comment-header'>")
                    .append("<strong class='username text-primary'>")
                    .append(username)
                    .append("</strong>")
                    .append("<small class='timestamp text-muted'>")
                    .append(formatDate(comment.getCreateTime()))
                    .append("</small>")
                    .append("</div>")
                    .append("<p class='comment-content text-dark mb-1'>")
                    .append(comment.getContent())
                    .append("</p>")
                    .append("</div>");

        }

        sb.append("</div>");
        return sb.toString();
    }


    private String formatDate(Date date) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        return sdf.format(date);
    }
    @GetMapping("/scenic/{scenicId}")
    public ResponseResult<List<Comment>> listByScenic(@PathVariable Integer scenicId) {
        List<Comment> comments = this.commentService.listByScenicId(scenicId);
        return ResponseResult.success(comments);
    }

    @GetMapping("/scenic/formattedList/{scenicId}")
    public ResponseResult<String> getFormattedScenicComments(@PathVariable Integer scenicId) {
        try {
            List<Comment> comments = commentService.getCommentsByScenicId(scenicId);
            String formattedHtml = formatCommentsToHtml(comments);
            return ResponseResult.success(formattedHtml);
        } catch (Exception e) {
            return ResponseResult.fail("获取评论失败: " + e.getMessage());
        }
    }
    @GetMapping("study/{studyId}")
    public ResponseResult<List<Comment>> listByStudy(@PathVariable Integer studyId) {
        List<Comment> comments = this.commentService.listByStudyId(studyId);
        return ResponseResult.success(comments);
    }

    @GetMapping("study/formattedList/{studyId}")
    public ResponseResult<String> getFormattedStudyComments(@PathVariable Integer studyId) {
        try {
            List<Comment> comments = commentService.getCommentsByStudyId(studyId);
            String formattedHtml = formatCommentsToHtml(comments);
            return ResponseResult.success(formattedHtml);
        } catch (Exception e) {
            e.printStackTrace(); // 打印堆栈信息
            return ResponseResult.fail("获取评论失败: " + (e.getMessage() != null ? e.getMessage() : "未知错误"));
        }
    }


    @GetMapping("travelNotes/{travelNotesId}")
    public ResponseResult<List<Comment>> listByTravelNotes(@PathVariable Integer travelNotesId) {
        List<Comment> comments = this.commentService.listByTravelNotesId(travelNotesId);
        return ResponseResult.success(comments);
    }

    @GetMapping("travelNotes/formattedList/{travelNotesId}")
    public ResponseResult<String> getFormattedTravelNotesComments(@PathVariable Integer travelNotesId) {
        try {
            List<Comment> comments = commentService.getCommentsByTravelNotesId(travelNotesId);
            String formattedHtml = formatCommentsToHtml(comments);
            return ResponseResult.success(formattedHtml);
        } catch (Exception e) {
            e.printStackTrace(); // 打印堆栈信息
            return ResponseResult.fail("获取评论失败: " + (e.getMessage() != null ? e.getMessage() : "未知错误"));
        }
    }

    // ... existing code ...

    @PostMapping("/batch-delete")
    public ResponseResult<Void> batchDeleteComments(@RequestBody Map<String, List<Integer>> request) {
        try {
            List<Integer> commentIds = request.get("commentIds");
            if (commentIds == null || commentIds.isEmpty()) {
                return ResponseResult.fail("请选择要删除的评论");
            }

            commentService.batchDelete(commentIds);
            return ResponseResult.success("批量删除成功");
        } catch (Exception e) {
            return ResponseResult.fail("批量删除失败: " + e.getMessage());
        }
    }

// ... existing code ...

}