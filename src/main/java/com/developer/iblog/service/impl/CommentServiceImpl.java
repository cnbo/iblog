package com.developer.iblog.service.impl;

import com.developer.iblog.common.bean.ExceptionType;
import com.developer.iblog.common.exception.BusinessException;
import com.developer.iblog.dao.mapper.BlogCommentMapper;
import com.developer.iblog.dao.mapper.WebVisitorMapper;
import com.developer.iblog.model.dto.BlogCommentAndReplyDTO;
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
            

        }

        return null;
    }

    /**
     * 获取评论回复
     * @param commentId
     * @return
     */
    @Override
    public List<BlogComment> getCommentReplyInfo(Integer commentId) {

        return null;
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
        } else {
            throw new BusinessException(ExceptionType.PARAMETER_ILLEGAL);
        }

        commentInsert.setComment(comment.getComment());
        commentInsert.setWebVisitorId(visitorMapper.getByName(visitorName).getId());

        int insertResult = commentMapper.insertComment(commentInsert);

        if (insertResult > 0) {
            //更新文章评论的条数

            return commentInsert;
        } else {
            throw new BusinessException(ExceptionType.DATA_NOT_FOUND);
        }
    }

}
