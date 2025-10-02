package com.redtourism.controller;
import de.mkammerer.argon2.Argon2;
import de.mkammerer.argon2.Argon2Factory;
import org.springframework.util.StringUtils;
import com.redtourism.entity.*;
import com.redtourism.service.*;
import com.redtourism.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.security.crypto.password.PasswordEncoder;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.nio.file.Files;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import static jdk.nashorn.internal.runtime.regexp.joni.Config.log;

@RestController
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private ScenicService scenicService;
    @Autowired
    private RouteService routeService;
    @Autowired
    private CommentService commentService;
//    @Autowired
//    private PasswordEncoder passwordEncoder; // 添加 passwordEncoder 注入
    @Autowired
    private FileStorageService fileStorageService; // 添加 fileStorageService 注入
    @Autowired
    private EmailService emailService;
    @Autowired
    private RedGeocodingService redGeocodingService;
    @Autowired
    private NewsService newsService;
    @Autowired
    private RecommendationService recommendationService;
    @Autowired
    private StudyService studyService;
    @Autowired
    private TravelNotesService travelNotesService;
    @Autowired
    private HttpServletRequest request;
    private static final String USER_UPLOAD_DIR = "/assets/images/user/";
    private static final String USER_ACCESS_PATH = "assets/images/user/";

    private final Argon2 argon2 = Argon2Factory.create(Argon2Factory.Argon2Types.ARGON2id);

    //用户注册
    @PostMapping("/register")
    public ResponseResult<User> register(
            // 注册参数
            @RequestParam String email,
//            @RequestParam String username,
            @RequestParam String password,
            @RequestParam String nickname,
            @RequestParam(required = false) MultipartFile avatar,
            @RequestParam(required = false) Integer gender,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date birthday,
            @RequestParam(required = false) String phone,
            @RequestParam(required = false) String address,
            @RequestParam(required = false) String signature) throws IOException, URISyntaxException {


        // 创建用户对象并设置基本属性
        User user = new User();
        user.setEmail(email);
//        user.setPassword(passwordEncoder.encode(password)); // 密码加密
        user.setPassword(password); // 密码加密
        user.setNickname(nickname);
        user.setGender(gender);
        user.setBirthday(birthday);
        user.setPhone(phone);
        user.setAddress(address);
        user.setSignature(signature);
        user.setStatus(1); // 默认启用状态
        System.out.println("user:" + user);


        String avatarPath = saveImage(avatar);
        user.setAvatar(USER_ACCESS_PATH + avatarPath);


        // 注册用户
        try {
            User registeredUser = userService.register(user);
            System.out.println("registeredUser:" + registeredUser);
            return ResponseResult.success(registeredUser, "注册成功");
        } catch (DuplicateKeyException e) {
            return ResponseResult.fail("用户名已存在");
        } catch (Exception e) {
//            log.error("用户注册失败", e);
            return ResponseResult.fail("注册失败");
        }
    }

    private String getRealUploadPath() {
        String realPath = request.getServletContext().getRealPath(USER_UPLOAD_DIR);
        if (realPath == null) {
            realPath = System.getProperty("user.dir") + "/src/main/webapp" + USER_UPLOAD_DIR;
        }
        return realPath;
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

    @PostMapping("/refreshSessionData")
    public ResponseResult<Void> refreshSessionData(HttpSession session) {
        User loggedInUser = (User) session.getAttribute("user");
        if (loggedInUser == null) {
            return ResponseResult.fail(401, "用户未登录");
        }

        try {

            // 新增：刷新推荐景点
            List<ScenicSpot> recommendedScenics = recommendationService.recommendScenics(loggedInUser.getId());
            session.setAttribute("recommendedScenics", recommendedScenics);
            // 新增：刷新推荐路线
            List<TravelRoute> recommendedRoutes = recommendationService.recommendRoutes(loggedInUser.getId()); // 新增此行
            session.setAttribute("recommendedRoutes", recommendedRoutes); // 新增此行

            //地图坐标信息
            List<Geocoding> points = redGeocodingService.getAllRedScenics();
            System.out.println("points1111:" + points);
            session.setAttribute("points", points);
            //每个省份的景点数据统计
            List<Map<String, Object>> counts = redGeocodingService.getProvinceCounts();
            session.setAttribute("counts", counts);

            //查询热门景点和热门路线的列表信息
            List<ScenicSpot> scenicList = scenicService.listTopScenics(300);
            List<TravelRoute> routeList = routeService.listTopRoutes(300);
            List<News> newsList = newsService.listTopNews(300);
            List<Study> studyList = studyService.listTopStudy(300);
            session.setAttribute("studyList", studyList);
            List<TravelNotes> travelNotesList = travelNotesService.listTopTravelNotes(300);
            session.setAttribute("travelNotesList", travelNotesList);

            //查询用户的收藏信息
            List<ScenicSpot> favoriteScenics = scenicService.listFavoritesByUserId(loggedInUser.getId());
            List<TravelRoute> favoriteRoutes = routeService.listFavoritesByUserId(loggedInUser.getId());
            List<TravelNotes> favoriteTravelNotes = travelNotesService.listFavoritesByUserId(loggedInUser.getId());

            List<TravelNotes> mytravelNotesList = travelNotesService.listByUserId(loggedInUser.getId());
            List<Comment> commentList = commentService.listByUserId(loggedInUser.getId());

            //更新会话数据
            session.setAttribute("favoriteScenics", favoriteScenics);
            session.setAttribute("favoriteRoutes", favoriteRoutes);
            session.setAttribute("favoriteTravelNotes", favoriteTravelNotes);
            session.setAttribute("mytravelNotesList", mytravelNotesList);
            session.setAttribute("commentList", commentList);
            session.setAttribute("scenicList", scenicList);
            session.setAttribute("routeList", routeList);
            session.setAttribute("newsList", newsList);

            return ResponseResult.success();
        } catch (Exception e) {
            return ResponseResult.fail("刷新用户数据失败: " + e.getMessage());
        }
    }

    //用户登录
    @PostMapping("/login")
    public ResponseResult<User> login(@RequestBody Map<String, String> credentials, HttpSession session) {
        String email = credentials.get("email"); // 使用 email 登录
        String password = credentials.get("password");
        User loggedInUser = userService.loginByEmail(email, password);
        if (loggedInUser != null) {
            session.setAttribute("user", loggedInUser);


            // 新增：刷新推荐景点
            List<ScenicSpot> recommendedScenics = recommendationService.recommendScenics(loggedInUser.getId());
            session.setAttribute("recommendedScenics", recommendedScenics);
            // 新增：刷新推荐路线
            List<TravelRoute> recommendedRoutes = recommendationService.recommendRoutes(loggedInUser.getId()); // 新增此行
            session.setAttribute("recommendedRoutes", recommendedRoutes); // 新增此行

            List<Study> studyList = studyService.listTopStudy(300);
            session.setAttribute("studyList", studyList);

            List<TravelNotes> travelNotesList = travelNotesService.listTopTravelNotes(300);
            session.setAttribute("travelNotesList", travelNotesList);


            //地图坐标信息
            List<Geocoding> points = redGeocodingService.getAllRedScenics();
            System.out.println("points11112:" + points);
            session.setAttribute("points", points);
            //每个省份的景点数据统计
            List<Map<String, Object>> counts = redGeocodingService.getProvinceCounts();
            session.setAttribute("counts", counts);

            //查询热门景点和热门路线的列表信息
            List<ScenicSpot> scenicList = scenicService.listTopScenics(300);
            List<TravelRoute> routeList = routeService.listTopRoutes(300);
            List<News> newsList = newsService.listTopNews(300);
            //查询用户的收藏信息
            List<ScenicSpot> favoriteScenics = scenicService.listFavoritesByUserId(loggedInUser.getId());
            List<TravelRoute> favoriteRoutes = routeService.listFavoritesByUserId(loggedInUser.getId());
            session.setAttribute("favoriteScenics", favoriteScenics);
            session.setAttribute("favoriteRoutes", favoriteRoutes);
            List<TravelNotes> favoriteTravelNotes = travelNotesService.listFavoritesByUserId(loggedInUser.getId());

            List<TravelNotes> mytravelNotesList = travelNotesService.listByUserId(loggedInUser.getId());

            session.setAttribute("favoriteTravelNotes", favoriteTravelNotes);
            session.setAttribute("mytravelNotesList", mytravelNotesList);

            //查询用户的评论信息
            List<Comment> commentList = commentService.listByUserId(loggedInUser.getId());
            session.setAttribute("commentList", commentList);

            //将热门景点和热门路线信息放入会话中
            session.setAttribute("scenicList", scenicList);
            session.setAttribute("routeList", routeList);
            session.setAttribute("newsList", newsList);

            return ResponseResult.success(loggedInUser, "登录成功");
        } else {
            return ResponseResult.fail("账号或密码错误");
        }
    }

    //更新用户信息（根据前端JS调用的/update路径）
    @PostMapping("/update")
    public ResponseResult<User> updateUser(@RequestBody User user, HttpSession session) {
        try {
            //校验必要字段
            if (user.getId() == null) {

                return ResponseResult.fail("用户ID不能为空");
            }

            //获取当前登录用户
            User loggedInUser = (User) session.getAttribute("user");

            //执行更新
            int result = userService.updateUser(user);

            if (result > 0) {
                //如果是修改当前登录用户自己的信息，需要更新session
                if (loggedInUser.getId().equals(user.getId())) {
                    User updatedUser = userService.getUserById(user.getId());
                    session.setAttribute("user", updatedUser);
                }
                return ResponseResult.success("用户信息更新成功");
            } else {
                return ResponseResult.fail("用户信息更新失败");
            }
        } catch (Exception e) {
            return ResponseResult.fail("用户信息更新异常: " + e.getMessage());
        }
    }

    //用户登出
    @PostMapping("/logout")
    public ResponseResult<Void> logout(HttpSession session) {
        session.removeAttribute("user");
        return ResponseResult.success();
    }

    //获取用户信息
//    @GetMapping("/info")
//    public ResponseResult<User> getInfo(HttpSession session) {
//        User user = (User) session.getAttribute("user");
//        return ResponseResult.success(user);
//    }
    @GetMapping("/info")
    public ResponseResult<User> getInfo(HttpSession session, HttpServletResponse response) {
        // 禁止缓存
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        User user = (User) session.getAttribute("user");
        return ResponseResult.success(user);
    }


    //修改用户信息
    @PutMapping("/edit")
    public ResponseResult<Void> editUser(@RequestBody User user) {
        try {
            userService.editUser(user);
            return ResponseResult.success("用户信息修改成功");
        } catch (Exception e) {
            return ResponseResult.fail("用户信息修改失败: " + e.getMessage());
        }
    }

    //添加用户
    @PostMapping("/add")
    public ResponseResult<Void> addUser(@RequestBody User user) {
        try {
            userService.addUser(user);
            return ResponseResult.success("用户添加成功");
        } catch (Exception e) {
            return ResponseResult.fail("用户添加失败: " + e.getMessage());
        }
    }

    //删除用户
    @DeleteMapping("/delete/{id}")
    public ResponseResult<Void> deleteUser(@PathVariable Integer id) {
        try {
            userService.deleteUser(id);
            return ResponseResult.success("用户删除成功");
        } catch (Exception e) {
            return ResponseResult.fail("用户删除失败: " + e.getMessage());
        }
    }

    //获取所有用户信息
    @GetMapping("/getAll")
    public ResponseResult<List<User>> getAllUsers() {
        try {
            List<User> users = userService.getAllUsers();
            System.out.println("users:" + users);
            return ResponseResult.success(users);
        } catch (Exception e) {
            return ResponseResult.fail("获取用户列表失败: " + e.getMessage());
        }
    }

    //根据用户ID获取用户信息
    @GetMapping("/{id}")
    public ResponseResult<User> getUserById(@PathVariable Integer id) {
        try {
            User user = userService.getUserById(id);
            return ResponseResult.success(user);
        } catch (Exception e) {
            return ResponseResult.fail("获取用户信息失败: " + e.getMessage());
        }
    }

    // 获取用户详情
    @GetMapping("/detail/{userId}")
    public ResponseResult<User> getUserDetail(@PathVariable Integer userId) {
        try {
            User user = userService.getUserDetail(userId);
            return ResponseResult.success(user);
        } catch (Exception e) {
            return ResponseResult.fail("获取用户详情失败: " + e.getMessage());
        }
    }

    // 修改密码4.11
    @PostMapping("/changePassword")
    public ResponseResult<Void> changePassword(@RequestBody Map<String, String> params, HttpSession session) {
        try {
            User user = (User) session.getAttribute("user");
            if (user == null) {
                return ResponseResult.fail(401, "用户未登录");
            }

            String oldPassword = params.get("oldPassword");
            String newPassword = params.get("newPassword");

            boolean result = userService.changePassword(user.getId(), oldPassword, newPassword);
            return result ? ResponseResult.success("密码修改成功")
                    : ResponseResult.fail("原密码不正确");
        } catch (Exception e) {
            return ResponseResult.fail("修改密码失败: " + e.getMessage());
        }
    }

    // 上传头像
    @PostMapping("/uploadAvatar")
    @ResponseBody
    public ResponseResult<String> uploadAvatar(
            @RequestParam("file") MultipartFile file,
            @RequestParam("userId") Integer userId) {
        try {
            if (file.isEmpty()) {
                return ResponseResult.fail("请选择要上传的文件");
            }

            User user = userService.getById(userId);
            if (user == null) {
                return ResponseResult.fail("用户不存在");
            }

//            user.setAvatar(file.getBytes());
            String avatarPath = saveImage(file);
            user.setAvatar(USER_ACCESS_PATH + avatarPath);
            userService.updateById(user);

            return ResponseResult.success("头像上传成功");
        } catch (Exception e) {
            return ResponseResult.fail("上传失败: " + e.getMessage());
        }
    }

    @GetMapping("/avatar/{userId}")
    public void getAvatar(@PathVariable Integer userId, HttpServletResponse response) throws IOException {
        User user = userService.getById(userId);
        if (user != null && user.getAvatar() != null) {
            String avatarPath = getRealUploadPath() + user.getAvatar().substring(USER_ACCESS_PATH.length());
            File avatarFile = new File(avatarPath);
            if (avatarFile.exists()) {
                response.setContentType("image/jpeg");
                response.getOutputStream().write(Files.readAllBytes(avatarFile.toPath()));
                response.getOutputStream().flush();
            } else {
                // 返回默认头像
                response.sendRedirect("/assets/images/default-avatar1.png");
            }
        } else {
            // 返回默认头像
            response.sendRedirect("/assets/images/default-avatar1.png");
        }
    }


    // 搜索用户
    @GetMapping("/search")
    public ResponseResult<List<User>> searchUsers(
            @RequestParam(required = false) String keyword,
            @RequestParam(defaultValue = "1") Integer page,
            @RequestParam(defaultValue = "10") Integer size) {
        try {
            List<User> users = userService.searchUsers(keyword, page, size);
            return ResponseResult.success(users);
        } catch (Exception e) {
            return ResponseResult.fail("搜索用户失败: " + e.getMessage());
        }
    }

    @PostMapping("/updateStatus")
    @PutMapping("/updateStatus")
    @ResponseBody
    public ResponseResult<Void> updateStatus(@RequestBody Map<String, Object> params) {
        try {
            Integer id = Integer.valueOf(params.get("id").toString());
            Integer status = Integer.valueOf(params.get("status").toString());

            // 参数校验
            if (id == null || status == null) {
                return ResponseResult.fail("参数不能为空");
            }

            // 状态值校验
            if (status != 0 && status != 1) {
                return ResponseResult.fail("状态值无效，仅支持0（禁用）和1（正常）");
            }

            int result = userService.updateStatus(id, status);
            if (result > 0) {
                return ResponseResult.success("状态更新成功");
            }
            return ResponseResult.fail("状态更新失败");
        } catch (Exception e) {
            return ResponseResult.fail("状态更新异常: " + e.getMessage());
        }
    }

    @PostMapping("/send-email-code")
    @ResponseBody
    public ResponseResult<?> sendEmailCode(@RequestParam("email") String email) {
        try {
            // Validate email format
            if (!email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$")) {
                return ResponseResult.fail("邮箱格式不正确");
            }

            // Generate 6-digit random code
            String code = String.format("%06d", new Random().nextInt(999999));

            // Save code to database
            userService.updateSmsCode(email, code);

            // Send email
            String subject = "验证码";
            String text = "您的验证码是: " + code;
            emailService.sendSimpleEmail(email, subject, text);

            return ResponseResult.success("验证码已发送");
        } catch (Exception e) {
            return ResponseResult.fail("验证码发送失败: " + e.getMessage());
        }
    }

    @PostMapping("/reset-password-by-email")
    public ResponseResult<?> resetPasswordByEmail(
            @RequestParam String email,
            @RequestParam String emailCode,
            @RequestParam String newPassword) {
        try {
            User user = userService.findByEmail(email);
            if (user == null) {
                return ResponseResult.fail("该邮箱未注册");
            }

            if (!userService.validateEmailCode(user, emailCode)) {
                return ResponseResult.fail("验证码错误或已过期");
            }

            // 使用Argon2加密新密码
            char[] passwordChars = newPassword.toCharArray();
            String encryptedPassword = argon2.hash(10, 65536, 1, passwordChars);
            Arrays.fill(passwordChars, '\0'); // 清除内存中的密码

            userService.updatePasswordByEmail(user.getId(), encryptedPassword);
            return ResponseResult.success("密码重置成功");
        } catch (Exception e) {
            return ResponseResult.fail("密码重置失败：" + e.getMessage());
        }
    }
}