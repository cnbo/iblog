package com.developer.iblog.model.persistent;

import lombok.Data;

import java.util.Date;

/**
 * Created by cnbo on 17-3-21.
 */
@Data
public class Blog extends BaseModel {

    public static final int STATUS_DRAFT = 0;

    public static final int STATUS_PUBLISH = 1;

    public static final int STATUS_DELETE = 2;

    private Integer categoryId;

    private String title;

    private String blogMd;

    private String blogHtml;

    private Integer readTimes;

    private Integer loveTimes;

    private Integer commentTimes;

    private Date publishTime;

    private Integer status;

}
