package com.developer.iblog.controller;

import com.developer.iblog.common.web.AbstractController;
import com.developer.iblog.model.dto.WebCateogriesBlogsDTO;
import com.developer.iblog.service.IWebCategoryBlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

/**
 * Created by cnbo on 17-4-27.
 */
@Controller
public class WebCatoryController extends AbstractController {

    @Autowired
    private IWebCategoryBlogService webCategoryBlogService;

    @RequestMapping(value = "/category", method = RequestMethod.GET)
    public String toCategories() {
        List<WebCateogriesBlogsDTO> webCateogriesBlogsDTOS =
                webCategoryBlogService.getWebCategoriesBlogs();

        setModelAttribute("categoriesAndBlogs", webCateogriesBlogsDTOS);

        return "web/categories-blogs";
    }

}
