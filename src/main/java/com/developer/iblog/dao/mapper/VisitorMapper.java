package com.developer.iblog.dao.mapper;

import com.developer.iblog.model.persistent.WebVisitor;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by cnbo on 17-5-21.
 */
public interface VisitorMapper {

    List<WebVisitor> getByPage(@Param("start") Integer start,
                               @Param("pageCount") Integer pageCount,
                               @Param("visitorName") String visitorName);

    int getVisitorCount(@Param("visitorName") String visitorName);

    int getCommnetCount(@Param("visitorId") Integer visitorId);

    Integer deleteVisitor(Integer visitorId);

    WebVisitor getCommentVisitor(Integer visitorId);

}
