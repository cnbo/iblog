package com.developer.iblog.service;

import com.developer.iblog.model.dto.VisitorAndCommentCountDTO;
import com.developer.iblog.model.dto.VisitorDTO;
import com.developer.iblog.model.persistent.WebVisitor;

import java.util.List;

/**
 * Created by cnbo on 17-5-21.
 */
public interface IVisitorService  {

    List<VisitorAndCommentCountDTO> getVisitorsByPage(VisitorDTO visitorDTO);

    Integer getPages(VisitorDTO visitorDTO);

    Integer deleteVisitor(Integer visitorId);

}
