package com.developer.iblog.controller;

import com.developer.iblog.common.web.AbstractController;
import com.developer.iblog.model.persistent.WebVisitor;
import com.developer.iblog.service.IWebVisitorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by cnbo on 17-4-28.
 */
@Controller
@RequestMapping(value = "/visitor")
public class WebVisitorController extends AbstractController {

    @Autowired
    private IWebVisitorService visitorService;

    @RequestMapping(value = "/validate", method = RequestMethod.POST)
    public @ResponseBody Boolean validateName(String visitorName) {
        boolean isRegist = visitorService.isRegist(visitorName);

        return isRegist;
    }

    @RequestMapping(value = "/regist", method = RequestMethod.POST)
    public @ResponseBody Boolean regist(@RequestBody WebVisitor visitor) {
        Boolean registSuccess = visitorService.saveWebVisitor(visitor);

        return registSuccess;
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public @ResponseBody Boolean login(@RequestBody WebVisitor visitor) {
        Boolean loginSuccess = visitorService.loginSuccess(visitor);
        if (loginSuccess) {
            visitorLoginSuccess(visitor);
        }

        return loginSuccess;
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public @ResponseBody Boolean logout() {
        visitotLogoutSuccess();

        return true;
    }
}
