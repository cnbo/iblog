package com.developer.iblog.service.impl;

import com.developer.iblog.dao.mapper.VisitorMapper;
import com.developer.iblog.model.dto.VisitorAndCommentCountDTO;
import com.developer.iblog.model.dto.VisitorDTO;
import com.developer.iblog.model.persistent.WebVisitor;
import com.developer.iblog.service.IVisitorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by cnbo on 17-5-21.
 */
@Service
public class VisitorServiceImpl implements IVisitorService {

    @Autowired
    private VisitorMapper visitorMapper;

    @Override
    public List<VisitorAndCommentCountDTO> getVisitorsByPage(VisitorDTO visitorDTO) {
        List<WebVisitor> visitors = visitorMapper.getByPage(
                (visitorDTO.getPage() - 1) * visitorDTO.getPageCount(),
                visitorDTO.getPageCount(),
                visitorDTO.getVisitorName());

        List<VisitorAndCommentCountDTO> visitorAndCommentCountDTOS =
                new ArrayList<>();
        for (WebVisitor visitor : visitors) {
            int commentCount = visitorMapper.getCommnetCount(visitor.getId());
            VisitorAndCommentCountDTO visitorAndCommentCountDTO = new VisitorAndCommentCountDTO();
            visitorAndCommentCountDTO.setVisitor(visitor);
            visitorAndCommentCountDTO.setCommentCount(commentCount);
            visitorAndCommentCountDTOS.add(visitorAndCommentCountDTO);
        }

        return visitorAndCommentCountDTOS;
    }

    @Override
    public Integer getPages(VisitorDTO visitorDTO) {
        int visitorCount = visitorMapper.getVisitorCount(visitorDTO.getVisitorName());
        int pages = (int) Math.ceil((double) visitorCount / visitorDTO.getPageCount());

        return pages;
    }

    @Override
    public Integer deleteVisitor(Integer visitorId) {
        return visitorMapper.deleteVisitor(visitorId);
    }

}
