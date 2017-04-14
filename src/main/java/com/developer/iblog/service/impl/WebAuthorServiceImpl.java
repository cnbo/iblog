package com.developer.iblog.service.impl;

import com.developer.iblog.dao.mapper.AdminMapper;
import com.developer.iblog.model.dto.AdminDTO;
import com.developer.iblog.model.persistent.Admin;
import com.developer.iblog.service.IWebAuthorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by cnbo on 17-4-1.
 */
@Service
public class WebAuthorServiceImpl implements IWebAuthorService {

    @Autowired
    private AdminMapper adminMapper;

    @Override
    public AdminDTO getAdminDTO() {
        Admin admin = adminMapper.selectAdmin();

        AdminDTO adminDTO = new AdminDTO();
        adminDTO.setIntroduction(admin.getIntroduction());
        adminDTO.setAvatar(admin.getAvatar());
        adminDTO.setEmail(admin.getEmail());
        adminDTO.setGithub(admin.getGithub());
        adminDTO.setNickname(admin.getNickname());
        adminDTO.setResumeMd(admin.getResumeMd());

        return adminDTO;
    }

}
