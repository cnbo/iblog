package com.developer.iblog.controller;

import com.developer.iblog.common.web.AbstractController;
import com.developer.iblog.model.dto.AdminDTO;
import com.developer.iblog.model.persistent.Admin;
import com.developer.iblog.model.persistent.Blog;
import com.developer.iblog.model.persistent.BlogCategory;
import com.developer.iblog.model.persistent.FriendlyLink;
import com.developer.iblog.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

/**
 * Created by cnbo on 17-3-29.
 */
@Controller
public class WebController extends AbstractController {

    @Autowired
    private IWebAuthorService webAuthorService;

    @Autowired
    private IBlogCategoryService categoryService;

    @Autowired
    private IFriendlyLinkService friendlyLinkService;

    @Autowired
    private IAdminService adminService;

    @Autowired
    private IBlogService blogService;

    @RequestMapping(value = "index", method = RequestMethod.GET)
    public String index() {
        List<BlogCategory> categories = categoryService.getAllBlogCategory();
        List<FriendlyLink> friendlyLinks = friendlyLinkService.getAll();
        Admin admin = adminService.selectAdmin();
        List<Blog> topBlogs = blogService.getTopFiveBlog();
        List<Blog> recentBlogs = blogService.getRecentFiveBlog();

        setModelAttribute("categories", categories);
        setModelAttribute("friendlyLinks", friendlyLinks);
        setModelAttribute("admin", admin);
        setModelAttribute("topBlogs", topBlogs);
        setModelAttribute("recentBlogs", recentBlogs);

        return "web/index";
    }

    @RequestMapping(value = "/author/resume", method = RequestMethod.GET)
    public String resume() {

        AdminDTO adminDTO = webAuthorService.getAdminDTO();
        setModelAttribute("adminDTO", adminDTO);

        return "web/resume";
    }

}