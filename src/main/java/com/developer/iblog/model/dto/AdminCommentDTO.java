package com.developer.iblog.model.dto;

import lombok.Data;

import java.util.List;

/**
 * Created by cnbo on 17-5-21.
 */
@Data
public class AdminCommentDTO {

    private Integer page;

    private Integer pages;

    private Integer pageCount;

    private String comment;

    private List<CommentInfoDTO> commentInfoDTOS;

}
