package com.developer.iblog.service.impl;

import com.developer.iblog.common.bean.ExceptionType;
import com.developer.iblog.common.exception.BusinessException;
import com.developer.iblog.dao.mapper.BlogCommentMapper;
import com.developer.iblog.dao.mapper.BlogMapper;
import com.developer.iblog.dao.mapper.WebVisitorMapper;
import com.developer.iblog.model.dto.BlogCommentAndReplyDTO;
import com.developer.iblog.model.dto.BlogCommentDTO;
import com.developer.iblog.model.persistent.Blog;
import com.developer.iblog.model.persistent.BlogComment;
import com.developer.iblog.model.persistent.WebVisitor;
import com.developer.iblog.service.ICommentService;
import org.apache.commons.lang3.StringEscapeUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by cnbo on 17-5-1.
 */
@Service
public class CommentServiceImpl implements ICommentService {

    private Logger logger = LoggerFactory.getLogger(CommentServiceImpl.class);

    public static final String COMMENT_CUT = ",";

    @Autowired
    private BlogCommentMapper commentMapper;

    @Autowired
    private WebVisitorMapper visitorMapper;

    @Autowired
    private BlogMapper blogMapper;

    /**
     * 查看评论
     * @param blogId
     * @return
     */
    @Override
    public List<BlogCommentAndReplyDTO> getCommentInfo(Integer blogId) {

        //获取主评论
        List<BlogComment> blogComments = commentMapper.getCommentByBlogKey(blogId);

        //用于返回结果集
        List<BlogCommentAndReplyDTO> blogCommentAndReplyDTOS = new ArrayList<>();

        for (BlogComment blogComment : blogComments) {
            WebVisitor visitor = visitorMapper.getByKey(blogComment.getWebVisitorId());
            WebVisitor newVisitor = new WebVisitor();
            newVisitor.setAvatar(visitor.getAvatar());
            newVisitor.setId(visitor.getId());
            newVisitor.setVisitorName(visitor.getVisitorName());

            List<BlogCommentDTO> blogCommentDTOS = getCommentReplyInfo(blogComment.getId());

            BlogCommentAndReplyDTO blogCommentAndReplyDTO = new BlogCommentAndReplyDTO();
            blogCommentAndReplyDTO.setComment(blogComment);
            blogCommentAndReplyDTO.setVisitor(newVisitor);
            blogCommentAndReplyDTO.setBlogCommentDTOS(blogCommentDTOS);

            blogCommentAndReplyDTOS.add(blogCommentAndReplyDTO);
        }

        return blogCommentAndReplyDTOS;
    }

    /**
     * 获取评论回复
     * @param commentId
     * @return
     */
    @Override
    public List<BlogCommentDTO> getCommentReplyInfo(Integer commentId) {

        //获取评论的回复
        List<BlogComment> blogComments = commentMapper.getReplyCommentByCommentKey(commentId);
        //用于返回的结果集
        List<BlogCommentDTO> blogCommentDTOS = new ArrayList<>();

        for (BlogComment blogComment : blogComments) {
            WebVisitor visitor = visitorMapper.getByKey(blogComment.getWebVisitorId());
            WebVisitor newVisitor = new WebVisitor();
            newVisitor.setId(visitor.getId());
            newVisitor.setAvatar(visitor.getAvatar());
            newVisitor.setVisitorName(visitor.getVisitorName());

            //获取父评论
            BlogComment parentComment =
                    commentMapper.selectByPrimaryKey(blogComment.getReplyCommentId());
            WebVisitor parentVisitor = visitorMapper.getByKey(parentComment.getWebVisitorId());
            WebVisitor newParentVisitor = new WebVisitor();
            newParentVisitor.setId(parentVisitor.getId());
            newParentVisitor.setAvatar(parentVisitor.getAvatar());
            newParentVisitor.setVisitorName(parentVisitor.getVisitorName());

            BlogCommentDTO blogCommentDTO = new BlogCommentDTO();
            blogCommentDTO.setComment(blogComment);
            blogCommentDTO.setVisitor(newVisitor);
            blogCommentDTO.setParentVisitor(newParentVisitor);

            blogCommentDTOS.add(blogCommentDTO);
        }

        return blogCommentDTOS;
    }

    /**
     * 添加评论/回复
     * @param comment
     * @return
     */
    @Override
    public BlogComment insertComment(BlogComment comment, String visitorName) {
        comment.setComment(StringEscapeUtils.unescapeHtml4(comment.getComment()));
        BlogComment commentInsert = new BlogComment();

        if (comment.getReplyCommentId() != null) {
            BlogComment parentComment = commentMapper.selectByPrimaryKey(comment.getReplyCommentId());
            commentInsert.setBlogId(parentComment.getBlogId());
            commentInsert.setReplyCommentId(parentComment.getId());
            commentInsert.setParentsCommentId(parentComment.getParentsCommentId() + parentComment.getId() + COMMENT_CUT);
        } else if (comment.getBlogId() != null ){
            commentInsert.setBlogId(comment.getBlogId());
            commentInsert.setReplyCommentId(0);
        } else {
            throw new BusinessException(ExceptionType.PARAMETER_ILLEGAL);
        }

        commentInsert.setComment(comment.getComment());
        commentInsert.setWebVisitorId(visitorMapper.getByName(visitorName).getId());

        int insertResult = commentMapper.insertComment(commentInsert);

        if (insertResult > 0) {
            //更新文章评论的条数
            Blog blog = blogMapper.getBlogById(commentInsert.getBlogId());
            blogMapper.updateCommentTimes(blog.getCommentTimes() + 1, blog.getId());

            return commentMapper.selectByPrimaryKey(commentInsert.getId());
        } else {
            throw new BusinessException(ExceptionType.DATA_NOT_FOUND);
        }
    }

}
