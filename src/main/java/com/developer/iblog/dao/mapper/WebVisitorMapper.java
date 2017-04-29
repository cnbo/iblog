package com.developer.iblog.dao.mapper;

import com.developer.iblog.model.persistent.WebVisitor;

/**
 * Created by cnbo on 17-4-28.
 */
public interface WebVisitorMapper {

    WebVisitor getByName(String visitorName);

    Integer saveWebVisitor(WebVisitor webVisitor);

}
