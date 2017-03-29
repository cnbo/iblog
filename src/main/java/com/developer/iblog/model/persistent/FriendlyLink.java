package com.developer.iblog.model.persistent;

import lombok.Data;

/**
 * Created by cnbo on 17-3-21.
 */
@Data
public class FriendlyLink extends BaseModel {

    private String friendName;

    private String url;
}
