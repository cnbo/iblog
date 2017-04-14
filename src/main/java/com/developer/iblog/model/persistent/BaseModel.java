package com.developer.iblog.model.persistent;


import java.util.Date;

/**
 * Created by cnbo on 17-3-21.
 */
public abstract class BaseModel {

    private Integer id;

    private Date createTime;

    private Date updateTime;

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

}
