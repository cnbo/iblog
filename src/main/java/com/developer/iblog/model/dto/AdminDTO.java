package com.developer.iblog.model.dto;

import com.developer.iblog.model.persistent.Admin;
import lombok.Data;

/**
 * Created by cnbo on 17-3-21.
 */
@Data
public class AdminDTO {

    private String nickname;

    private String resumeMd;

    private String introduction;

    private String avatar;

    private String email;

    private String github;

    private String newPassword;

    private String oldPassword;

}
