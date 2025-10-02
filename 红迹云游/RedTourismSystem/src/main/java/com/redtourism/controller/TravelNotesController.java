package com.redtourism.controller;

import com.redtourism.entity.TravelNotes;
import com.redtourism.entity.User;
import com.redtourism.service.CommentService;
import com.redtourism.service.TravelNotesService;
import com.redtourism.service.UserService;
import com.redtourism.service.impl.TravelNotesServiceImpl;
import com.redtourism.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.ws.Response;
import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.file.Paths;
import java.util.*;

@RestController
@RequestMapping("/travelNotes")
public class TravelNotesController {
    @Autowired
    private TravelNotesService travelNotesService;

    @Autowired
    private HttpServletRequest request;

    @Autowired
    CommentService commentService;

    @Autowired
    UserService userService;


    private static final String TRAVELNOTES_UPLOAD_DIR = "/assets/images/travelNotes/";
    private static final String TRAVELNOTES_ACCESS_PATH = "assets/images/travelNotes/";

    private String getRealUploadPath() {
        String realPath = request.getServletContext().getRealPath(TRAVELNOTES_UPLOAD_DIR);
        if (realPath == null) {
            realPath = System.getProperty("user.dir") + "/src/main/webapp" + TRAVELNOTES_UPLOAD_DIR;
        }
        return realPath;
    }


    // 获取所有列表
    @GetMapping("/list")
    public ResponseResult<List<TravelNotes>> list() {

        List<TravelNotes> list = travelNotesService.listAll();
        return ResponseResult.success(list);
    }






    // 获取详情
    @GetMapping("/{id}")
    public ResponseResult<TravelNotes> detail(@PathVariable Integer id) {
        TravelNotes travelNotes = travelNotesService.getById(id);
        return ResponseResult.success(travelNotes);
    }

    // 浏览数
    @PostMapping("/view")
    public ResponseResult<Map<String, Object>> view(
            @RequestBody Map<String, Integer> requestData,
            HttpSession session) {

        Integer travelNotesId = requestData.get("travelNotesId");

        // 从 session 中获取已浏览的游记记录
        Map<Integer, Long> viewTravelNotes = (Map<Integer, Long>) session.getAttribute("viewedTravelNotes");
        if (viewTravelNotes == null) {
            viewTravelNotes = new HashMap<>();
        }

        // 检查是否已浏览且未超过半小时
        Long lastViewedTime = viewTravelNotes.get(travelNotesId);
        if (lastViewedTime != null && System.currentTimeMillis() - lastViewedTime < 30 * 60 * 1000) {
            // 如果在半小时内已经浏览过，直接返回当前浏览次数
            int viewCount = travelNotesService.getViewCount(travelNotesId);
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("travelNotesId", travelNotesId); // 添加 travelNotesId
            responseData.put("viewed", true);
            responseData.put("viewCount", viewCount);
            return ResponseResult.success(responseData);
        }

        try {
            // 如果没有浏览记录或超过半小时，则执行浏览逻辑
            travelNotesService.increaseViewCount(travelNotesId);
            int viewCount = travelNotesService.getViewCount(travelNotesId);

            // 更新 Session 中的浏览记录
            viewTravelNotes.put(travelNotesId, System.currentTimeMillis());
            session.setAttribute("viewedTravelNotes", viewTravelNotes);

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("travelNotesId", travelNotesId); // 添加 travelNotesId
            responseData.put("viewed", true);
            responseData.put("viewCount", viewCount);

            return ResponseResult.success(responseData);
        } catch (Exception e) {
            return ResponseResult.fail("浏览失败: " + e.getMessage());
        }
    }

//    @PostMapping("/view")
//    public ResponseResult<Map<String, Object>> view(
//            @RequestBody Map<String, Integer> requestData,
//            HttpSession session) {
//
//
//        Integer travelNotesId = requestData.get("travelNotesId");
//
//        // 从 session 中获取已浏览的游记记录
//        Map<Integer, Long> viewTravelNotes = (Map<Integer, Long>) session.getAttribute("viewedTravelNotes");
//        if (viewTravelNotes == null) {
//            viewTravelNotes = new HashMap<>();
//        }
//
//        // 检查是否已浏览且未超过半小时
//        Long lastViewedTime = viewTravelNotes.get(travelNotesId);
//        if (lastViewedTime != null && System.currentTimeMillis() - lastViewedTime < 30 * 60 * 1000) {
//            // 如果在半小时内已经浏览过，直接返回当前浏览次数
//            int viewCount = travelNotesService.getViewCount(travelNotesId);
//            Map<String, Object> responseData = new HashMap<>();
//            responseData.put("viewed", true);
//            responseData.put("viewCount", viewCount);
//            return ResponseResult.success(responseData);
//        }
//
//        try {
//            // 如果没有浏览记录或超过半小时，则执行浏览逻辑
//            travelNotesService.increaseViewCount(travelNotesId);
//            int viewCount = travelNotesService.getViewCount(travelNotesId);
//
//            // 更新 Session 中的浏览记录
//            viewTravelNotes.put(travelNotesId, System.currentTimeMillis());
//            session.setAttribute("viewedTravelNotes", viewTravelNotes);
//
//            Map<String, Object> responseData = new HashMap<>();
//            responseData.put("viewed", true);
//            responseData.put("viewCount", viewCount);
//
//            return ResponseResult.success(responseData);
//        } catch (Exception e) {
//            return ResponseResult.fail("浏览失败: " + e.getMessage());
//        }
//    }


    @DeleteMapping("/delete/{id}")
    public ResponseResult<Void> deleteTravelNotes(@PathVariable Integer id) {
        try {
            TravelNotes spot = travelNotesService.getById(id);
            if (spot == null) {
                return ResponseResult.fail("内容不存在");
            }

            if (spot.getImages() != null) {
                deleteImage(spot.getImages());
            }

            travelNotesService.deleteTravelNotes(id);
            return ResponseResult.success("内容删除成功");
        } catch (Exception e) {
            return ResponseResult.fail("删除内容失败: " + e.getMessage());
        }
    }




    @PostMapping("/add")
    public ResponseResult<Void> addTravelNotesSpot(
            @RequestParam(value = "title", required = false) String title,
            @RequestParam(value = "images", required = false) MultipartFile[] images,
            @RequestParam(value = "banImage", required = false) MultipartFile banImage,
            @RequestParam(value = "content", required = false) String content,
            @RequestParam(value = "place", required = false) String place,
            @RequestParam(value = "video", required = false) MultipartFile video,
            HttpSession session
    ) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null || !user.isActive()) {
                return ResponseResult.fail("用户未登录或已被禁用");
            }

            Integer userId = user.getId();
            TravelNotes spot = new TravelNotes();
            spot.setTitle(title);
            spot.setContent(content);
            spot.setViewCount(0);
            spot.setFavoriteCount(0);
            spot.setPlace(place);
            spot.setUserId(userId);

            // 处理封面图片
            if (banImage != null && !banImage.isEmpty()) {
                String fileName = saveImage(banImage);
                spot.setBanImage(TRAVELNOTES_ACCESS_PATH + fileName);
            }

            // 处理多张图片
            if (images != null && images.length > 0) {
                List<String> imagePaths = new ArrayList<>();
                for (MultipartFile image : images) {
                    if (image != null && !image.isEmpty()) {
                        String fileName = saveImage(image);
                        imagePaths.add(TRAVELNOTES_ACCESS_PATH + fileName);
                    }
                }
                // 只有当有有效图片时才设置
                if (!imagePaths.isEmpty()) {
                    spot.setImages(String.join(",", imagePaths));
                }
            }

            // 处理视频
            if (video != null && !video.isEmpty()) {
                String fileName = saveVideo(video);
                spot.setVideo(TRAVELNOTES_ACCESS_PATH + fileName);
            }

            // 设置作者信息
            spot.setAuthor(user.getNickname());


            travelNotesService.addTravelNotes(spot);
            return ResponseResult.success("内容添加成功");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseResult.fail("添加内容失败: " + e.getMessage());
        }
    }



//    @PostMapping("/update")
//    public ResponseResult<Void> updateTravelNotesSpot(
//            @RequestParam("id") Integer id,
//            @RequestParam("title") String title,
//            @RequestParam(value = "content", required = false) String content,
//            @RequestParam(value = "place", required = false) String place,
//            @RequestParam(value = "banImage", required = false) MultipartFile banImage,
//            @RequestParam(value = "images", required = false) MultipartFile images,
//            @RequestParam(value = "video", required = false) MultipartFile video
//    ) {
//        try {
//            // 检查游记是否存在
//            TravelNotes spot = travelNotesService.getById(id);
//            if (spot == null) {
//                return ResponseResult.fail("内容不存在");
//            }
//
//            // 更新基本信息
//            if (title != null) spot.setTitle(title);
//            if (content != null) spot.setContent(content);
//            if (place != null) spot.setPlace(place);
//
//            // 处理封面图片
//            if (banImage != null && !banImage.isEmpty()) {
//                if (spot.getBanImage() != null) {
//                    deleteImage(spot.getBanImage());
//                }
//                String fileName = saveImage(banImage);
//                spot.setBanImage(TRAVELNOTES_ACCESS_PATH + fileName);
//            }
//
//            // 处理图片列表
//            if (images != null && !images.isEmpty()) {
//                if (spot.getImages() != null) {
//                    deleteImage(spot.getImages());
//                }
//                String fileName = saveImage(images);
//                List<String> imageList = new ArrayList<>();
//                imageList.add(TRAVELNOTES_ACCESS_PATH + fileName);
//                spot.setImages(String.join(",", imageList));
//            }
//
//            // 处理视频
//            if (video != null && !video.isEmpty()) {
//                if (spot.getVideo() != null) {
//                    deleteImage(spot.getVideo());
//                }
//                String fileName = saveVideo(video);
//                spot.setVideo(TRAVELNOTES_ACCESS_PATH + fileName);
//            } else {
//                // 如果没有上传新的视频，保持原来的视频路径
//                if (spot.getVideo() == null) {
//                    spot.setVideo(""); // 设置为空字符串或其他默认值
//                }
//            }
//
//            // 更新数据库
//            travelNotesService.updateTravelNotes(spot);
//            return ResponseResult.success("内容更新成功");
//        } catch (Exception e) {
//            e.printStackTrace(); // 打印完整的堆栈信息
//            return ResponseResult.fail("更新内容失败: " + e.getMessage());
//        }
//    }


    @PostMapping("/update")
    public ResponseResult<Void> updateTravelNotesSpot(
            @RequestParam("id") Integer id,
            @RequestParam("title") String title,
            @RequestParam(value = "content", required = false) String content,
            @RequestParam(value = "place", required = false) String place,
            @RequestParam(value = "banImage", required = false) MultipartFile banImage,
            @RequestParam(value = "existingImages", required = false) String existingImages,
            @RequestParam(value = "newImages", required = false) MultipartFile[] newImages,
            @RequestParam(value = "video", required = false) MultipartFile video
    ) {
        try {
            // 检查游记是否存在
            TravelNotes spot = travelNotesService.getById(id);
            if (spot == null) {
                return ResponseResult.fail("内容不存在");
            }

            // 更新基本信息
            if (title != null) spot.setTitle(title);
            if (content != null) spot.setContent(content);
            if (place != null) spot.setPlace(place);

            // 处理封面图片
            if (banImage != null && !banImage.isEmpty()) {
                if (spot.getBanImage() != null) {
                    deleteImage(spot.getBanImage());
                }
                String fileName = saveImage(banImage);
                spot.setBanImage(TRAVELNOTES_ACCESS_PATH + fileName);
            }

            // 处理图片列表
            if (newImages != null && newImages.length > 0) {
                // 删除原有的图片
                if (existingImages != null && !existingImages.isEmpty()) {
                    deleteImage(existingImages);
                }

                Set<String> imageSet = new HashSet<>(); // 使用 Set 来去重
                for (MultipartFile image : newImages) {
                    if (image != null && !image.isEmpty()) {
                        String fileName = saveImage(image);
                        imageSet.add(TRAVELNOTES_ACCESS_PATH + fileName);
                    }
                }
                if (!imageSet.isEmpty()) {
                    spot.setImages(String.join(",", imageSet));
                } else {
                    spot.setImages(null); // 如果没有上传新的图片，清空图片路径
                }
            } else {
                // 如果没有上传新的图片，保留原有的图片路径
                spot.setImages(existingImages);
            }

            // 处理视频
            if (video != null && !video.isEmpty()) {
                if (spot.getVideo() != null) {
                    deleteImage(spot.getVideo());
                }
                String fileName = saveVideo(video);
                spot.setVideo(TRAVELNOTES_ACCESS_PATH + fileName);
            } else {
                // 如果没有上传新的视频，保留原来的视频路径
                if (spot.getVideo() == null || spot.getVideo().trim().isEmpty()) {
                    spot.setVideo(null); // 如果原来也没有视频，清空视频路径
                }
            }

            // 更新数据库
            travelNotesService.updateTravelNotes(spot);
            return ResponseResult.success("内容更新成功");
        } catch (Exception e) {
            e.printStackTrace(); // 打印完整的堆栈信息
            return ResponseResult.fail("更新内容失败: " + e.getMessage());
        }
    }

    @PostMapping("/favorite")
    public ResponseResult<Void> favorite(@RequestBody Map<String, Integer> data, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !user.isActive()) {
            return ResponseResult.fail("用户未登录或已被禁用");
        }

        Integer travelNotesId = data.get("travelNotesId");
        if (travelNotesId == null) {
            return ResponseResult.fail("参数错误: travelNotesId不能为空");
        }

        try {
            travelNotesService.favorite(user.getId(), travelNotesId);
            return ResponseResult.success();
        } catch (Exception e) {
            return ResponseResult.fail("收藏失败: " + e.getMessage());
        }
    }


    @PostMapping("/unfavorite")
    public ResponseResult<Void> unfavorite(@RequestBody Map<String, Integer> data, HttpSession session) {
        User user = (User) session.getAttribute("user");
        Integer travelNotesId = data.get("travelNotesId");
        travelNotesService.unfavoriteTravelNotes(user.getId(), travelNotesId);

        //更新会话中的收藏信息
        List<TravelNotes> favoriteTravelNotes = travelNotesService.listFavoritesByUserId(user.getId());
        session.setAttribute("favoriteTravelNotes", favoriteTravelNotes);

        return ResponseResult.success();
    }


    @DeleteMapping("/deletemytravelnotes/{id}")
    public ResponseResult<Void> deletemytravelnotes(@PathVariable Integer id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null || !user.isActive()) {
            return ResponseResult.fail("用户未登录或已被禁用");
        }
        travelNotesService.delete(id);

        //更新会话中的信息
        List<TravelNotes> mytravelNotesList = travelNotesService.listByUserId(user.getId());
        session.setAttribute("mytravelNotesList", mytravelNotesList);

        return ResponseResult.success("删除成功");
    }

    private String saveImage(MultipartFile file) throws IOException {
        // 获取上传目录路径
        String uploadDir = getRealUploadPath();
        File uploadDirFile = new File(uploadDir);

        // 如果目录不存在则创建
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }

        // 获取原始文件名和扩展名
        String originalFilename = file.getOriginalFilename();
        if (originalFilename == null || originalFilename.isEmpty()) {
            throw new IOException("上传文件没有文件名");
        }

        String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

        // 构建目标文件路径
        File dest = new File(uploadDir + File.separator + uniqueFileName);

        // 确保父目录存在
        if (!dest.getParentFile().exists()) {
            dest.getParentFile().mkdirs();
        }

        // 保存文件
        file.transferTo(dest);

        return uniqueFileName;
    }

    private String saveVideo(MultipartFile file) throws IOException, URISyntaxException {
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

    // 原有的方法，用于删除单个图片
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

    // 新增的方法，用于删除多个图片
    private void deleteImage(List<String> imageUrls) {
        if (imageUrls == null || imageUrls.isEmpty()) {
            return; // 如果列表为空或为 null，直接返回
        }
        for (String imageUrl : imageUrls) {
            deleteImage(imageUrl); // 调用原有的方法删除单个图片
        }
    }

    @GetMapping("/user/{userId}/travelnotes")
    public ResponseResult<List<TravelNotes>> getTravelNotesByUserId(@PathVariable Integer userId) {
        List<TravelNotes> travelNotesList = travelNotesService.listByUserId(userId);
        return ResponseResult.success(travelNotesList);
    }
}
