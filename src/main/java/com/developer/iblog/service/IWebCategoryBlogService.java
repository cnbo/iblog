package com.developer.iblog.service;

import com.developer.iblog.model.dto.WebCateogriesBlogsDTO;

import java.util.List;

/**
 * Created by cnbo on 17-4-27.
 */
public interface IWebCategoryBlogService {

    List<WebCateogriesBlogsDTO> getWebCategoriesBlogs();

}
