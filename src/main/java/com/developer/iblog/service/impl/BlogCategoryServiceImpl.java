package com.developer.iblog.service.impl;

import com.developer.iblog.dao.mapper.BlogMapper;
import com.developer.iblog.dao.mapper.CategoryMapper;
import com.developer.iblog.model.persistent.Blog;
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

    @Autowired
    private BlogMapper blogMapper;

    @Override
    public Integer saveCategory(String  categoryName) {
        BlogCategory blogCategory = new BlogCategory();
        blogCategory.setCategoryName(categoryName);
        categoryMapper.saveCategory(blogCategory);
        return blogCategory.getId();
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
    public Integer getPages(Integer pageCount, String categoryName) {
        int categoryCount = categoryMapper.getCategoryCount(categoryName);
        int pages = (int) Math.ceil((double)categoryCount / pageCount);

        return pages;
    }

    @Override
    public Integer deleteCategory(Integer id) {
        Integer deleteResult = categoryMapper.deleteCategoryById(id);
        List<Blog> blogs = blogMapper.getAllBlogByCategory(id);
        if (deleteResult > 0 && blogs.size() > 0) {
            BlogCategory category = categoryMapper.getCategoryByName("java");
            if (category == null) {
                category = new BlogCategory();
                category.setCategoryName("java");
                categoryMapper.saveCategory(category);
            }
            blogMapper.updateBlogsCategory(category.getId(), id);
        }

        return deleteResult;
    }

    @Override
    public Integer updateCategory(BlogCategory blogCategory) {
       return categoryMapper.updateCategory(blogCategory);
    }

}
