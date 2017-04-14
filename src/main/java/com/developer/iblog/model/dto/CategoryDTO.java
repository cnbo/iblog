package com.developer.iblog.model.dto;

import com.developer.iblog.model.persistent.BlogCategory;
import lombok.Data;

/**
 * Created by cnbo on 17-4-1.
 */
@Data
public class CategoryDTO {

    private BlogCategory blogCategory;

    private Integer blogCount;

}
