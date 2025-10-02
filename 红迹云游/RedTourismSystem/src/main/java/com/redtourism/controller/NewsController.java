package com.redtourism.controller;

import com.redtourism.entity.News;
import com.redtourism.entity.User;
import com.redtourism.service.NewsService;
import com.redtourism.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;
import java.io.File;
//添加报错异常
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/news")
public class NewsController {

    @Autowired
    private NewsService newsService;

    @Autowired
    private HttpServletRequest request;
//报错机制
    private static final Logger logger = LoggerFactory.getLogger(NewsController.class);

    // 图片上传路径配置
    private static final String NEWS_UPLOAD_DIR = "/assets/images/news/";
    private static final String NEWS_ACCESS_PATH = "assets/images/news/";

    // 获取web应用真实路径
    private String getRealUploadPath() {
        String realPath = request.getServletContext().getRealPath(NEWS_UPLOAD_DIR);
        if (realPath == null) {
            realPath = System.getProperty("user.dir") + "/src/main/webapp" + NEWS_UPLOAD_DIR;
        }
        return realPath;
    }

    // 获取所有新闻列表,添加报错机制
    @GetMapping("/list")
    public ResponseResult<List<News>> list() {
        try {
            List<News> list = newsService.listAll();
            System.out.println("成功获取新闻列表，数据条数：" + list.size()+"详情"+list);
            logger.info("成功获取新闻列表，数据条数：{}", list.size());
            return ResponseResult.success(list);

        }catch (Exception e){
            logger.error("获取新闻列表失败",e);
            return ResponseResult.fail("新闻列表失败: " + e.getMessage());
        }

    }

    // 获取热门新闻
    @GetMapping("/top")
    public ResponseResult<List<News>> topNews(
            @RequestParam(defaultValue = "10") int limit) {
        List<News> topNews = newsService.listTopNews(limit);
        return ResponseResult.success(topNews);
    }

    // 获取新闻详情
    @GetMapping("/{id}")
    public ResponseResult<News> detail(@PathVariable Integer id) {
        News news = newsService.getById(id);
        if (news == null) {
            return ResponseResult.fail("新闻不存在");
        }
        return ResponseResult.success(news);
    }

    //新闻浏览次数接口
    @PostMapping("/increaseViewCount/{id}")
    public ResponseResult<Map<String, Object>> viewNews(
            @RequestBody Map<String, Integer> requestData,
            HttpSession session
    ) {
        Integer newsId = requestData.get("newsId");
        User user = (User) session.getAttribute("user");

        if (user == null || !user.isActive()) {
            return ResponseResult.fail("用户未登录或已被禁用");
        }

        //2.从Session中获取用户浏览记录
        Map<Integer, Long> viewedNews = (Map<Integer, Long>) session.getAttribute("viewedNews");
        if (viewedNews == null) {
            viewedNews = new HashMap<>();
        }

        //3.检查是否已浏览且未超过半小时
        Long lastViewedTime = viewedNews.get(newsId);
        if (lastViewedTime != null && System.currentTimeMillis() - lastViewedTime < 30 * 60 * 1000) {
            int viewCount = newsService.getViewCount(newsId);
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("viewed", true);
            responseData.put("viewCount", viewCount);
            return ResponseResult.success(responseData);
        }

        try {
            //4.执行浏览逻辑
            newsService.increaseViewCount(newsId);
            int viewCount = newsService.getViewCount(newsId);

            //5.更新Session中的浏览记录
            viewedNews.put(newsId, System.currentTimeMillis());
            session.setAttribute("viewedNews", viewedNews);

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("viewed", true);
            responseData.put("viewCount", viewCount);

            return ResponseResult.success(responseData);
        } catch (Exception e) {
            return ResponseResult.fail("浏览记录更新失败: " + e.getMessage());
        }
    }
    // 新增新闻
    @PostMapping("/add")
    public ResponseResult<Void> addNews(
            @RequestParam("title") String title,
            @RequestParam("coverImage") MultipartFile coverImage,
            @RequestParam("source") String source,
            @RequestParam("content") String content,
            @RequestParam("article") String article,
            @RequestParam("author") String author,
            @RequestParam("publishTime") String publishTime) {
        try {
            News news = new News();
            news.setTitle(title);
            news.setSource(source);
            news.setContent(content);
            news.setArticle(article);
            news.setAuthor(author);
            news.setPublishTime(publishTime);



            news.setViewCount(0);

            // 处理封面图片
            if (!coverImage.isEmpty()) {
                String fileName = StringUtils.cleanPath(coverImage.getOriginalFilename());
                System.out.println("Original Filename: " + coverImage.getOriginalFilename());
                System.out.println("Cleaned Filename: " + fileName);

                // 检查文件名是否为空或无效
                if (fileName == null || fileName.isEmpty()) {
                    throw new IllegalArgumentException("文件名无效");
                }
            }
                String coverImagePath = saveImage(coverImage);
                news.setCoverImage(NEWS_ACCESS_PATH + coverImagePath);

//            news.setCoverImage(coverImage.getBytes()); // 直接存储二进制数据


            newsService.addNews(news);
            return ResponseResult.success("新闻添加成功");
        } catch (IOException e) {
            //错误机制
            logger.error("图片处理失败", e);
            return ResponseResult.fail("图片处理失败: " + e.getMessage());
        }catch (Exception e) {
            //错误机制
            logger.error("添加新闻失败", e);
            return ResponseResult.fail("添加新闻失败: " + e.getMessage());
        }
    }

    // 更新新闻
    @PostMapping("/update")
    public ResponseResult<String> updateNews(
            @RequestParam("id") Integer id,
            @RequestParam("title") String title,
            @RequestParam("source") String source,
            @RequestParam("content") String content,
            @RequestParam("article") String article,
            @RequestParam("author") String author,
            @RequestParam("publishTime") String publishTime,
            @RequestParam(value = "coverImage", required = false) MultipartFile coverImage) {
        try {
            News news = new News();
            news.setId(id);
            news.setTitle(title);
            news.setSource(source);
            news.setContent(content);
            news.setArticle(article);
            news.setAuthor(author);
            news.setPublishTime(publishTime);

//             处理封面图片
            if (coverImage != null && !coverImage.isEmpty()) {
                String coverImagePath = saveImage(coverImage);
                news.setCoverImage(NEWS_ACCESS_PATH + coverImagePath);
            }

            int result = newsService.updateNews(news);
            if (result > 0) {
                return ResponseResult.success("新闻更新成功");
            } else {
                return ResponseResult.fail("数据库更新失败");
            }
        } catch (Exception e) {
            logger.error("更新新闻失败", e);
            return ResponseResult.fail("更新失败: " + e.getMessage());
        }
    }

    // 删除新闻
    @DeleteMapping("/delete/{id}")
    public ResponseResult<Void> deleteNews(@PathVariable Integer id) {
        try {
            News news = newsService.getById(id);
            if (news == null) {
                return ResponseResult.fail("新闻不存在");
            }

            // 直接删除路线，不需要单独处理图片
            newsService.deleteNews(id);
            return ResponseResult.success("新闻删除成功");
        } catch (Exception e) {
            return ResponseResult.fail("删除新闻失败: " + e.getMessage());
        }
    }
    // 保存图片到服务器
    private String saveImage(MultipartFile file) throws IOException {
        String uploadDir = getRealUploadPath();
        // 确保上传目录存在
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }

        // 生成唯一文件名
        String originalFilename = file.getOriginalFilename();
        String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String fileName = UUID.randomUUID().toString() + fileExtension;

        // 保存文件
        File dest = new File(uploadDir + fileName);
        file.transferTo(dest);

        return fileName;
    }

    // 删除图片
    private void deleteImage(String imageUrl) {
        try {
            // 从完整URL中提取文件名
            String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
            String uploadDir = getRealUploadPath();
            File file = new File(uploadDir + fileName);
            if (file.exists()) {
                file.delete();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @PostMapping("/batch-delete")
    public ResponseResult<Void> batchDeleteNews(@RequestBody Map<String, List<Integer>> request) {
        try {
            List<Integer> newsIds = request.get("newsIds");
            if (newsIds == null || newsIds.isEmpty()) {
                return ResponseResult.fail("请选择要删除的新闻");
            }

            newsService.batchDeleteNews(newsIds);
            return ResponseResult.success();
        } catch (Exception e) {
            return ResponseResult.fail("批量删除失败: " + e.getMessage());
        }
    }
}