package com.developer.iblog.model.dto;

import com.developer.iblog.model.persistent.BlogComment;
import com.developer.iblog.model.persistent.WebVisitor;
import lombok.Data;

import java.util.List;

/**
 * Created by cnbo on 17-5-2.
 */
@Data
public class BlogCommentAndReplyDTO {

    private WebVisitor visitor;

    private BlogComment  comment;

    private List<BlogCommentDTO> blogCommentDTOS;

}
