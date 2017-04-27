package com.developer.iblog.model.dto;

import com.developer.iblog.model.persistent.Blog;
import com.developer.iblog.model.persistent.BlogCategory;
import lombok.Data;

import java.util.List;

/**
 * Created by cnbo on 17-4-27.
 */
@Data
public class WebCateogriesBlogsDTO {

    private BlogCategory category;

    private List<Blog> blogs;

}
