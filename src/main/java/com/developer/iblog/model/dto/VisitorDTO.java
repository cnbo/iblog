package com.developer.iblog.model.dto;

import com.developer.iblog.model.persistent.WebVisitor;
import lombok.Data;

import java.util.List;

/**
 * Created by cnbo on 17-5-21.
 */
@Data
public class VisitorDTO {

    private Integer page;

    private Integer pages;

    private Integer pageCount;

    private String visitorName;

    private List<VisitorAndCommentCountDTO> visitorAndCommentCountDTOS;

}
