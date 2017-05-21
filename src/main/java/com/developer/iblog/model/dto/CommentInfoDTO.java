package com.developer.iblog.model.dto;

import com.developer.iblog.model.persistent.Blog;
import com.developer.iblog.model.persistent.BlogComment;
import com.developer.iblog.model.persistent.WebVisitor;
import lombok.Data;

/**
 * Created by cnbo on 17-5-21.
 */
@Data
public class CommentInfoDTO {

    private BlogComment comment;

    private WebVisitor visitor;

    private Blog blog;

}
