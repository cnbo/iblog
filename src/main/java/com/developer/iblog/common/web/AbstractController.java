package com.developer.iblog.common.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by cnbo on 17-3-23.
 */
public abstract class AbstractController {

    /**
     *  日志对象
     */
    protected Logger logger = LoggerFactory.getLogger(getClass());

    /**
     * 存放当前线程的HttpServletRequest对象
     */
    private static ThreadLocal<HttpServletRequest> httpServletRequestThreadLocal = new ThreadLocal<>();

    /**
     * 存放当前线程的Model对象
     */
    private static ThreadLocal<Model> modelThreadLocal = new ThreadLocal<>();

    /**
     * 使用@ModelAttribute注解标识的方法会在每个控制器中的方法访问之前先调用
     *
     * @param request
     * @param model
     */
    @ModelAttribute
    protected void setThreadLocal(HttpServletRequest request, Model model) {
        httpServletRequestThreadLocal.set(request);
        modelThreadLocal.set(model);
    }

    /**
     * 获取当前线程的HttpServletRequest对象
     *
     * @return 当前线程的HttpServletRequest对象
     */
    protected HttpServletRequest getRequest() {
        return httpServletRequestThreadLocal.get();
    }

    /**
     * 获取当前线程的HttpSession对象
     * @return 当前线程的HttpSession对象
     */
    protected HttpSession getSession() {
        return getRequest().getSession();
    }

    /**
     * 获取当前线程的Model对象
     * @return 当前线程的Model对象
     */
    protected Model getModel() {
        return modelThreadLocal.get();
    }

    /**
     * 获取当前的ServletContext对象
     * @return 当前的ServletContext对象
     */
    protected ServletContext getContext() {
        return getRequest().getServletContext();
    }

    /**
     * 向 Model 设置属性值
     * @param name 属性名
     * @param value 属性值
     */
    protected void setModelAttribute(String name, Object value) {
        getModel().addAttribute(name, value);
    }


    /**
     * 向 HttpServletRequest 设置属性值
     * @param name 属性名
     * @param value 属性值
     */
    protected void setRequestAttribute(String name, Object value) {
        HttpServletRequest request = this.getRequest();
        request.setAttribute(name, value);
    }

    /**
     * 向 HttpSession 设置属性值
     * @param name 属性名
     * @param value 属性值
     */
    public void setSessionAttribute(String name, Object value) {
        HttpSession session = this.getSession();
        session.setAttribute(name, value);
    }

    /**
     * 从 HttpSession 中获取属性值
     * @param name 属性名
     * @return 属性值
     */
    protected Object getSessionAttribute(String name) {
        HttpSession session = this.getSession();
        Object value = session.getAttribute(name);
        return value;
    }

    /**
     * 从 HttpServletRequest 中获取属性值
     * @param name 属性名
     * @return 属性值
     */
    protected Object getRequestAttribute(String name) {
        HttpServletRequest request = this.getRequest();
        Object value = request.getAttribute(name);
        return value;
    }

    protected String getRemoteIp() {
        String remoteIp;
        remoteIp = this.getRequest().getHeader("x-forwarded-for");
        if(remoteIp == null || remoteIp.length() == 0 || "unknown".equalsIgnoreCase(remoteIp)) {
            remoteIp = this.getRequest().getHeader("Proxy-Client-IP");
        }
        if(remoteIp == null || remoteIp.length() == 0 || "unknown".equalsIgnoreCase(remoteIp)) {
            remoteIp = this.getRequest().getHeader("WL-Proxy-Client-IP");
        }
        if(remoteIp == null || remoteIp.length() == 0 || "unknown".equalsIgnoreCase(remoteIp)) {
            remoteIp = this.getRequest().getHeader("HTTP_CLIENT_IP");
        }
        if(remoteIp == null || remoteIp.length() == 0 || "unknown".equalsIgnoreCase(remoteIp)) {
            remoteIp = this.getRequest().getHeader("HTTP_X_FORWARDED-FOR");
        }
        if(remoteIp == null || remoteIp.length() == 0 || "unknown".equalsIgnoreCase(remoteIp)) {
            remoteIp = this.getRequest().getRemoteAddr();
        }

        //对于通过多个代理的情况，第一个IP为客户端真实IP,多个IP按照','分割
        if(remoteIp!=null && remoteIp.length()>15){ //"***.***.***.***".length() = 15
            if(remoteIp.indexOf(",")>0){
                remoteIp = remoteIp.substring(0,remoteIp.indexOf(","));
            }
        }
        return remoteIp;
    }


}
