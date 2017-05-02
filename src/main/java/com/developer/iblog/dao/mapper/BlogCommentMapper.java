package com.developer.iblog.dao.mapper;

import com.developer.iblog.model.persistent.BlogComment;

import java.util.List;

/**
 * Created by cnbo on 17-5-1.
 */
public interface BlogCommentMapper {

    Integer insertComment(BlogComment comment);

    Integer deleteCommentByPrimaryKey(Integer id);

    Integer updateComment(BlogComment comment);

    BlogComment selectByPrimaryKey(Integer id);

    List<BlogComment> getCommentByBlogKey(Integer blogId);

    List<BlogComment> getReplyCommentByCommentKey(Integer id);
}
