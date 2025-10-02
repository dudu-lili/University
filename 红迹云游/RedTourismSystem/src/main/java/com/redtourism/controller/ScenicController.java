package com.redtourism.controller;

import com.redtourism.entity.Comment;
import com.redtourism.entity.ScenicSpot;
import com.redtourism.entity.TravelRoute;
import com.redtourism.entity.User;
import com.redtourism.service.CommentService;
import com.redtourism.service.RouteService;
import com.redtourism.service.ScenicService;
import com.redtourism.service.impl.ScenicServiceImpl;
import com.redtourism.util.GaodeMapUtil;
import com.redtourism.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import com.fasterxml.jackson.databind.ObjectMapper;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/scenic")
public class ScenicController {

    @Autowired
    private ScenicService scenicService;
    @Autowired
    private CommentService commentService;
    @Autowired
    private ScenicServiceImpl scenicServiceImpl;
    @Autowired
    private RouteService routeService;
    //4.13
    @Autowired
    private GaodeMapUtil gaodeMapUtil;

    @Autowired
    private HttpServletRequest request;
    //硬编码图片上传路径和访问路径
    private static final String SCENIC_UPLOAD_DIR = "/assets/images/scenic/";
    private static final String SCENIC_ACCESS_PATH = "assets/images/scenic/";

    //获取web应用真实路径
    private String getRealUploadPath() {
        String realPath = request.getServletContext().getRealPath(SCENIC_UPLOAD_DIR);
        //如果获取不到真实路径，使用相对路径（开发环境可能如此）
        if (realPath == null) {
            realPath = System.getProperty("user.dir") + "/src/main/webapp" + SCENIC_UPLOAD_DIR;
        }
        return realPath;
    }

    //获取所有景点列表
    @GetMapping("/list")
    public ResponseResult<List<ScenicSpot>> list() {
        List<ScenicSpot> list = scenicService.listAll();
        return ResponseResult.success(list);
    }

    //获取景点详情
    @GetMapping("/{id}")
    public ResponseResult<ScenicSpot> detail(@PathVariable Integer id) {
        ScenicSpot scenicSpot = scenicService.getById(id);
        return ResponseResult.success(scenicSpot);
    }

    //点赞景点
    @PostMapping("/like")
    public ResponseResult<Map<String, Object>> like(
            @RequestBody Map<String, Integer> requestData,
            HttpSession session) {

        Integer scenicId = requestData.get("scenicId");

        //1.检查用户是否登录
        User user = (User) session.getAttribute("user");
        if (user == null || !user.isActive()) {
            return ResponseResult.fail("用户未登录或已被禁用");
        }

        try {
            //4.检查是否已点赞
            if (scenicService.checkIfUserLikedScenic(user.getId(), scenicId)) {
//                return ResponseResult.fail("一天内只能点赞一次");
                // 如果已点赞，执行取消点赞
                scenicService.decreaseLikeCount(scenicId);
                scenicService.cancelUserLikeScenic(user.getId(), scenicId);
            }
            //4.执行点赞
            scenicService.increaseLikeCount(scenicId);
            int likeCount = scenicService.getLikeCount(scenicId);

            // 记录用户点赞信息
            scenicService.recordUserLikeScenic(user.getId(), scenicId);

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

        Integer scenicId = requestData.get("scenicId");
        User user = (User) session.getAttribute("user");

        if (user == null || !user.isActive()) {
            return ResponseResult.fail("用户未登录或已被禁用");
        }

        try {
            // 执行取消点赞
            scenicService.decreaseLikeCount(scenicId);
            int newLikeCount = scenicService.getLikeCount(scenicId);
            scenicService.cancelUserLikeScenic(user.getId(), scenicId);
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("liked", false);
            responseData.put("likeCount", newLikeCount);
            return ResponseResult.success(responseData);
        } catch (Exception e) {
            return ResponseResult.fail("取消点赞失败: " + e.getMessage());
        }
    }

    // 获取景点点赞和收藏状态,修改1
    @GetMapping("/status/{id}")
    public ResponseResult<Map<String, Object>> getScenicStatus(@PathVariable Integer id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        Map<String, Object> status = new HashMap<>();
        // 获取最新点赞数（新增）
        int newlikeCount = scenicService.getLikeCount(id);
        status.put("likeCount", newlikeCount); // 新增点赞数字段
        if (user != null && user.isActive()) {
            // 检查是否已点赞
//            Map<Integer, Long> likedScenics = (Map<Integer, Long>) session.getAttribute("likedScenics");
//            status.put("liked", likedScenics != null && likedScenics.containsKey(id));//只要点过赞就返回true
            status.put("liked", scenicService.checkIfUserLikedScenic(user.getId(), id));

            // 检查是否已收藏
            status.put("favorited", scenicService.checkIfFavorited(user.getId(), id));
        } else {
            status.put("liked", false);
            status.put("favorited", false);
        }
        return ResponseResult.success(status);
    }

    //收藏景点
    @PostMapping("/favorite")
    public ResponseResult<Void> favorite(@RequestBody Map<String, Integer> data, HttpSession session) {
        User user = (User) session.getAttribute("user");
//        if (user == null) {
//            return ResponseResult.fail(401, "用户未登录");
//        }
        if (user == null || !user.isActive()) {
            return ResponseResult.fail("用户未登录或已被禁用");
        }

        Integer scenicId = data.get("scenicId");
        if (scenicId == null) {
            return ResponseResult.fail("参数错误: scenicId不能为空");
        }

        try {
            scenicService.favorite(user.getId(), scenicId);
            return ResponseResult.success();
        } catch (Exception e) {
            return ResponseResult.fail("收藏失败: " + e.getMessage());
        }
    }

    //取消收藏
    @PostMapping("/unfavorite")
    public ResponseResult<Void> unfavorite(@RequestBody Map<String, Integer> data, HttpSession session) {
        User user = (User) session.getAttribute("user");
        Integer scenicId = data.get("scenicId");
        scenicServiceImpl.unfavoriteScenic(user.getId(), scenicId);

        //更新会话中的收藏信息
        List<ScenicSpot> favoriteScenics = scenicService.listFavoritesByUserId(user.getId());
        session.setAttribute("favoriteScenics", favoriteScenics);

        return ResponseResult.success();
    }

    @DeleteMapping("/delete/{id}")
    public ResponseResult<Void> deleteRoute(@PathVariable Integer id) {
        try {
            ScenicSpot spot= scenicService.getById(id);
            if (spot == null) {
                return ResponseResult.fail("路线不存在");
            }

            // 直接删除路线，不需要单独处理图片
            scenicService.deleteScenicSpot(id);
            return ResponseResult.success("路线删除成功");
        } catch (Exception e) {
            return ResponseResult.fail("删除路线失败: " + e.getMessage());
        }
    }

    //新增景点
    @PostMapping("/add")
    public ResponseResult<Void> addScenicSpot(
            @RequestParam("name") String name,
            @RequestParam(value = "coverImage", required = false) MultipartFile coverImage,
            @RequestParam(value = "description", required = false) String description,
            @RequestParam(value = "address", required = false) String address,
            @RequestParam(value = "level", required = false) String level,
            @RequestParam(value = "province", required = false) String province,
            @RequestParam(value = "city", required = false) String city,
            @RequestParam(value = "openningHours", required = false) String openningHours,
            @RequestParam(value = "ticketInfo", required = false) String ticketInfo,
            @RequestParam(value = "keywords", required = false) String keywords) {

        try {
            ScenicSpot spot = new ScenicSpot();
            spot.setName(name);
            spot.setDescription(description);
            spot.setAddress(address);
            spot.setLikeCount(0);
            spot.setLevel(level);
            spot.setProvince(province);
            spot.setCity(city);
            spot.setOpenningHours(openningHours);
            spot.setTicketInfo(ticketInfo);
            spot.setKeywords(keywords);
            String coverImagePath = saveImage(coverImage);
            spot.setCoverImage(SCENIC_ACCESS_PATH + coverImagePath);

//            spot.setCoverImage(coverImage.getBytes());
            // 添加百度地图坐标转换4.13
            if (address != null && !address.isEmpty()) {
                Map<String, Double> coordinates = gaodeMapUtil.getLatLng(address);
                if (coordinates != null) {
                    spot.setLatitude(coordinates.get("lat"));
                    spot.setLongitude(coordinates.get("lng"));
                    System.out.println("获取到经纬度: lat=" + coordinates.get("lat") + ", lng=" + coordinates.get("lng"));
                } else {
                    System.out.println("未能获取到经纬度坐标");
                }
            }

            scenicService.addScenicSpot(spot);
            return ResponseResult.success("景点添加成功");
        } catch (IOException e) {
            return ResponseResult.fail("图片处理失败: " + e.getMessage());
        } catch (Exception e) {
            return ResponseResult.fail("添加景点失败: " + e.getMessage());
        }
    }
    @PostMapping("/update")
    public ResponseResult<Void> updateScenicSpot(
            @RequestParam("id") Integer id,
            @RequestParam("name") String name,
            @RequestParam(value = "coverImage", required = false) MultipartFile coverImage,
            @RequestParam(value = "description", required = false) String description,
            @RequestParam(value = "address", required = false) String address,
            @RequestParam(value = "level", required = false) String level,
            @RequestParam(value = "province", required = false) String province,
            @RequestParam(value = "city", required = false) String city,
            @RequestParam(value = "openningHours", required = false) String openningHours,
            @RequestParam(value = "ticketInfo", required = false) String ticketInfo,
            @RequestParam(value = "keywords", required = false) String keywords) {

        try {
            ScenicSpot existingSpot = scenicService.getById(id);
            if (existingSpot == null) {
                return ResponseResult.fail("景点不存在");
            }

            // 保存原有经纬度值
            Double originalLat = existingSpot.getLatitude();
            Double originalLng = existingSpot.getLongitude();

            existingSpot.setName(name);
            existingSpot.setDescription(description);
            existingSpot.setAddress(address);
            existingSpot.setLevel(level);
            existingSpot.setProvince(province);
            existingSpot.setCity(city);
            existingSpot.setOpenningHours(openningHours);
            existingSpot.setTicketInfo(ticketInfo);
            existingSpot.setKeywords(keywords);

            // 添加高德地图坐标转换 - 只要地址不为空就更新
            if (address != null && !address.isEmpty()) {
                Map<String, Double> coordinates = gaodeMapUtil.getLatLng(address);
                if (coordinates != null) {
                    existingSpot.setLatitude(coordinates.get("lat"));
                    existingSpot.setLongitude(coordinates.get("lng"));
                    System.out.println("更新经纬度: lat=" + coordinates.get("lat") + ", lng=" + coordinates.get("lng"));
                } else {
                    // 如果获取不到新坐标，保留原有坐标
                    existingSpot.setLatitude(originalLat);
                    existingSpot.setLongitude(originalLng);
                    System.out.println("未能获取到更新后的经纬度坐标，保留原有坐标");
                }
            }
            if (coverImage != null && !coverImage.isEmpty()) {
                String coverImagePath = saveImage(coverImage);
                existingSpot.setCoverImage(SCENIC_ACCESS_PATH + coverImagePath);
            }
            scenicService.updateScenicSpot(existingSpot);
            return ResponseResult.success("景点更新成功");
        } catch (IOException e) {
            return ResponseResult.fail("图片处理失败: " + e.getMessage());
        } catch (Exception e) {
            return ResponseResult.fail("更新景点失败: " + e.getMessage());
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

    // 获取排序后的景点列表
    @GetMapping("/list/sorted")
    public ResponseResult<List<ScenicSpot>> getSortedScenicList(
            @RequestParam(value = "sortBy", defaultValue = "level") String sortBy,
            @RequestParam(value = "order", defaultValue = "asc") String order,
            @RequestParam(value = "latitude", required = false) Double latitude,
            @RequestParam(value = "longitude", required = false) Double longitude
    ) {

        try {
            List<ScenicSpot> list;

            switch (sortBy.toLowerCase()) {
                case "level":
                    list = scenicService.findAllOrderByLevel(order);
                    break;
                case "likes":
                    list = scenicService.getScenicsSortedByLikes(order.equalsIgnoreCase("asc"));
                    break;
                case "favorites":
                    list = scenicService.getScenicsSortedByFavorites(order.equalsIgnoreCase("asc"));
                    break;
                case "distance":
                    if (latitude == null || longitude == null) {
                        return ResponseResult.fail("距离排序需要提供经纬度参数");
                    }
                    list = scenicService.findNearbyScenics(latitude, longitude, Integer.MAX_VALUE);
                    // 然后按距离排序
                    list.sort((s1, s2) -> {
                        double dist1 = scenicService.haversineDistance(latitude, longitude, s1.getLatitude(), s1.getLongitude());
                        double dist2 = scenicService.haversineDistance(latitude, longitude, s2.getLatitude(), s2.getLongitude());
                        return order.equalsIgnoreCase("asc") ?
                                Double.compare(dist1, dist2) :
                                Double.compare(dist2, dist1);
                    });
                    break;

                default:

                    return ResponseResult.fail("不支持的排序类型");
            }
            // 如果提供了经纬度，计算每个景点的距离
            if (latitude != null && longitude != null) {
                list.forEach(spot -> {
                    if (spot.getLatitude() != null && spot.getLongitude() != null) {
                        double distance = scenicService.haversineDistance(latitude, longitude,
                                spot.getLatitude(), spot.getLongitude());
                        System.out.println("距离: " + distance);
                        spot.setDistance(distance);
                    }
                });
            }

            return ResponseResult.success(list);
        } catch (Exception e) {
            return ResponseResult.fail("排序失败: " + e.getMessage());
        }
    }
    // 获取附近景点4.13
    @GetMapping("/nearby")
    @ResponseBody
    public ResponseResult<List<ScenicSpot>> getNearbyScenics(
            @RequestParam Double latitude,
            @RequestParam Double longitude,
            @RequestParam(required = false, defaultValue = "5000") Integer radius) {

        List<ScenicSpot> nearbyScenics = scenicService.findNearbyScenics(latitude, longitude, radius);
        System.out.println("111"+nearbyScenics);
        System.out.println("Latitude: " + latitude + ", Longitude: " + longitude + ", Radius: " + radius);
        request.setAttribute("nearbyScenics", nearbyScenics);
        return ResponseResult.success(nearbyScenics);
    }
    @GetMapping("/random")
    public List<ScenicSpot> getRandomScenicSpots() {
        return scenicService.listAll();
    }

    @PostMapping("/batch-delete")
    public ResponseResult<Void> batchDeleteScenics(@RequestBody Map<String, List<Integer>> request) {
        try {
            List<Integer> scenicIds = request.get("scenicIds");
            if (scenicIds == null || scenicIds.isEmpty()) {
                return ResponseResult.fail("请选择要删除的景点");
            }

            scenicService.batchDeleteScenics(scenicIds);
            return ResponseResult.success();
        } catch (Exception e) {
            return ResponseResult.fail("批量删除失败: " + e.getMessage());
        }
    }
    /**
     * 搜索景点接口
     */
    @GetMapping("/search")
    public ResponseResult<List<ScenicSpot>> searchScenics(
            @RequestParam("keyword") String keyword) {

        if (keyword == null || keyword.trim().isEmpty()) {
            return ResponseResult.fail("关键词不能为空");
        }

        List<ScenicSpot> result = scenicService.searchScenics(keyword.trim());
        if (result == null || result.isEmpty()) {
            return ResponseResult.fail("未找到相关景点");
        }

        return ResponseResult.success(result);
    }


}