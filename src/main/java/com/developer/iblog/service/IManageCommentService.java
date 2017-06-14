package com.developer.iblog.service;

import com.developer.iblog.model.dto.AdminCommentDTO;
import com.developer.iblog.model.dto.CommentInfoDTO;
import com.developer.iblog.model.persistent.BlogComment;

import java.util.List;

/**
 * Created by cnbo on 17-5-21.
 */
public interface IManageCommentService {

    List<CommentInfoDTO> getByPage(AdminCommentDTO adminCommentDTO);

    Integer getPages(AdminCommentDTO adminCommentDTO);

    Integer deleteComment(Integer commentId);

    Integer getCommentCount();

    List<BlogComment> getRecentComment();

}
