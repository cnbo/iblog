package com.developer.iblog.service;

import com.developer.iblog.model.persistent.BlogCategory;

import java.util.List;

/**
 * Created by cnbo on 17-4-1.
 */
public interface IBlogCategoryService {

    Integer saveCategory(String categoryName);

    List<BlogCategory> getAllBlogCategory();

    List<BlogCategory> getCategoriesByPage(Integer start, Integer pageCount, String categoryName);

    Integer getPages(Integer pageCount, String categoryName);

    Integer deleteCategory(Integer id);

    Integer updateCategory(BlogCategory blogCategory);

}
