package com.developer.iblog.controller;

import com.developer.iblog.common.web.AbstractController;
import com.developer.iblog.model.persistent.Blog;
import com.developer.iblog.service.IBlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by cnbo on 17-4-27.
 */
@Controller
@RequestMapping(value = "/blog")
public class WebBlogController extends AbstractController {
    @Autowired
    private IBlogService blogService;

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String toWebBlog(@PathVariable Integer id) {
        Blog blog = blogService.getBlogById(id);
        setModelAttribute("blog", blog);

        return "web/blog";
    }

}
