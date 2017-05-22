package com.developer.iblog.dao.mapper;

import com.developer.iblog.model.persistent.Blog;
import com.developer.iblog.model.persistent.BlogComment;
import com.developer.iblog.model.persistent.WebVisitor;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by cnbo on 17-5-21.
 */
public interface ManageCommentMapper {

    List<BlogComment> getByPage(@Param("start") Integer start,
                                @Param("pageCount") Integer pageCount,
                                @Param("comment") String comment);

    int getCommentCount(@Param("comment") String comment);

    Integer deleteComment(Integer commentId);

}
