package com.developer.iblog.common.authorization;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by cnbo on 17-4-27.
 */
public class AuthorizationInterceptor extends HandlerInterceptorAdapter {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response,
                             Object handler) throws IOException {
        HttpSession session = request.getSession();
        Logger logger = LoggerFactory.getLogger(AuthorizationInterceptor.class);

        if (request.getRequestURI().endsWith("admin/login.do")) {
            logger.info("login===================");
            return true;
        }

        if (session.getAttribute("admin") != null) {
            logger.info("admin=================");
            return true;
        }

        response.sendRedirect(request.getContextPath() + "/admin/login.do");
        return false;
    }

}
