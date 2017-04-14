package com.developer.iblog.controller;

import com.developer.iblog.common.web.AbstractController;
import com.developer.iblog.model.dto.AdminDTO;
import com.developer.iblog.service.IWebAuthorService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by cnbo on 17-3-29.
 */
@Controller
@RequestMapping("/author")
public class WebAuthorController extends AbstractController {

    @Autowired
    private IWebAuthorService webAuthorService;

    @RequestMapping(value = "/resume", method = RequestMethod.GET)
    public String resume() {

        AdminDTO adminDTO = webAuthorService.getAdminDTO();
        setModelAttribute("adminDTO", adminDTO);

        return "web/resume";
    }

}
