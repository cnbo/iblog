package com.developer.iblog.service.impl;

import com.developer.iblog.dao.mapper.AdminMapper;
import com.developer.iblog.dao.mapper.WebVisitorMapper;
import com.developer.iblog.model.persistent.Admin;
import com.developer.iblog.model.persistent.WebVisitor;
import com.developer.iblog.service.IWebVisitorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by cnbo on 17-4-28.
 */
@Service
public class WebVisitorServiceImpl implements IWebVisitorService {

    @Autowired
    private AdminMapper adminMapper;

    @Autowired
    private WebVisitorMapper visitorMapper;

    @Override
    public boolean isRegist(String visitorName) {
        WebVisitor visitor = visitorMapper.getByName(visitorName);
        if (visitor != null) {
            return true;
        }
        Admin admin = adminMapper.selectAdminByName(visitorName);
        if (admin != null) {
            return true;
        }

        return false;
    }

    @Override
    public boolean saveWebVisitor(WebVisitor visitor) {
        visitorMapper.saveWebVisitor(visitor);

        return (visitor.getId() > 0);
    }

    @Override
    public boolean loginSuccess(WebVisitor visitor) {
        WebVisitor localVisitor = visitorMapper.getByName(visitor.getVisitorName());
        if (localVisitor != null && localVisitor.getPassword().equals(visitor.getPassword())) {
            return true;
        }

        return false;
    }



}
