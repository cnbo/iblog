package com.developer.iblog.service.impl;

import com.developer.iblog.dao.mapper.BlogMapper;
import com.developer.iblog.dao.mapper.CategoryMapper;
import com.developer.iblog.model.dto.BlogDTO;
import com.developer.iblog.model.persistent.Blog;
import com.developer.iblog.model.persistent.BlogCategory;
import com.developer.iblog.service.IBlogService;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by cnbo on 17-4-16.
 */
@Service
public class BlogServiceImpl implements IBlogService {

    @Autowired
    private BlogMapper blogMapper;

    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public Integer saveBlog(BlogDTO blogDTO) {
        if (blogDTO.getCategoryId() == null ) {
            BlogCategory blogCategory = new BlogCategory();
            String categoryName = blogDTO.getCategoryName();
            blogCategory.setCategoryName(categoryName);
            categoryMapper.saveCategory(blogCategory);
            blogDTO.setCategoryId(blogCategory.getId());
        }

        Blog blog = new Blog();
        blog.setCategoryId(blogDTO.getCategoryId());
        blog.setBlogMd(blogDTO.getBlogMd());
        blog.setBlogHtml(blogDTO.getBlogHtml());
        blog.setTitle(blogDTO.getTitle());
        blog.setReadTimes(0);
        blog.setCommentTimes(0);
        blog.setLoveTimes(0);
        blog.setStatus(0);

        blogMapper.saveBlog(blog);

        return blog.getId();
    }

    public Integer deleteBlogById(Integer id) {
        return blogMapper.deleteBlogById(id);
    }

    @Override
    public Integer updateBlog(BlogDTO blogDTO) {
        Integer categoryId = blogDTO.getCategoryId();
        if (categoryId == null) {
            categoryId = categoryMapper.getCategoryByName(blogDTO.getCategoryName()).getId();
        }

        Blog blog = new Blog();
        blog.setId(blogDTO.getId());
        blog.setCategoryId(categoryId);
        blog.setBlogMd(blogDTO.getBlogMd());
        blog.setBlogHtml(blogDTO.getBlogHtml());
        blog.setTitle(blogDTO.getTitle());
        blog.setStatus(blogDTO.getStatus());

        return blogMapper.updateBlog(blog);
    }

    @Override
    public Blog getBlogById(Integer id) {
        return blogMapper.getBlogById(id);
    }

    @Override
    public List<Blog> getBlogByPage(Integer start, Integer pageCount, String title) {
        List<Blog> blogs = blogMapper.getByPage(start, pageCount, title);
        transBlogHtmlToText(blogs);

        return blogs;
    }

    public void transBlogHtmlToText(List<Blog> blogs) {
        for (Blog blog : blogs) {
            Document doc = Jsoup.parse(blog.getBlogHtml());
            String blogText = doc.body().text();
            if (blogText.length() > 100) {
                blogText = blogText.substring(0, 100) + "...";
            }
            blog.setBlogHtml(blogText);
        }
    }

    @Override
    public Integer getPages(Integer pageCount, String title) {
        int blogCount = blogMapper.getBlogCount(title);
        int pages = (int) Math.ceil((double)blogCount / pageCount);

        return pages;
    }

    @Override
    public List<Blog> getTopFiveBlog() {
        return blogMapper.getTopFiveBlog();
    }

    @Override
    public List<Blog> getRecentFiveBlog() {
        return blogMapper.getRecentFiveBlog();
    }

}
