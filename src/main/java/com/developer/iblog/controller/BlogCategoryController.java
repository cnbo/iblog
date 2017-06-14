package com.developer.iblog.controller;

import com.developer.iblog.common.web.AbstractController;
import com.developer.iblog.model.dto.CategoryPageDTO;
import com.developer.iblog.model.persistent.BlogCategory;
import com.developer.iblog.service.IBlogCategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * Created by cnbo on 17-4-1.
 */
@Controller
@RequestMapping("/admin/category")
public class BlogCategoryController extends AbstractController {

    @Autowired
    private IBlogCategoryService blogCategoryService;

    @RequestMapping(value = "/manage", method = RequestMethod.GET)
    public String manage() {
        return "admin/category-manage";
    }

    @RequestMapping(value = "/page",  produces = "application/json", method = RequestMethod.POST)
    public @ResponseBody CategoryPageDTO page(@RequestBody CategoryPageDTO categoryPageDTO) {
        Integer pageCount = 5;
        int page = categoryPageDTO.getPage();
        List<BlogCategory> blogCategories =
            blogCategoryService.getCategoriesByPage((page - 1) * pageCount,
            pageCount,
            categoryPageDTO.getCategoryName());

        Integer pages = blogCategoryService.getPages(pageCount, categoryPageDTO.getCategoryName());
        categoryPageDTO.setCategories(blogCategories);
        categoryPageDTO.setPage(page);
        categoryPageDTO.setPages(pages);

//        logger.info(page+categoryPageDTO.getCategoryName());

        return categoryPageDTO;
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addCategory(String categoryName) {
        blogCategoryService.saveCategory(categoryName);
        return "admin/category-manage";
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    public @ResponseBody Integer deleteCategory(@PathVariable Integer id) {

       Integer deleteResult = blogCategoryService.deleteCategory(id);
        logger.info("deleteResult======="+deleteResult);

        return deleteResult;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public @ResponseBody Integer updateCategory(@RequestBody BlogCategory blogCategory) {
        Integer updateResult = blogCategoryService.updateCategory(blogCategory);

        logger.info("update result======" + updateResult);

        return updateResult;
    }

}
