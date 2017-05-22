package com.developer.iblog.service.impl;

import com.developer.iblog.dao.mapper.BlogMapper;
import com.developer.iblog.dao.mapper.ManageCommentMapper;
import com.developer.iblog.dao.mapper.VisitorMapper;
import com.developer.iblog.model.dto.AdminCommentDTO;
import com.developer.iblog.model.dto.CommentInfoDTO;
import com.developer.iblog.model.persistent.Blog;
import com.developer.iblog.model.persistent.BlogComment;
import com.developer.iblog.model.persistent.WebVisitor;
import com.developer.iblog.service.IManageCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by cnbo on 17-5-21.
 */
@Service
public class ManageCommentServiceImpl implements IManageCommentService {

    @Autowired
    private ManageCommentMapper commentMapper;

    @Autowired
    private BlogMapper blogMapper;

    @Autowired
    private VisitorMapper visitorMapper;

    @Override
    public List<CommentInfoDTO> getByPage(AdminCommentDTO adminCommentDTO) {
        List<BlogComment> comments = commentMapper.getByPage(
                (adminCommentDTO.getPage() - 1) * adminCommentDTO.getPageCount(),
                adminCommentDTO.getPageCount(),
                adminCommentDTO.getComment());
        List<CommentInfoDTO> commentInfoDTOS = new ArrayList<>();
        for (BlogComment comment : comments) {
            WebVisitor visitor = visitorMapper.getCommentVisitor(comment.getWebVisitorId());
            Blog blog = blogMapper.getBlogById(comment.getBlogId());
            CommentInfoDTO commentInfoDTO = new CommentInfoDTO();
            commentInfoDTO.setVisitor(visitor);
            commentInfoDTO.setBlog(blog);
            commentInfoDTO.setComment(comment);
            commentInfoDTOS.add(commentInfoDTO);
        }

        return commentInfoDTOS;
    }

    @Override
    public Integer getPages(AdminCommentDTO adminCommentDTO) {
        int commentCount = commentMapper.getCommentCount(adminCommentDTO.getComment());
        int pages = (int) Math.ceil((double) commentCount / adminCommentDTO.getPageCount());

        return pages;
    }

    @Override
    public Integer deleteComment(Integer commentId) {
        return commentMapper.deleteComment(commentId);
    }
}
