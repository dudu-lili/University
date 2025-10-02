package com.redtourism.controller;

import com.redtourism.entity.User;
import com.redtourism.entity.Video;
import com.redtourism.service.VideoService;
import com.redtourism.util.ResponseResult;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
@RequestMapping("/video")
public class VideoController {

    @Autowired
    private VideoService videoService;

    @Autowired
    private HttpServletRequest request; // 新增：注入 HttpServletRequest 对象
    @GetMapping("/list")
    public ResponseResult<List<Video>> list(HttpSession session) {
        List<Video> videos = videoService.listAll();

        User user = (User) session.getAttribute("user");

        // 获取全局平均点赞数
        Double globalAvgLike = videoService.getAverageLikeCount();
        if (globalAvgLike == null) globalAvgLike = 0.0;

        // 设置贝叶斯参数
        double C = 10; // 可调参数，代表我们对全局平均的信任程度

        for (Video video : videos) {
            if (user != null && user.isActive()) {
                boolean hasLiked = videoService.checkIfUserLikedVideo(user.getId(), video.getId());
                video.setLiked(hasLiked);
            } else {
                video.setLiked(false); // 未登录用户默认不点赞
            }

            int likeCount = videoService.getLikeCount(video.getId());
            video.setLikeCount(likeCount);

            // 计算贝叶斯评分
            double localLike = likeCount;
            double score = (C * globalAvgLike + localLike) / (C + 1); // w=1，默认每个视频权重相同
            video.setScore(score);
        }

        // 按照贝叶斯评分从高到低排序
        Collections.sort(videos, (v1, v2) -> Double.compare(v2.getScore(), v1.getScore()));

        return ResponseResult.success(videos);
    }



    // 新增：按分类筛选视频
    @GetMapping("/listByCategory")
    public ResponseResult<List<Video>> listByCategory(@RequestParam String category) {
        List<Video> videos = videoService.listByCategory(category);
        return ResponseResult.success(videos);
    }

    // 新增：搜索视频
    @GetMapping("/search")
    public ResponseResult<List<Video>> searchVideos(@RequestParam String keyword) {
        List<Video> videos = videoService.searchVideos(keyword);
        return ResponseResult.success(videos);
    }

    @Configuration
    @EnableWebMvc
    public class CorsConfig implements WebMvcConfigurer {

        @Override
        public void addCorsMappings(CorsRegistry registry) {
            registry.addMapping("/video/**")
                    .allowedOrigins("http://localhost:8080") // 替换为你的前端地址
                    .allowCredentials(true)
                    .allowedMethods("GET", "POST", "PUT", "DELETE", "OPTIONS")
                    .allowedHeaders("*");
        }
    }

        @GetMapping("/{id}")
        public ResponseResult<Video> detail(@PathVariable Integer id, HttpSession session) {
            Video video = videoService.getById(id);

            if (video == null) {
                return ResponseResult.fail("视频不存在");
            }
            String userKey = "video_view_" + id;
                Object lastViewTimeObj = session.getAttribute(userKey);

                System.out.println("Session ID: " + session.getId());
                System.out.println("上次访问时间: " + lastViewTimeObj);

                long currentTime = System.currentTimeMillis();

                if (lastViewTimeObj == null || (currentTime - (Long) lastViewTimeObj) > 1800000) {
                    videoService.increaseViewCount(id);
                    session.setAttribute(userKey, currentTime);
                    System.out.println("✅ 已更新浏览数");
                } else {
                    System.out.println("🚫 未更新浏览数（30分钟内）");
                }
                User user = (User) session.getAttribute("user");

                // 设置点赞状态（如果用户已登录）
                if (user != null && user.isActive()) {
                    boolean hasLiked = videoService.checkIfUserLikedVideo(user.getId(), video.getId());
                    video.setLiked(hasLiked);
                } else {
                    video.setLiked(false); // 未登录用户默认不点赞
                }

                // 设置总点赞数
                int likeCount = videoService.getLikeCount(video.getId());
                video.setLikeCount(likeCount);

                return ResponseResult.success(video);
    }

    // 点赞视频
    @PostMapping("/like")
    public ResponseResult<Video> like(
            @RequestBody Map<String, Integer> requestData,
            HttpSession session) {

        Integer videoId = requestData.get("videoId");

        // 1. 检查用户是否登录
        User user = (User) session.getAttribute("user");
        if (user == null || !user.isActive()) {
            return ResponseResult.fail("用户未登录或已被禁用");
        }

        try {
            // 2. 查询当前视频
            Video video = videoService.getById(videoId);
            if (video == null) {
                return ResponseResult.fail("视频不存在");
            }

            // 3. 检查是否已点赞
            boolean hasLiked = videoService.checkIfUserLikedVideo(user.getId(), videoId);

            if (hasLiked) {
                // 取消点赞
                videoService.decreaseLikeCount(videoId);
                videoService.cancelUserLikeVideo(user.getId(), videoId);
            } else {
                // 点赞
                videoService.increaseLikeCount(videoId);
                videoService.recordUserLikeVideo(user.getId(), videoId);
            }

            // 4. 更新并返回最新状态
            video.setLiked(!hasLiked);
            video.setLikeCount(videoService.getLikeCount(videoId));

            return ResponseResult.success(video);
        } catch (Exception e) {
            return ResponseResult.fail("操作失败: " + e.getMessage());
        }
    }
    private static final String VIDEO_IMAGE_UPLOAD_DIR = "/assets/images/videos/";
    private static final String VIDEO_UPLOAD_DIR = "/assets/videos/";

    private String getRealUploadPath(String uploadDir) {
        String realPath = request.getServletContext().getRealPath(uploadDir);
        if (realPath == null) {
            realPath = System.getProperty("user.dir") + "/src/main/webapp" + uploadDir;
        }
        return realPath;
    }

    private String saveFile(MultipartFile file, String uploadDir) throws IOException {
        if (file == null || file.isEmpty()) {
            return null;
        }

        String uploadPath = getRealUploadPath(uploadDir);
        File uploadDirFile = new File(uploadPath);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }

        String originalFilename = file.getOriginalFilename();
        String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String fileName = UUID.randomUUID().toString() + fileExtension;

        File dest = new File(uploadPath + fileName);
        file.transferTo(dest);

        return uploadDir + fileName;
    }

    @PostMapping("/add")
    public ResponseResult<Void> addVideo(@RequestParam("title") String title,
                             @RequestParam("description") String description,
                             @RequestParam(value = "coverImage", required = false) MultipartFile coverImage,
                             @RequestParam(value = "videoFile", required = false) MultipartFile videoFile,
                             @RequestParam("category") String category) {
        try {
            // 打印日志，确保所有参数正确接收
            System.out.println("Received parameters: title=" + title + ", category=" + category);

            // 检查必要参数
            if (title == null || title.isEmpty()) {
                return ResponseResult.fail("视频标题不能为空");
            }
            if (category == null || category.isEmpty()) {
                return ResponseResult.fail("视频分类不能为空");
            }

            // 保存封面图片
            String coverImagePath = saveFile(coverImage, VIDEO_IMAGE_UPLOAD_DIR);
            if (coverImagePath == null) {
                return ResponseResult.fail("封面图片上传失败");
            }

            // 保存视频文件
            String videoPath = saveFile(videoFile, VIDEO_UPLOAD_DIR);
            if (videoPath == null) {
                return ResponseResult.fail("视频文件上传失败");
            }

            // 创建视频对象
            Video video = new Video();
            video.setTitle(title);
            video.setDescription(description);
            video.setCoverImage(coverImagePath);
            video.setVideoUrl(videoPath);
            video.setCategory(category);
            // 修改 createTime 的格式
            video.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));

            // 打印日志，确保视频对象正确创建
            System.out.println("Created video object: " + video);

            // 调用服务层添加视频
            videoService.addVideo(video);
            return ResponseResult.success();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.fail("添加视频失败: " + e.getMessage());
        }
    }

    @PostMapping("/update")
    public ResponseResult<Void> updateVideo(@RequestParam("id") Integer id,
                                    @RequestParam("title") String title,
                                    @RequestParam("description") String description,
                                    @RequestParam(value = "coverImage", required = false) MultipartFile coverImage,
                                    @RequestParam(value = "videoFile", required = false) MultipartFile videoFile,
                                    @RequestParam("category") String category) {
        try {
            Video video = videoService.getById(id);
            if (video == null) {
                return ResponseResult.fail("视频不存在");
            }

            if (coverImage != null && !coverImage.isEmpty()) {
                String coverImagePath = saveFile(coverImage, VIDEO_IMAGE_UPLOAD_DIR);
                video.setCoverImage(coverImagePath);
            }

            if (videoFile != null && !videoFile.isEmpty()) {
                String videoPath = saveFile(videoFile, VIDEO_UPLOAD_DIR);
                video.setVideoUrl(videoPath);
            }

            video.setTitle(title);
            video.setDescription(description);
            video.setCategory(category);

            videoService.updateVideo(video);
            return ResponseResult.success();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.fail("更新视频失败");
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseResult<Void> deleteVideo(@PathVariable Integer id) {
        try {
            videoService.deleteVideo(id);
            return ResponseResult.success();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.fail("删除视频失败");
        }
    }

    // 新增：获取相关视频
    @GetMapping("/{id}/related")
    public ResponseResult<List<Video>> getRelatedVideos(@PathVariable Integer id, HttpSession session) {
        Video currentVideo = videoService.getById(id);
        if (currentVideo == null) {
            return ResponseResult.fail("视频不存在");
        }

        User user = (User) session.getAttribute("user");

        List<Video> relatedVideos = videoService.getSameCategoryVideosExcludeSelf(id, currentVideo.getCategory());

        for (Video video : relatedVideos) {
            int likeCount = videoService.getLikeCount(video.getId());
            video.setLikeCount(likeCount);

            if (user != null && user.isActive()) {
                boolean hasLiked = videoService.checkIfUserLikedVideo(user.getId(), video.getId());
                video.setLiked(hasLiked);
            } else {
                video.setLiked(false);
            }
        }

        return ResponseResult.success(relatedVideos);
    }


    @Data
    private static class BatchDeleteRequest {
        private List<Integer> videoIds;
    }

    @PostMapping("/batch-delete")
    public ResponseResult<Void> batchDelete(@RequestBody BatchDeleteRequest request) {
        if (request.getVideoIds() == null || request.getVideoIds().isEmpty()) {
            return ResponseResult.fail("请选择要删除的视频");
        }
        try {
            videoService.batchDelete(request.getVideoIds());
            return ResponseResult.success();
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.fail("批量删除视频失败");
        }
    }
    @GetMapping("/status/{id}")
    public ResponseResult<Map<String, Object>> getVideoStatus(@PathVariable Integer id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        Map<String, Object> status = new HashMap<>();

        int likeCount = videoService.getLikeCount(id);
        status.put("likeCount", likeCount);

        if (user != null && user.isActive()) {
            boolean liked = videoService.checkIfUserLikedVideo(user.getId(), id);
            status.put("liked", liked);
        } else {
            status.put("liked", false);
        }

        return ResponseResult.success(status);
    }
}