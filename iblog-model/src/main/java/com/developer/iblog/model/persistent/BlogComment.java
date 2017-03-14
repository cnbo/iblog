package com.developer.iblog.model.persistent;

import lombok.Data;

/**
 * Created by cnbo on 17-3-14.
 */
@Data
public class BlogComment {

    private Integer blogId;

    private Integer webVisitorId;

    private String comment;

    private Integer replyCommentId;

    private Integer parentsCommentId;

}
