package com.developer.iblog.model.dto;

import com.developer.iblog.model.persistent.BlogCategory;
import lombok.Data;

import java.util.List;

/**
 * Created by cnbo on 17-4-3.
 */
@Data
public class CategoryPageDTO {

    private String categoryName;

    private Integer page;

    private List<BlogCategory> categories;

    private Integer pages;

}
