package com.developer.iblog.dao.mapper;

import com.developer.iblog.model.persistent.Admin;

/**
 * Created by cnbo on 17-3-22.
 */
public interface AdminMapper {

    Admin selectAdminByName(String username);

    void updateAdmin(Admin admin);

    Admin selectAdmin();
}
