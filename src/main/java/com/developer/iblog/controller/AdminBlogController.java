package com.developer.iblog.controller;

import com.developer.iblog.common.web.AbstractController;
import com.developer.iblog.model.persistent.BlogCategory;
import com.developer.iblog.service.IBlogCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

/**
 * Created by cnbo on 17-4-1.
 */
@Controller
@RequestMapping("/admin/blog")
public class AdminBlogController extends AbstractController {

    @Autowired
    private IBlogCategoryService categoryService;

    @RequestMapping(value = "/write", method = RequestMethod.GET)
    public String writeBlog() {

        List<BlogCategory> blogCategories = categoryService.getAllBlogCategory();
        setModelAttribute("blogCategories", blogCategories);

        return "admin/blog-write";
    }

}
