package com.developer.iblog.model.dto;

import com.developer.iblog.model.persistent.WebVisitor;
import lombok.Data;

/**
 * Created by cnbo on 17-5-21.
 */
@Data
public class VisitorAndCommentCountDTO {

    private WebVisitor visitor;

    private Integer commentCount;

}
