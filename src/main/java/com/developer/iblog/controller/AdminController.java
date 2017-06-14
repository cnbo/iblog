package com.developer.iblog.controller;

import com.developer.iblog.common.web.AbstractController;
import com.developer.iblog.model.dto.AdminDTO;
import com.developer.iblog.model.persistent.Admin;
import com.developer.iblog.model.persistent.Blog;
import com.developer.iblog.model.persistent.BlogComment;
import com.developer.iblog.model.persistent.FriendlyLink;
import com.developer.iblog.service.IAdminService;
import com.developer.iblog.service.IBlogService;
import com.developer.iblog.service.IFriendlyLinkService;
import com.developer.iblog.service.IManageCommentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * Created by cnbo on 17-3-22.
 */
@Controller
@RequestMapping("/admin")
public class AdminController extends AbstractController {

    @Autowired
    private IAdminService adminService;

    @Autowired
    private IBlogService blogService;

    @Autowired
    private IFriendlyLinkService linkService;

    @Autowired
    private IManageCommentService commentService;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String toLogin() {
        return "admin/login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(Admin admin) {
        boolean loginSuccess = adminService.isLogin(admin);
        if (loginSuccess) {
            adminLoginSuccess(admin);
            return "redirect:index.do";
        } else {
            setModelAttribute("error", "username or password is error");
        }
        return "admin/login";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout() {
        adminLogoutSuccess();

        return "admin/login";
    }

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String toAdminIndex() {
        List<FriendlyLink> links = linkService.getAll();
        List<Blog> recentBlogs = blogService.getRecentFiveBlog();
        Integer countOfPublishBlog = blogService.getPublishBlogCount();
        List<BlogComment> comments = commentService.getRecentComment();
        Integer countOfComment = commentService.getCommentCount();

        Integer linkCount = links == null ? 0 : links.size();
        setModelAttribute("linkCount", linkCount);
        setModelAttribute("recentBlogs", recentBlogs);
        setModelAttribute("publishCount", countOfPublishBlog);
        setModelAttribute("comments", comments);
        setModelAttribute("commentCount", countOfComment);

        return "admin/index";
    }

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String toProfile() {
        String name = ((Admin) getSessionAttribute("admin")).getUsername();
        Admin admin =
            adminService.selectAdminByName(name);
        setModelAttribute("admin", admin);

        return "admin/profile";
    }

    @RequestMapping(value = "/profile", method = RequestMethod.POST)
    public void profile(@RequestParam("avatar") MultipartFile multipartFile) {
        Admin admin = (Admin) getSessionAttribute("admin");
        setAdmin(admin);
                adminService.updateAdmin(admin);

        if (!multipartFile.isEmpty()) {

            //判断multipartFile是否空
            //判断文件是否是规定格式的图片
            //判断文件的大小

            //指定文件的存储路径
            String filePath = getRequest().getSession().getServletContext().getRealPath("/")
                + "uploads/"
                + "avatar"
                + multipartFile.getOriginalFilename().substring(
                        multipartFile.getOriginalFilename().lastIndexOf("."));
            try {
                multipartFile.transferTo(new File(filePath));
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            logger.info("img is null");
        }
    }

    private void setAdmin(Admin admin) {
        HttpServletRequest request = getRequest();
        String nickName = request.getParameter("nickname");
        String email = request.getParameter("email");
        String github = request.getParameter("github");
        String introduction = request.getParameter("introduction");

        admin.setNickname(nickName);
        admin.setEmail(email);
        admin.setGithub(github);
        admin.setIntroduction(introduction);

    }


    @RequestMapping(value = "/modify/pass", produces = "application/json", method = RequestMethod.POST)
    public @ResponseBody Boolean modifyPassword(@RequestBody AdminDTO adminDTO) {
        Admin admin = (Admin) getSessionAttribute("admin");
        Boolean modifyResult = adminService.modifyPassword(admin, adminDTO);
        if (modifyResult) {
            logger.info("success");
        } else {
            logger.info("failure");
        }

        return modifyResult;
    }

    @RequestMapping(value = "/save/resume", produces = "application/json", method = RequestMethod.POST)
    public @ResponseBody Admin saveResume(@RequestBody Admin admin) {

        admin.setUsername("cnbo");
        adminService.updateAdmin(admin);

        logger.info(admin.getResumeMd());

        return admin;
    }
}
