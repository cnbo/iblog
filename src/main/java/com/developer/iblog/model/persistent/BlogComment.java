package com.developer.iblog.model.persistent;

import lombok.Data;

/**
 * Created by cnbo on 17-3-21.
 */
@Data
public class BlogComment extends BaseModel {

    private Integer blogId;

    private Integer webVisitorId;

    private String comment;

    private Integer replyCommentId;

    private String parentsCommentId;

}
