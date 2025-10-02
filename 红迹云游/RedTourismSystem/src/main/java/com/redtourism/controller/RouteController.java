package com.redtourism.controller;

import com.redtourism.entity.TravelRoute;
import com.redtourism.entity.User;
import com.redtourism.service.RouteService;
import com.redtourism.service.impl.RouteServiceImpl;
import com.redtourism.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import com.fasterxml.jackson.databind.ObjectMapper;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@CrossOrigin(origins = "*")
@RestController
@RequestMapping("/route")
public class RouteController {

    @Autowired
    private RouteService routeService;

    @Autowired
    private HttpServletRequest request;

    //硬编码图片上传路径和访问路径
    private static final String ROUTE_UPLOAD_DIR = "/assets/images/route/";
    private static final String ROUTE_ACCESS_PATH = "assets/images/route/";

    //获取web应用真实路径
    private String getRealUploadPath() {
        String realPath = request.getServletContext().getRealPath(ROUTE_UPLOAD_DIR);

        if (realPath == null) {
            realPath = System.getProperty("user.dir") + "/src/main/webapp" + ROUTE_UPLOAD_DIR;
        }
        return realPath;
    }

    //获取所有路线列表
    @GetMapping("/list")
    public ResponseResult<List<TravelRoute>> list() {
        List<TravelRoute> list = routeService.listAll();
        return ResponseResult.success(list);
    }

    //获取热门路线
    @GetMapping("/top")
    public ResponseResult<List<TravelRoute>> topRoutes(
            @RequestParam(defaultValue = "10") int limit) {
        List<TravelRoute> topRoutes = routeService.listTopRoutes(limit);
        return ResponseResult.success(topRoutes);
    }

    //获取路线详情
    @GetMapping("/{id}")
    public ResponseResult<TravelRoute> detail(@PathVariable Integer id) {
        TravelRoute route = routeService.getByIdWithScenics(id);
        if (route == null) {
            return ResponseResult.fail("路线不存在");
        }
        return ResponseResult.success(route);
    }

    //点赞路线
    //点赞路线
    @PostMapping("/like")
    public ResponseResult<Map<String, Object>> likeRoute(
            @RequestBody Map<String, Integer> requestData,
            HttpSession session
    ) {
        Integer routeId = requestData.get("routeId");
        User user = (User) session.getAttribute("user");

        if (user == null || !user.isActive()) {
            return ResponseResult.fail("用户未登录或已被禁用");
        }

        try {
            // 检查是否已点赞
            if (routeService.checkIfUserLikedRoute(user.getId(), routeId)) {
                //如果已点赞，执行取消点赞
                routeService.decreaseLikeCount(routeId);
                routeService.cancelUserLikeRoute(user.getId(),routeId);
//                return ResponseResult.fail("一天内只能点赞一次");
            }

            //4.执行点赞逻辑
            routeService.increaseLikeCount(routeId);
            int likeCount = routeService.getLikeCount(routeId);

            // 记录用户点赞信息
            routeService.recordUserLikeRoute(user.getId(), routeId);

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("liked", true);
            responseData.put("likeCount", likeCount);

            return ResponseResult.success(responseData);
        } catch (Exception e) {
            return ResponseResult.fail("点赞失败: " + e.getMessage());
        }
    }


    // 新增取消点赞接口
    @PostMapping("/unlike")
    public ResponseResult<Map<String, Object>> unlike(
            @RequestBody Map<String, Integer> requestData,
            HttpSession session) {

        Integer routeId = requestData.get("routeId");
        User user = (User) session.getAttribute("user");

        if (user == null || !user.isActive()) {
            return ResponseResult.fail("用户未登录或已被禁用");
        }

        try {
            // 执行取消点赞
            routeService.decreaseLikeCount(routeId);
            int newLikeCount = routeService.getLikeCount(routeId);

            routeService.cancelUserLikeRoute(user.getId(), routeId);
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("liked", false);
            responseData.put("likeCount", newLikeCount);
            return ResponseResult.success(responseData);
        } catch (Exception e) {
            return ResponseResult.fail("取消点赞失败: " + e.getMessage());
        }
    }

    // 获取路线点赞和收藏状态
    @GetMapping("/status/{id}")
    public ResponseResult<Map<String, Object>> getRouteStatus(@PathVariable Integer id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        Map<String, Object> status = new HashMap<>();

        // 获取最新点赞数（新增）
        int newlikeCount = routeService.getLikeCount(id);
        status.put("likeCount", newlikeCount); // 新增点赞数字段
        if (user != null && user.isActive()) {
            // 检查是否已点赞
           status.put("liked", routeService.checkIfUserLikedRoute(user.getId(), id));

            // 检查是否已收藏
            status.put("favorited", routeService.checkIfFavorited(user.getId(), id));
        } else {
            status.put("liked", false);
            status.put("favorited", false);
        }


        return ResponseResult.success(status);
    }

    //收藏路线
    @PostMapping("/favorite")
    public ResponseResult<Void> favorite(
            @RequestBody Map<String, Integer> data,  // 改为@RequestBody
            HttpSession session)  {

        Integer routeId = data.get("routeId");

        User user = (User) session.getAttribute("user");

        if (user == null || !user.isActive()) {
            return ResponseResult.fail("用户未登录或已被禁用");
        }

        try {
            //检查是否已经收藏过
            boolean alreadyFavorited = routeService.checkIfFavorited(user.getId(), routeId);

            if (!alreadyFavorited) {
                //如果没有收藏过，才执行收藏操作
                routeService.favorite(user.getId(), routeId);
            }

            //无论是否已收藏，都返回成功
            return ResponseResult.success();
        } catch (Exception e) {
            return ResponseResult.fail("收藏失败: " + e.getMessage());
        }
    }

    //取消收藏
    @PostMapping("/unfavorite")
    public ResponseResult<Void> unfavorite(@RequestBody Map<String, Integer> data, HttpSession session) {
        User user = (User) session.getAttribute("user");
        Integer routeId = data.get("routeId");
        routeService.unfavoriteRoute(user.getId(), routeId);

        // 更新会话中的收藏信息
        List<TravelRoute> favoriteRoutes = routeService.listFavoritesByUserId(user.getId());
        session.setAttribute("favoriteRoutes", favoriteRoutes);

        return ResponseResult.success();
    }
    //更新路线
    @PostMapping("/update")
    @ResponseBody
    public ResponseResult<String> updateRoute(
            @RequestParam("id") Integer id,
            @RequestParam("name") String name,
            @RequestParam("description") String description,
            @RequestParam(value = "coverImage", required = false) MultipartFile coverImage) {

        try {
            TravelRoute route = new TravelRoute();
            route.setId(id);
            route.setName(name);
            route.setDescription(description);



            if (coverImage != null && !coverImage.isEmpty()) {
                String coverImagePath = saveImage(coverImage);
                route.setCoverImage(ROUTE_ACCESS_PATH + coverImagePath);
            }

            int result = routeService.updateRoute(route);
            if (result > 0) {
                return ResponseResult.success("路线更新成功");
            } else {
                return ResponseResult.fail("数据库更新失败");
            }
        } catch (Exception e) {
            return ResponseResult.fail("更新失败: " + e.getMessage());
        }
    }
    @PostMapping("/add")
    public ResponseResult<Void> addRoute(
            @RequestParam("name") String name,
            @RequestParam("coverImage") MultipartFile coverImage,
            @RequestParam(value = "description", required = false) String description) {
        try {
            TravelRoute route = new TravelRoute();
            route.setName(name);
            route.setDescription(description);
            route.setLikeCount(0);
            String coverImagePath = saveImage(coverImage);
            route.setCoverImage(ROUTE_ACCESS_PATH + coverImagePath);


            routeService.addRoute(route);
            return ResponseResult.success("路线添加成功");
        } catch (IOException e) {
            return ResponseResult.fail("图片处理失败: " + e.getMessage());
        } catch (Exception e) {
            return ResponseResult.fail("添加路线失败: " + e.getMessage());
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseResult<Void> deleteRoute(@PathVariable Integer id) {
        try {
            TravelRoute route = routeService.getById(id);
            if (route == null) {
                return ResponseResult.fail("路线不存在");
            }

            // 直接删除路线，不需要单独处理图片
            routeService.deleteRoute(id);
            return ResponseResult.success("路线删除成功");
        } catch (Exception e) {
            return ResponseResult.fail("删除路线失败: " + e.getMessage());
        }
    }

    //保存图片到服务器
    private String saveImage(MultipartFile file) throws IOException {
        String uploadDir = getRealUploadPath();
        //确保上传目录存在
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }

        //生成唯一文件名
        String originalFilename = file.getOriginalFilename();
        String fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
        String fileName = UUID.randomUUID().toString() + fileExtension;

        //保存文件
        File dest = new File(uploadDir + fileName);
        file.transferTo(dest);

        return fileName;
    }

    //删除图片
    private void deleteImage(String imageUrl) {
        try {
            //从完整URL中提取文件名
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
    public ResponseResult<Void> batchDeleteRoutes(@RequestBody Map<String, List<Integer>> request) {
        try {
            List<Integer> routeIds = request.get("routeIds");
            if (routeIds == null || routeIds.isEmpty()) {
                return ResponseResult.fail("请选择要删除的路线");
            }

            routeService.batchDeleteRoutes(routeIds);
            return ResponseResult.success();
        } catch (Exception e) {
            return ResponseResult.fail("批量删除失败: " + e.getMessage());
        }
    }

}