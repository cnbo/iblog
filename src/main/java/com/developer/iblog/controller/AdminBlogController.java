package com.developer.iblog.controller;

import com.developer.iblog.common.web.AbstractController;
import com.developer.iblog.model.dto.BlogDTO;
import com.developer.iblog.model.dto.BlogPageDTO;
import com.developer.iblog.model.dto.MdImageUploadDTO;
import com.developer.iblog.model.persistent.Blog;
import com.developer.iblog.model.persistent.BlogCategory;
import com.developer.iblog.service.IBlogCategoryService;
import com.developer.iblog.service.IBlogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;


/**
 * Created by cnbo on 17-4-1.
 */
@Controller
@RequestMapping("/admin/blog")
public class AdminBlogController extends AbstractController {

    @Autowired
    private IBlogCategoryService categoryService;

    @Autowired
    private IBlogService blogService;

    @RequestMapping(value = "/write", method = RequestMethod.GET)
    public String writeBlog() {

        List<BlogCategory> blogCategories = categoryService.getAllBlogCategory();
        setModelAttribute("blogCategories", blogCategories);

        return "admin/blog-write";
    }

    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public @ResponseBody
    MdImageUploadDTO upload(@RequestParam(value = "editormd-image-file", required = false)
                                   MultipartFile multipartFile) {
        if (!multipartFile.isEmpty()) {
            logger.info("img not null");
            //判断multipartFile是否空
            //判断文件是否是规定格式的图片
            //判断文件的大小

            //指定文件的存储路径
            String filePath = getRequest().getSession()
                    .getServletContext().getRealPath(File.separator + "blog_imags");
            logger.info(getContext().getContextPath());
            File rootFile = new File(filePath);
            if (!rootFile.exists()) {
                rootFile.mkdirs();
            }
            File imgFile =
                    new File(filePath + File.separator + multipartFile.getOriginalFilename());
            MdImageUploadDTO mdImageUploadDTO = null;
            try {
                multipartFile.transferTo(imgFile);
                mdImageUploadDTO = new MdImageUploadDTO();
                mdImageUploadDTO.setSuccess(1);
                mdImageUploadDTO.setMessage("上传成功");
                String url =
                        getContext().getContextPath() +
                                File.separator +
                                "blog_imags" + File.separator + imgFile.getName();
                mdImageUploadDTO.setUrl(url);
            } catch (IOException e) {
                e.printStackTrace();
            }

            return mdImageUploadDTO;
        } else {
            logger.info("img is null");
        }

        return null;
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String editBlog(@PathVariable Integer id) {
//        Integer id = Integer.getInteger(getRequest().getParameter("id"));
        Blog blog = blogService.getBlogById(id);
        List<BlogCategory> blogCategories = categoryService.getAllBlogCategory();

        setModelAttribute("blog", blog);
        setModelAttribute("blogCategories", blogCategories);

        return "admin/blog-write";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public @ResponseBody Integer saveBlog(@RequestBody BlogDTO blogDTO) {
        Integer blogId = blogService.saveBlog(blogDTO);

        logger.info("save blogID=====" + blogId);

        return blogId;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public @ResponseBody Integer updateBlog(@RequestBody BlogDTO blogDTO) {
        Integer updateResult = blogService.updateBlog(blogDTO);

        logger.info("update blogID=====" + updateResult);


        return updateResult;
    }

    @RequestMapping(value = "/manage", method = RequestMethod.GET)
    public String manage() {
        return "admin/blog-manage";
    }

    @RequestMapping(value = "/page",  produces = "application/json", method = RequestMethod.POST)
    public @ResponseBody BlogPageDTO page(@RequestBody BlogPageDTO blogPageDTO) {
        Integer pageCount = 6;
        int page = blogPageDTO.getPage();
        List<Blog> blogs = blogService.getBlogByPage((page - 1) * pageCount,
                pageCount, blogPageDTO.getTitle());

        blogPageDTO.setBlogs(blogs);
        blogPageDTO.setPages(blogService.getPages(pageCount, blogPageDTO.getTitle()));
        blogPageDTO.setPage(page);

        return blogPageDTO;
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    public @ResponseBody Integer deleteBLog(@PathVariable Integer id) {
        Integer deleteResult = blogService.deleteBlogById(id);

        logger.info("delete blog result============" + deleteResult);

        return deleteResult;
    }



}
