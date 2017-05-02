package com.developer.iblog.common.exception;

import com.developer.iblog.common.bean.ExceptionType;

/**
 * Created by cnbo on 17-5-2.
 */
public class BusinessException extends RuntimeException {

    private int code;

    private String message;

    public BusinessException(ExceptionType exceptionType) {
        this.code = exceptionType.getCode();
        this.message = exceptionType.getMessage();
    }

    public int getCode() {
        return code;
    }

    @Override
    public String getMessage() {
        return message;
    }

}
