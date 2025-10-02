//package com.redtourism.controller;
//
//
//import com.redtourism.entity.Study;
//import com.redtourism.service.CommentService;
//import com.redtourism.service.StudyService;
//import com.redtourism.service.impl.StudyServiceImpl;
//import com.redtourism.util.ResponseResult;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.*;
//import org.springframework.web.multipart.MultipartFile;
//
//import javax.servlet.http.HttpServletRequest;
//import java.io.File;
//import java.io.IOException;
//import java.net.URISyntaxException;
//import java.nio.file.Paths;
//import java.util.List;
//import java.util.UUID;
//
//@RestController
//@RequestMapping("/study")
//public class StudyController {
//    @Autowired
//    private StudyService studyService;
//    @Autowired
//    private CommentService commentService;
//    @Autowired
//    private StudyServiceImpl studyServiceImpl;
//
//
//
//    @Autowired
//    private HttpServletRequest request;
//    //硬编码图片上传路径和访问路径
//    private static final String STUDY_UPLOAD_DIR = "/assets/images/study/";
//    private static final String STUDY_ACCESS_PATH = "assets/images/study/";
//
//    //获取web应用真实路径
//    private String getRealUploadPath() {
//        String realPath = request.getServletContext().getRealPath(STUDY_UPLOAD_DIR);
//        //如果获取不到真实路径，使用相对路径（开发环境可能如此）
//        if (realPath == null) {
//            realPath = System.getProperty("user.dir") + "/src/main/webapp" + STUDY_UPLOAD_DIR;
//        }
//        return realPath;
//    }
//
//    //获取所有列表
//    @GetMapping("/list")
//    public ResponseResult<List<Study>> list() {
//        List<Study> list = studyService.listAll();
//        return ResponseResult.success(list);
//    }
//
//    //获取详情
//    @GetMapping("/{id}")
//    public ResponseResult<Study> detail(@PathVariable Integer id) {
//        Study studySpot = studyService.getById(id);
//        return ResponseResult.success(studySpot);
//    }
//
//
//    @DeleteMapping("/delete/{id}")
//    public ResponseResult<Void> deleteStudySpot(@PathVariable Integer id) {
//        try {
//            Study spot = studyService.getById(id);
//            if (spot == null) {
//                return ResponseResult.fail("内容不存在");
//            }
//
//            //删除封面图片
//            if (spot.getCoverImage() != null) {
//                deleteImage(spot.getCoverImage());
//            }
//
//            studyService.deleteStudy(id);
//            return ResponseResult.success("内容删除成功");
//        } catch (Exception e) {
//            return ResponseResult.fail("删除内容失败: " + e.getMessage());
//        }
//    }
//
//
//    @PostMapping("/add")
//    public ResponseResult<Void> addStudy(
//            @RequestParam("id") Integer id,
//            @RequestParam("title") String title,
//            @RequestParam(value = "coverImage", required = false) MultipartFile coverImage,
//            @RequestParam("content") String content,
//            @RequestParam("likes") Integer likes,
//            @RequestParam("source") String source,
//            @RequestParam("author") String author,
//            @RequestParam("time") String time
//    ) {
//        try {
//            Study spot = new Study();
//            spot.setId(id);
//            spot.setTitle(title);
//            spot.setContent(content);
//            spot.setLikes(likes);
//            spot.setSource(source);
//            spot.setAuthor(author);
//            spot.setTime(time);
//
//            if (coverImage != null && !coverImage.isEmpty()) {
//                String fileName = saveImage(coverImage);
//                spot.setCoverImage(STUDY_ACCESS_PATH + fileName);
//            }
//
//            studyService.addStudy(spot);
//            return ResponseResult.success("内容添加成功");
//        } catch (Exception e) {
//            return ResponseResult.fail("添加内容失败: " + e.getMessage());
//        }
//    }
//
//    // 更新景点
//    @PostMapping("/update")
//    public ResponseResult<Void> updateStudy(
//            @RequestParam("id") Integer id,
//            @RequestParam("title") String title,
//            @RequestParam(value = "coverImage", required = false) MultipartFile coverImage,
//            @RequestParam("content") String content,
//            @RequestParam("likes") Integer likes,
//            @RequestParam("source") String source,
//            @RequestParam("author") String author,
//            @RequestParam("time") String time
//    ) {
//        try {
//            Study spot = studyService.getById(id);
//            if (spot == null) {
//                return ResponseResult.fail("内容不存在");
//            }
//
//            spot.setTitle(title);
//            spot.setContent(content);
//            spot.setLikes(likes);
//            spot.setSource(source);
//            spot.setAuthor(author);
//            spot.setTime(time);
//
//            if (coverImage != null && !coverImage.isEmpty()) {
//                // 删除旧图片
//                if (spot.getCoverImage() != null) {
//                    deleteImage(spot.getCoverImage());
//                }
//                // 保存新图片
//                String fileName = saveImage(coverImage);
//                spot.setCoverImage(STUDY_ACCESS_PATH + fileName);
//            }
//
//            studyService.updateStudy(spot);
//            return ResponseResult.success("内容更新成功");
//        } catch (Exception e) {
//            return ResponseResult.fail("更新内容失败: " + e.getMessage());
//        }
//    }
//
//    // 保存图片到服务器
//    private String saveImage(MultipartFile file) throws IOException, URISyntaxException {
//        String uploadDir = getRealUploadPath();
//        // 确保上传目录存在
//        File uploadDirFile = new File(uploadDir);
//        if (!uploadDirFile.exists()) {
//            uploadDirFile.mkdirs();
//        }
//
//        // 生成唯一文件名
//        String originalFilename = file.getOriginalFilename();
//        String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
//        String fileName = UUID.randomUUID().toString() + fileExtension;
//
//        // 保存文件
//        File dest = new File(uploadDir + fileName);
//        file.transferTo(dest);
//
//        return fileName;
//    }
//
//    // 删除图片
//    private void deleteImage(String imageUrl) {
//        try {
//            // 从完整URL中提取文件名
//            String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
//            String uploadDir = getRealUploadPath();
//            File file = new File(uploadDir + fileName);
//            if (file.exists()) {
//                file.delete();
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//
//
//}
//
//


package com.redtourism.controller;
//
//import com.redtourism.entity.Study;
//import com.redtourism.entity.User;
//import com.redtourism.service.StudyService;
//import com.redtourism.util.ResponseResult;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.*;
//import org.springframework.web.multipart.MultipartFile;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;
//import java.io.File;
//import java.io.IOException;
//import java.net.URISyntaxException;
//import java.nio.file.Paths;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//import java.util.UUID;
//
//@RestController
//@RequestMapping("/study")
//public class StudyController {
//    @Autowired
//    private StudyService studyService;
//
//    @Autowired
//    private HttpServletRequest request;
//
//    private static final String STUDY_UPLOAD_DIR = "/assets/images/study/";
//    private static final String STUDY_ACCESS_PATH = "assets/images/study/";
//
//    private String getRealUploadPath() {
//        String realPath = request.getServletContext().getRealPath(STUDY_UPLOAD_DIR);
//        if (realPath == null) {
//            realPath = System.getProperty("user.dir") + "/src/main/webapp" + STUDY_UPLOAD_DIR;
//        }
//        return realPath;
//    }
//    //获取所有列表
//    @GetMapping("/list")
//    public ResponseResult<List<Study>> list() {
//        List<Study> list = studyService.listAll();
//        return ResponseResult.success(list);
//    }
//    //获取详情
//    @GetMapping("/{id}")
//    public ResponseResult<Study> detail(@PathVariable Integer id) {
//        Study study = studyService.getById(id);
//        return ResponseResult.success(study);
//    }
//
//
//    //点赞景点
//    @PostMapping("/like")
//    public ResponseResult<Map<String, Object>> like(
//            @RequestBody Map<String, Integer> requestData,
//            HttpSession session) {
//
//        Integer studyId = requestData.get("studyId");
//
//        //1.检查用户是否登录
//        User user = (User) session.getAttribute("user");
//        if (user == null) {
//            return ResponseResult.fail(401, "请先登录");
//        }
//
//        //2.从session获取点赞记录
//        Map<Integer, Long> likedStudy = (Map<Integer, Long>) session.getAttribute("likedStudy");
//        if (likedStudy == null) {
//            likedStudy = new HashMap<>();
//        }
//
//        //3.检查是否已点赞过
//        Long lastLikedTime = likedStudy.get(studyId);
//        if (lastLikedTime != null) {
//            //计算时间差（毫秒）
//            long timeDiff = System.currentTimeMillis() - lastLikedTime;
//            //24小时=86400000毫秒
//            if (timeDiff < 86400000) {
//                int likeCount = studyService.getLikeCount(studyId);
//                Map<String, Object> responseData = new HashMap<>();
//                responseData.put("liked", false);
//                responseData.put("likeCount", likeCount);
//                return ResponseResult.fail("一天内只能点赞一次");
//            }
//        }
//
//        try {
//            //4.执行点赞
//            studyService.increaseLikeCount(studyId);
//            int likeCount = studyService.getLikeCount(studyId);
//
//            //5.更新session记录
//            likedStudy.put(studyId, System.currentTimeMillis());
//            session.setAttribute("likedStudy", likedStudy);
//
//            Map<String, Object> responseData = new HashMap<>();
//            responseData.put("liked", true);
//            responseData.put("likeCount", likeCount);
//
//            return ResponseResult.success(responseData);
//        } catch (Exception e) {
//            return ResponseResult.fail("点赞失败: " + e.getMessage());
//        }
//    }
//
//
//    @DeleteMapping("/delete/{id}")
//    public ResponseResult<Void> deleteStudySpot(@PathVariable Integer id) {
//        try {
//            Study spot = studyService.getById(id);
//            if (spot == null) {
//                return ResponseResult.fail("内容不存在");
//            }
//
//            if (spot.getCoverImage() != null) {
//                deleteImage(spot.getCoverImage());
//            }
//
//            studyService.deleteStudy(id);
//            return ResponseResult.success("内容删除成功");
//        } catch (Exception e) {
//            return ResponseResult.fail("删除内容失败: " + e.getMessage());
//        }
//    }
//
//    @PostMapping("/add")
//    public ResponseResult<Void> addStudySpot(
////            @RequestParam(value = "id", required = false) Integer id,
//            @RequestParam(value = "title", required = false) String title,
//            @RequestParam(value = "coverImage", required = false) MultipartFile coverImage,
//            @RequestParam(value = "content", required = false) String content,
////            @RequestParam(value = "likeCount", required = false) Integer likeCount,
//            @RequestParam(value = "source", required = false) String source,
//            @RequestParam(value = "author", required = false) String author,
//            @RequestParam(value = "time", required = false) String time
//    ) {
//        try {
//            Study spot = new Study();
////            spot.setId(id);
//            spot.setTitle(title);
//            spot.setContent(content);
//            spot.setLikeCount(0);
//            spot.setSource(source);
//            spot.setAuthor(author);
//            spot.setTime(time);
//
//            if (coverImage != null && !coverImage.isEmpty()) {
//                String fileName = saveImage(coverImage);
//                spot.setCoverImage(STUDY_ACCESS_PATH + fileName);
//            }
//
//            studyService.addStudy(spot);
//            return ResponseResult.success("内容添加成功");
//        } catch (Exception e) {
//            return ResponseResult.fail("添加内容失败: " + e.getMessage());
//        }
//    }
//
//    @PostMapping("/update")
//    public ResponseResult<Void> updateStudySpot(
//            @RequestParam("id") Integer id,
//            @RequestParam("title") String title,
//            @RequestParam("author") String author,
//            @RequestParam("content") String content,
//            @RequestParam("likeCount") Integer likeCount,
//            @RequestParam("source") String source,
//            @RequestParam("time") String time,
//            @RequestParam(value = "coverImage", required = false) MultipartFile coverImage
//    ) {
//        try {
//            Study spot = studyService.getById(id);
//            if (spot == null) {
//                return ResponseResult.fail("内容不存在");
//            }
//
//            spot.setTitle(title);
//            spot.setContent(content);
//            spot.setLikeCount(likeCount);
//            spot.setSource(source);
//            spot.setAuthor(author);
//            spot.setTime(time);
//
//            if (coverImage != null && !coverImage.isEmpty()) {
//                if (spot.getCoverImage() != null) {
//                    deleteImage(spot.getCoverImage());
//                }
//                String fileName = saveImage(coverImage);
//                spot.setCoverImage(STUDY_ACCESS_PATH + fileName);
//            }
//
//            studyService.updateStudy(spot);
//            return ResponseResult.success("内容更新成功");
//        } catch (Exception e) {
//            return ResponseResult.fail("更新内容失败: " + e.getMessage());
//        }
//    }
//
//    private String saveImage(MultipartFile file) throws IOException, URISyntaxException {
//        String uploadDir = getRealUploadPath();
//        File uploadDirFile = new File(uploadDir);
//        if (!uploadDirFile.exists()) {
//            uploadDirFile.mkdirs();
//        }
//
//        String originalFilename = file.getOriginalFilename();
//        String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
//        String fileName = UUID.randomUUID().toString() + fileExtension;
//
//        File dest = new File(uploadDir + fileName);
//        file.transferTo(dest);
//
//        return fileName;
//    }
//
//    private void deleteImage(String imageUrl) {
//        try {
//            String fileName = imageUrl.substring(imageUrl.lastIndexOf("/") + 1);
//            String uploadDir = getRealUploadPath();
//            File file = new File(uploadDir + fileName);
//            if (file.exists()) {
//                file.delete();
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//}





import com.redtourism.entity.Study;
import com.redtourism.entity.User;
import com.redtourism.service.CommentService;
import com.redtourism.service.StudyService;
import com.redtourism.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/study")
public class StudyController {
    @Autowired
    private StudyService studyService;

    @Autowired
    private HttpServletRequest request;

    @Autowired
    CommentService commentService;

    private static final String STUDY_UPLOAD_DIR = "/assets/images/study/";
    private static final String STUDY_ACCESS_PATH = "assets/images/study/";

    private String getRealUploadPath() {
        String realPath = request.getServletContext().getRealPath(STUDY_UPLOAD_DIR);
        if (realPath == null) {
            realPath = System.getProperty("user.dir") + "/src/main/webapp" + STUDY_UPLOAD_DIR;
        }
        return realPath;
    }

    // 获取所有列表
    @GetMapping("/list")
    public ResponseResult<List<Study>> list() {
        List<Study> list = studyService.listAll();
        return ResponseResult.success(list);
    }

    // 获取详情
    @GetMapping("/{id}")
    public ResponseResult<Study> detail(@PathVariable Integer id) {
        Study study = studyService.getById(id);
        return ResponseResult.success(study);
    }

    // 浏览景点
    @PostMapping("/view")
    public ResponseResult<Map<String, Object>> view(
            @RequestBody Map<String, Integer> requestData,
            HttpSession session) {

        Integer studyId = requestData.get("studyId");

        Map<Integer, Long> viewStudy = (Map<Integer, Long>) session.getAttribute("viewedNews");
        if (viewStudy == null) {
            viewStudy = new HashMap<>();
        }

        //3.检查是否已浏览且未超过半小时
        Long lastViewedTime = viewStudy.get(studyId);
        if (lastViewedTime != null && System.currentTimeMillis() - lastViewedTime < 30 * 60 * 1000) {
            int viewCount = studyService.getViewCount(studyId);
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("viewed", true);
            responseData.put("viewCount", viewCount);
            return ResponseResult.success(responseData);
        }

        try {
            //4.执行浏览逻辑
            studyService.increaseViewCount(studyId);
            int viewCount = studyService.getViewCount(studyId);

            //5.更新Session中的浏览记录
            viewStudy.put(studyId, System.currentTimeMillis());
            session.setAttribute("viewedNews", viewStudy);
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("viewed", true);
            responseData.put("viewCount", viewCount);

            return ResponseResult.success(responseData);
        } catch (Exception e) {
            return ResponseResult.fail("浏览失败: " + e.getMessage());
        }
    }
    // 删除景点
    @DeleteMapping("/delete/{id}")
    public ResponseResult<Void> deleteStudySpot(@PathVariable Integer id) {
        try {
            Study spot = studyService.getById(id);
            if (spot == null) {
                return ResponseResult.fail("内容不存在");
            }

            if (spot.getCoverImage() != null) {
                deleteImage(spot.getCoverImage());
            }

            studyService.deleteStudy(id);
            return ResponseResult.success("内容删除成功");
        } catch (Exception e) {
            return ResponseResult.fail("删除内容失败: " + e.getMessage());
        }
    }

    @PostMapping("/add")
    public ResponseResult<Void> addStudySpot(

            @RequestParam(value = "title", required = false) String title,
            @RequestParam(value = "coverImage", required = false) MultipartFile coverImage,
            @RequestParam(value = "content", required = false) String content,
            @RequestParam(value = "source", required = false) String source,
            @RequestParam(value = "author", required = false) String author,
            @RequestParam(value = "time", required = false) String time
    ) {
        try {
            Study spot = new Study();
            spot.setTitle(title);
            spot.setContent(content);
            spot.setViewCount(0); // 初始化浏览次数为0
            spot.setSource(source);
            spot.setAuthor(author);
            spot.setTime(time);

            System.out.println("Title: " + title);
            System.out.println("Content: " + content);
            System.out.println(source);
            System.out.println(author);
            System.out.println("Cover Image: " + (coverImage != null ? coverImage.getOriginalFilename() : "null"));

            if (coverImage != null && !coverImage.isEmpty()) {
                String fileName = saveImage(coverImage);
                spot.setCoverImage(STUDY_ACCESS_PATH + fileName);
            }

            studyService.addStudy(spot);
            return ResponseResult.success("内容添加成功");
        } catch (Exception e) {
            return ResponseResult.fail("添加内容失败: " + e.getMessage());
        }
    }


    // 更新景点
    @PostMapping("/update")
    public ResponseResult<Void> updateStudySpot(
            @RequestParam("id") Integer id,
            @RequestParam("title") String title,
            @RequestParam(value = "author", required = false) String author,
            @RequestParam(value = "content", required = false) String content,
            @RequestParam(value = "viewCount", required = false) Integer viewCount, // 浏览次数
            @RequestParam(value = "source", required = false) String source,
            @RequestParam(value = "time", required = false) String time,
            @RequestParam(value = "coverImage", required = false) MultipartFile coverImage
    ) {
        try {
            Study spot = studyService.getById(id);
            if (spot == null) {
                return ResponseResult.fail("内容不存在");
            }

            spot.setTitle(title);
            spot.setContent(content);
            spot.setViewCount(viewCount); // 浏览次数
            spot.setSource(source);
            spot.setAuthor(author);
            spot.setTime(time);

            if (coverImage != null && !coverImage.isEmpty()) {
                if (spot.getCoverImage() != null) {
                    deleteImage(spot.getCoverImage());
                }
                String fileName = saveImage(coverImage);
                spot.setCoverImage(STUDY_ACCESS_PATH + fileName);
            }

            studyService.updateStudy(spot);
            return ResponseResult.success("内容更新成功");
        } catch (Exception e) {
            return ResponseResult.fail("更新内容失败: " + e.getMessage());
        }
    }

    private String saveImage(MultipartFile file) throws IOException, URISyntaxException {
        String uploadDir = getRealUploadPath();
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }

        String originalFilename = file.getOriginalFilename();
        String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String fileName = UUID.randomUUID().toString() + fileExtension;

        File dest = new File(uploadDir + fileName);
        file.transferTo(dest);

        return fileName;
    }

    private void deleteImage(String imageUrl) {
        try {
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

    @PostMapping("/batchDelete")
    public ResponseResult batchDelete(@RequestBody Map<String, List<Integer>> request) {
        List<Integer> studyIds = request.get("studyIds");
        if (studyIds == null || studyIds.isEmpty()) {
            return ResponseResult.fail("请至少选择一个内容进行删除");
        }

        try {
            int result = studyService.batchDelete(studyIds);
            if (result > 0) {
                return ResponseResult.success("批量删除成功");
            }
            return ResponseResult.fail("批量删除失败，未找到对应内容");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.fail("系统错误：" + e.getMessage());
        }
    }

}


