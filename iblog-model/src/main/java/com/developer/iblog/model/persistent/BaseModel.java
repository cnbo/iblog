package com.developer.iblog.model.persistent;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;

/**
 * Created by cnbo on 17-3-14.
 */
@Setter
@Getter
public abstract class BaseModel {

    private Integer id;

    private Date createTime;

    private Date updateTime;
}
