package com.developer.iblog.model.dto;

import com.developer.iblog.model.persistent.Blog;
import lombok.Data;

import java.util.List;

/**
 * Created by cnbo on 17-4-20.
 */
@Data
public class BlogPageDTO {

    private String title;

    private Integer page;

    private Integer pages;

    private List<Blog> blogs;

}
