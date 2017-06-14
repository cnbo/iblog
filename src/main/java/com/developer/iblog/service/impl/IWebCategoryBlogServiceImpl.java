package com.developer.iblog.service.impl;

import com.developer.iblog.dao.mapper.BlogMapper;
import com.developer.iblog.dao.mapper.CategoryMapper;
import com.developer.iblog.model.dto.WebCateogriesBlogsDTO;
import com.developer.iblog.model.persistent.Blog;
import com.developer.iblog.model.persistent.BlogCategory;
import com.developer.iblog.service.IWebCategoryBlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by cnbo on 17-4-27.
 */
@Service
public class IWebCategoryBlogServiceImpl implements IWebCategoryBlogService {

    @Autowired
    private CategoryMapper categoryMapper;

    @Autowired
    private BlogMapper blogMapper;

    @Override
    public List<WebCateogriesBlogsDTO> getWebCategoriesBlogs() {
        List<WebCateogriesBlogsDTO> webCateogriesBlogsDTOS = new ArrayList<>();
        List<BlogCategory> categories = categoryMapper.getAllCategory();

        for (BlogCategory category : categories) {
            WebCateogriesBlogsDTO webCateogriesBlogsDTO = new WebCateogriesBlogsDTO();
            List<Blog> blogs = blogMapper.getAllPublishBlogByCategory(category.getId());
            webCateogriesBlogsDTO.setCategory(category);
            webCateogriesBlogsDTO.setBlogs(blogs);
            webCateogriesBlogsDTOS.add(webCateogriesBlogsDTO);
        }

        return webCateogriesBlogsDTOS;

    }


}
