package com.developer.iblog.service;


import com.developer.iblog.model.dto.BlogDTO;
import com.developer.iblog.model.persistent.Blog;

import java.util.List;

/**
 * Created by cnbo on 17-4-16.
 */
public interface IBlogService {

    Integer saveBlog(BlogDTO blogDTO);

    Integer deleteBlogById(Integer id);

    Integer updateBlog(BlogDTO blogDTO);

    Blog getBlogById(Integer id);

    List<Blog> getBlogByPage(Integer start, Integer pageCount, String title);

    Integer getPages(Integer pageCount, String titile);

    List<Blog> getTopFiveBlog();

    List<Blog> getRecentFiveBlog();

}
