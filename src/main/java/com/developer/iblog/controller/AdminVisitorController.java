package com.developer.iblog.controller;

import com.developer.iblog.common.web.AbstractController;
import com.developer.iblog.model.dto.VisitorAndCommentCountDTO;
import com.developer.iblog.model.dto.VisitorDTO;
import com.developer.iblog.model.persistent.WebVisitor;
import com.developer.iblog.service.IVisitorService;
import com.developer.iblog.service.impl.VisitorServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by cnbo on 17-5-21.
 */
@Controller
@RequestMapping("/admin/visitor")
public class AdminVisitorController extends AbstractController {

    @Autowired
    private IVisitorService visitorService;

    @RequestMapping(value = "/manage", method = RequestMethod.GET)
    public String manage() {
        return "admin/visitor-manage";
    }

    @RequestMapping(value = "/page", produces = "application/json", method = RequestMethod.POST)
    public @ResponseBody VisitorDTO getByPage(@RequestBody VisitorDTO visitorDTO) {
        List<VisitorAndCommentCountDTO> visitorAndCommentCountDTOS =
                visitorService.getVisitorsByPage(visitorDTO);
        int pages = visitorService.getPages(visitorDTO);

        visitorDTO.setVisitorAndCommentCountDTOS(visitorAndCommentCountDTOS);
        visitorDTO.setPages(pages);

        return visitorDTO;
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    public @ResponseBody Integer deleteVisitor(@PathVariable Integer id) {
        Integer deleteResult = visitorService.deleteVisitor(id);

        return deleteResult;
    }

}
