package com.redtourism.controller;

import com.redtourism.entity.*;
import com.redtourism.service.*;
import com.redtourism.service.impl.ScenicServiceImpl;
import com.redtourism.util.ResponseResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/guest")
public class GuestController {

    @Autowired
    private ScenicService scenicService;
    @Autowired
    private RouteService routeService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private RedGeocodingService redGeocodingService;

    @Autowired
    private HttpServletRequest request;
    //研学
    @Autowired
    private StudyService studyService;
    //新闻
    @Autowired
    private  NewsService newsService;
    @Autowired
    private UserService userService;

    //报错机制
    private static final Logger logger = LoggerFactory.getLogger(NewsController.class);

    // 获取排名前十的景点
    @GetMapping("/scenic-top8")
    public ResponseResult<List<ScenicSpot>> getTop10Scenics() {
        List<ScenicSpot> topScenics = scenicService.listTopScenics(8);
        return ResponseResult.success(topScenics);
    }
    // 获取排名前十的路线
    @GetMapping("/routes-top8")
    public ResponseResult<List<TravelRoute>> getTop10Routes() {
        List<TravelRoute> topRoutes = routeService.listTopRoutes(8);
        return ResponseResult.success(topRoutes);
    }

    @GetMapping("/red-geocoding-info")
    public ResponseResult<Map<String, Object>> getRedGeocodingInfo() {
        // 地图坐标信息
        List<Geocoding> points = redGeocodingService.getAllRedScenics();

        // 每个省份的景点数据统计
        List<Map<String, Object>> counts = redGeocodingService.getProvinceCounts();

        Map<String, Object> resultMap = new java.util.HashMap<>();
        resultMap.put("points", points);
        resultMap.put("counts", counts);

        return ResponseResult.success(resultMap);
    }


    // 获取景点详情
    @GetMapping("/scenic/{id}")
    public ResponseResult<ScenicSpot> senicdetail(@PathVariable Integer id) {
        ScenicSpot scenicSpot = scenicService.getById(id);
        return ResponseResult.success(scenicSpot);
    }
    // 获取路线详情
    @GetMapping("/route/{id}")
    public ResponseResult<TravelRoute> routedetail(@PathVariable Integer id) {
        TravelRoute route = routeService.getByIdWithScenics(id);
        return ResponseResult.success(route);
    }

    // 获取所有景点列表
    @GetMapping("/scenic-list")
    public ResponseResult<List<ScenicSpot>> scenic_list() {
        List<ScenicSpot> list = scenicService.listAll();
        return ResponseResult.success(list);
    }

    // 获取所有路线列表
    @GetMapping("/route-list")
    public ResponseResult<List<TravelRoute>> tout_list() {
        List<TravelRoute> list = routeService.listAll();
        return ResponseResult.success(list);
    }

    //景点/路线-评论
    @GetMapping("/formattedList/{routeId}")
    public ResponseResult<String> getFormattedComments(@PathVariable Integer routeId) {
        try {
            // 通过服务层根据路线ID查询评论列表
            List<Comment> comments = commentService.getCommentsByRouteId(routeId);
            // 遍历评论并打印到控制台（调试用）
            for (Comment comment : comments) {
                System.out.println(comment.toString());
            }
            // 将评论列表格式化为HTML字符串
            String formattedHtml = formatCommentsToHtml(comments);
            // 返回成功响应及HTML数据
            return ResponseResult.success(formattedHtml);
        } catch (Exception e) {
            // 异常处理：返回错误信息
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
        // 定义日期格式
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        // 格式化日期对象为字符串
        return sdf.format(date);
    }
    @GetMapping("/comment/scenic/{scenicId}")
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
    //获取研学列表
    @GetMapping("/study-list")
    public ResponseResult<List<Study>> study_list() {
        List<Study> studyList = studyService.listTopStudy(300);
        return ResponseResult.success(studyList);
    }
    //获取研学详情
    @GetMapping("/study/{id}")
    public ResponseResult<Study> studydetail(@PathVariable Integer id) {
        Study study = studyService.getById(id);
        return ResponseResult.success(study);

    }
    @GetMapping("/study/comment/{studyId}")
    public ResponseResult<List<Comment>> listByStudy(@PathVariable Integer studyId) {
        List<Comment> comments = this.commentService.listByStudyId(studyId);
        return ResponseResult.success(comments);
    }

    @GetMapping("/study/formattedList/{studyId}")
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
//新闻controller
    @GetMapping("/news-list")
    public ResponseResult<List<News>> list() {
        try {
            List<News> news = newsService.listAll();
            System.out.println("成功获取新闻列表，数据条数：" + news.size()+"详情"+news);
            logger.info("成功获取新闻列表，数据条数：{}", news.size());
            return ResponseResult.success(news);

        }catch (Exception e){
            logger.error("获取新闻列表失败",e);
            return ResponseResult.fail("新闻列表失败: " + e.getMessage());
        }

    }
    // 获取新闻详情
    @GetMapping("/news/{id}")
    public ResponseResult<News> newsdetail(@PathVariable Integer id) {
        News news = newsService.getById(id);
        if (news == null) {
            return ResponseResult.fail("新闻不存在");
        }
//
        return ResponseResult.success(news);
    }


}