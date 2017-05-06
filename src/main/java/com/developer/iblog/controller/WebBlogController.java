package com.developer.iblog.controller;

import com.developer.iblog.common.web.AbstractController;
import com.developer.iblog.model.dto.BlogCommentAndReplyDTO;
import com.developer.iblog.model.persistent.Admin;
import com.developer.iblog.model.persistent.Blog;
import com.developer.iblog.model.persistent.BlogComment;
import com.developer.iblog.model.persistent.WebVisitor;
import com.developer.iblog.service.IAdminService;
import com.developer.iblog.service.IBlogService;
import com.developer.iblog.service.ICommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by cnbo on 17-4-27.
 */
@Controller
@RequestMapping(value = "/blog")
public class WebBlogController extends AbstractController {
    @Autowired
    private IBlogService blogService;

    @Autowired
    private IAdminService adminService;

    @Autowired
    private ICommentService commentService;

    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String toWebBlog(@PathVariable Integer id) {
        Blog blog = blogService.getBlogById(id);
        Admin admin = adminService.selectAdmin();
        List<BlogCommentAndReplyDTO> commentAndReplyDTOS = commentService.getCommentInfo(id);

        setModelAttribute("blog", blog);
        setModelAttribute("admin", admin);
        setModelAttribute("commentsAndReplies", commentAndReplyDTOS );
        return "web/blog";
    }

    @RequestMapping(value = "/comment", method = RequestMethod.POST)
    public @ResponseBody BlogComment comment(@RequestBody BlogComment blogComment) {
        String visitorName = (String) getSession().getAttribute(VISITOR_ATTRIBUTE_NAME);
        blogComment = commentService.insertComment(blogComment, visitorName);

        return blogComment;
    }

}
