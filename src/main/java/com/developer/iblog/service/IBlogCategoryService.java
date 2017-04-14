package com.developer.iblog.service;

import com.developer.iblog.model.persistent.BlogCategory;

import java.util.List;

/**
 * Created by cnbo on 17-4-1.
 */
public interface IBlogCategoryService {

    void saveCategory(String categoryName);

    List<BlogCategory> getAllBlogCategory();

    List<BlogCategory> getCategoriesByPage(Integer start, Integer pageCount, String categoryName);

    Integer getPages(Integer pageCount);

    void deleteCategory(Integer id);

    void updateCategory(BlogCategory blogCategory);

}
