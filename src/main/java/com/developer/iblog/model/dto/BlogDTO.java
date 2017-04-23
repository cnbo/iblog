package com.developer.iblog.model.dto;

import com.developer.iblog.model.persistent.Blog;
import lombok.Data;

/**
 * Created by cnbo on 17-3-21.
 */
@Data
public class BlogDTO {

    private String categoryName;

    private Integer id;

    private Integer categoryId;

    private String title;

    private String blogMd;

    private Integer readTimes;

    private Integer commentTimes;

    private Integer loveTimes;

    private Integer status;

}
