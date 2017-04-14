package com.developer.iblog.controller;

import com.developer.iblog.common.web.AbstractController;
import com.developer.iblog.model.dto.AdminDTO;
import com.developer.iblog.model.persistent.Admin;
import com.developer.iblog.service.IAdminService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;

/**
 * Created by cnbo on 17-3-22.
 */
@Controller
@RequestMapping("/admin")
public class AdminController extends AbstractController {

    @Autowired
    private IAdminService adminService;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String toLogin() {
        return "admin/login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(Admin admin) {
        boolean loginSuccess = adminService.isLogin(admin);
        if (loginSuccess) {
            return "redirect:index.do";
        } else {
            setModelAttribute("error", "username or password is error");
        }
        return "admin/login";
    }

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String toAdminIndex() {
        return "admin/index";
    }

    @RequestMapping(value = "/profile", method = RequestMethod.GET)
    public String toProfile() {
        return "admin/profile";
    }

    /*
    NOTE:谨记@RequestParam的用法
     */
    @RequestMapping(value = "/profile", method = RequestMethod.POST)
    public void profile(Admin admin, @RequestParam("file") MultipartFile multipartFile) {
        admin.setUsername("cnbo");
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

    @RequestMapping(value = "/modify/pass", method = RequestMethod.POST)
    public String modifyPassword(String newPassword, String oldPassword) {
        boolean modifySuccess = adminService.modifyPassword("cnbo", newPassword, oldPassword);
        if (modifySuccess) {
            logger.info("success");
        } else {
            logger.info("failure");
        }

        return "admin/profile";
    }

    @RequestMapping(value = "/save/resume", produces = "application/json", method = RequestMethod.POST)
    public @ResponseBody Admin saveResume(@RequestBody Admin admin) {

        admin.setUsername("cnbo");
        adminService.updateAdmin(admin);

        logger.info(admin.getResumeMd());

        return admin;
    }
}
