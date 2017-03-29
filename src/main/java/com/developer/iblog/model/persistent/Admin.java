package com.developer.iblog.model.persistent;

import lombok.Data;

/**
 * Created by cnbo on 17-3-21.
 */
@Data
public class Admin {

    private String username;

    private String password;

    private String nickname;

    private String introduction;

    private String email;

    private String github;

    private String resumeMd;

    private String avatar;

}
