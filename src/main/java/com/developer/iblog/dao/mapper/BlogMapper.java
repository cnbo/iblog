package com.developer.iblog.dao.mapper;

import com.developer.iblog.model.persistent.Blog;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by cnbo on 17-4-16.
 */
public interface BlogMapper {

    void saveBlog(Blog blog);

    Integer deleteBlogById(Integer id);

    Integer updateBlog(Blog blog);

    Blog getBlogById(Integer id);

    List<Blog> getByPage(@Param("start") Integer start,
                         @Param("pageCount") Integer pageCount,
                         @Param("title") String title);

    Integer getBlogCount(@Param("title") String title);

    List<Blog> getTopFiveBlog();

    List<Blog> getRecentFiveBlog();

}
