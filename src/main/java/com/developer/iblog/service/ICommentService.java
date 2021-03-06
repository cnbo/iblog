package com.developer.iblog.service;

import com.developer.iblog.model.dto.BlogCommentAndReplyDTO;
import com.developer.iblog.model.dto.BlogCommentDTO;
import com.developer.iblog.model.persistent.BlogComment;

import java.util.List;

/**
 * Created by cnbo on 17-5-1.
 */
public interface ICommentService {

    //查看评论
    List<BlogCommentAndReplyDTO> getCommentInfo(Integer blogId);

    //查询评论的回复
    List<BlogCommentDTO> getCommentReplyInfo(Integer commentId);

    //添加评论/回复
    BlogComment insertComment(BlogComment comment, String visitorName);
    
}
