package com.developer.iblog.service;

import com.developer.iblog.model.persistent.WebVisitor;

/**
 * Created by cnbo on 17-4-28.
 */
public interface IWebVisitorService {

    boolean isRegist(String visitorName);

    boolean saveWebVisitor(WebVisitor visitor);

    boolean loginSuccess(WebVisitor visitor);

}
