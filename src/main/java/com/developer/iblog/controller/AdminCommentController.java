package com.developer.iblog.controller;

import com.developer.iblog.common.web.AbstractController;
import com.developer.iblog.model.dto.AdminCommentDTO;
import com.developer.iblog.model.dto.CommentInfoDTO;
import com.developer.iblog.service.IManageCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by cnbo on 17-5-21.
 */
@Controller
@RequestMapping("/admin/comment")
public class AdminCommentController extends AbstractController {

    @Autowired
    private IManageCommentService commentService;

    @RequestMapping(value = "/manage", method = RequestMethod.GET)
    public String manage() {
        return "admin/comment-manage";
    }

    @RequestMapping(value = "/page", produces = "application/json", method = RequestMethod.POST)
    public @ResponseBody AdminCommentDTO getByPage(@RequestBody AdminCommentDTO adminCommentDTO) {
        List<CommentInfoDTO> commentInfoDTOS = commentService.getByPage(adminCommentDTO);
        int pages = commentService.getPages(adminCommentDTO);

        adminCommentDTO.setCommentInfoDTOS(commentInfoDTOS);
        adminCommentDTO.setPages(pages);

        return adminCommentDTO;
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    public @ResponseBody Integer deleteComment(@PathVariable Integer id) {
        Integer deleteResult = commentService.deleteComment(id);

        return deleteResult;
    }

}
