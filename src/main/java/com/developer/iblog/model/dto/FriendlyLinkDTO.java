package com.developer.iblog.model.dto;

import com.developer.iblog.model.persistent.FriendlyLink;
import lombok.Data;

import java.util.List;

/**
 * Created by cnbo on 17-4-4.
 */
@Data
public class FriendlyLinkDTO {

    private Integer page;

    private Integer pages;

    private Integer pageCount;

    private String friendName;

    private String url;

    private List<FriendlyLink> links;

}
