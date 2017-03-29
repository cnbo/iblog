package com.developer.iblog.model.dto;

import lombok.Data;

import java.util.List;

/**
 * Created by cnbo on 17-3-21.
 */
@Data
public class HomeBlogDTO {

    private Integer categoryId;

    private String offset;

    private Integer size;

    private List<BlogDTO> blog;

}
