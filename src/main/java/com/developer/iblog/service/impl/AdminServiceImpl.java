package com.developer.iblog.service.impl;

import com.developer.iblog.dao.mapper.AdminMapper;
import com.developer.iblog.model.persistent.Admin;
import com.developer.iblog.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by cnbo on 17-3-23.
 */
@Service
public class AdminServiceImpl implements IAdminService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public boolean isLogin(Admin admin) {
        Admin rightAdmin = adminMapper.selectAdminByNamePassword(admin);

        return (rightAdmin != null);
    }

    @Override
    public void updateAdmin(Admin admin) {
        adminMapper.updateAdmin(admin);
    }

    @Override
    public boolean modifyPassword(String username, String newPassword, String oldPassword) {
        Admin admin = adminMapper.selectAdminByName(username);
        if (admin.getPassword().equals(oldPassword)) {
            admin.setPassword(newPassword);
            adminMapper.updateAdmin(admin);
            return true;
        }
        return false;
    }

    @Override
    public Admin selectAdminByName(String username) {
        return adminMapper.selectAdminByName(username);
    }

    @Override
    public Admin selectAdmin() {
        return adminMapper.selectAdmin();
    }
}
