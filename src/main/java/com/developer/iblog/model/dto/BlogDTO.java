package com.developer.iblog.model.dto;

import com.developer.iblog.model.persistent.Blog;
import lombok.Data;

/**
 * Created by cnbo on 17-3-21.
 */
@Data
public class BlogDTO {

    private Blog blog;

    //用于用户识别时间
    private String friendlyTime;

}
