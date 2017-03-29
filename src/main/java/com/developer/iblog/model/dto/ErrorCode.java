package com.developer.iblog.model.dto;

import lombok.Data;

/**
 * Created by cnbo on 17-3-21.
 */
@Data
public class ErrorCode {

    /** 错误码 */
    private int errorCode;

    /** 错误信息 */
    private String errorMessage;

    public ErrorCode(int errorCode, String errorMessage) {
        this.errorCode = errorCode;
        this.errorMessage = errorMessage;
    }

}
