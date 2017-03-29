package com.developer.iblog.model.persistent;

import lombok.Data;

/**
 * Created by cnbo on 17-3-21.
 */
@Data
public class WebVisitor extends BaseModel {

    private String visitorName;

    private String password;

    private String passwordSalt;

}
