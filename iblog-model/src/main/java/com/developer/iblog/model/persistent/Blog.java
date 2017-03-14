package com.developer.iblog.model.persistent;

import lombok.Data;

import java.util.Date;

/**
 * Created by cnbo on 17-3-14.
 */
@Data
public class Blog {

    public static final int STATUS_DRAFT = 0;

    public static final int STATUS_PUBLISH = 1;

    public static final int STATUS_DELETE = 2;

    private Integer categoryId;

    private String title;

    private String blogMd;

    private Integer readTimes;

    private Integer loveTimes;

    private Integer commentTimes;

    private Date publishTime;
}
