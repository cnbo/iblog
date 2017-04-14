package com.developer.iblog.service.impl;

import com.developer.iblog.dao.mapper.CategoryMapper;
import com.developer.iblog.model.persistent.BlogCategory;
import com.developer.iblog.service.IBlogCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by cnbo on 17-4-1.
 */
@Service
public class BlogCategoryServiceImpl implements IBlogCategoryService {

    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public void saveCategory(String  categoryName) {
        BlogCategory blogCategory = new BlogCategory();
        blogCategory.setCategoryName(categoryName);
        categoryMapper.saveCategory(blogCategory);
    }

    @Override
    public List<BlogCategory> getAllBlogCategory() {
        return categoryMapper.getAllCategory();
    }

    @Override
    public List<BlogCategory> getCategoriesByPage(Integer start, Integer pageCount, String categoryName) {
        return categoryMapper.getByPage(start, pageCount, categoryName);
    }

    @Override
    public Integer getPages(Integer pageCount) {
        int categoryCount = categoryMapper.getCategoryCount();
        int pages = (int) Math.ceil((double)categoryCount / pageCount);

        return pages;
    }

    @Override
    public void deleteCategory(Integer id) {
        categoryMapper.deleteCategoryById(id);
    }

    @Override
    public void updateCategory(BlogCategory blogCategory) {
        categoryMapper.updateCategory(blogCategory);
    }

}