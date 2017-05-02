package com.developer.iblog.model.dto;

import com.developer.iblog.model.persistent.BlogComment;
import com.developer.iblog.model.persistent.WebVisitor;
import lombok.Data;

/**
 * Created by cnbo on 17-5-2.
 */
@Data
public class BlogCommentDTO {

    private WebVisitor visitor;

    private WebVisitor parentVisitor;

    private BlogComment comment;

}
