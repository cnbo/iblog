package com.developer.iblog.controller;

import com.developer.iblog.common.web.AbstractController;
import com.developer.iblog.model.dto.AdminDTO;
import com.developer.iblog.model.persistent.Admin;
import com.developer.iblog.model.persistent.Blog;
import com.developer.iblog.model.persistent.FriendlyLink;
import com.developer.iblog.service.*;
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
    private IFriendlyLinkService friendlyLinkService;

    @Autowired
    private IAdminService adminService;

    @Autowired
    private IBlogService blogService;

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index() {
        int pageCount = 5;
        String pageStr =  getRequest().getParameter("page");
        String title = getRequest().getParameter("title");
        Integer page = 1;
        if (pageStr != null) {
            page = Integer.valueOf(pageStr);
        }
        List<Blog> blogs = blogService.getBlogByPage((page - 1) * pageCount,
                pageCount, title);
        int pages = blogService.getPages(pageCount, title);

        List<FriendlyLink> friendlyLinks = friendlyLinkService.getAll();
        Admin admin = adminService.selectAdmin();
        List<Blog> topBlogs = blogService.getTopFiveBlog();
        List<Blog> recentBlogs = blogService.getRecentFiveBlog();

        setModelAttribute("friendlyLinks", friendlyLinks);
        setModelAttribute("admin", admin);
        setModelAttribute("topBlogs", topBlogs);
        setModelAttribute("recentBlogs", recentBlogs);
        setModelAttribute("blogs", blogs);
        setModelAttribute("page", page);
        setModelAttribute("pages", pages);

        return "web/index";
    }


    @RequestMapping(value = "/about", method = RequestMethod.GET)
    public String resume() {

        AdminDTO adminDTO = webAuthorService.getAdminDTO();
        setModelAttribute("adminDTO", adminDTO);

        return "web/about";
    }


}
