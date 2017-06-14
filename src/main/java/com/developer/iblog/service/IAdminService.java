package com.developer.iblog.service;

import com.developer.iblog.model.dto.AdminDTO;
import com.developer.iblog.model.persistent.Admin;

/**
 * Created by cnbo on 17-3-23.
 */
public interface IAdminService {

    boolean isLogin(Admin admin);

    void updateAdmin(Admin admin);

    boolean modifyPassword(Admin admin, AdminDTO adminDTO);

    Admin selectAdminByName(String username);

    Admin selectAdmin();
}
