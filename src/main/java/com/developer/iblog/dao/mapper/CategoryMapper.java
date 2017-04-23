package com.developer.iblog.dao.mapper;

import com.developer.iblog.model.persistent.BlogCategory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by cnbo on 17-4-1.
 */
public interface CategoryMapper {

    void saveCategory(BlogCategory blogCategory);

    Integer deleteCategoryById(Integer id);

    Integer updateCategory(BlogCategory blogCategory);

    BlogCategory getCategoryByName(String categoryName);

    List<BlogCategory> getAllCategory();

    List<BlogCategory> getByPage(@Param("start") Integer start,
                                 @Param("pageCount") Integer pageCount,
                                 @Param("categoryName") String categoryName);

    int getCategoryCount(@Param("categoryName") String categoryName);


}
