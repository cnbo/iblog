package com.developer.iblog.service.impl;

import com.developer.iblog.dao.mapper.FriendlyLinkMapper;
import com.developer.iblog.model.dto.FriendlyLinkDTO;
import com.developer.iblog.model.persistent.FriendlyLink;
import com.developer.iblog.service.IFriendlyLinkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by cnbo on 17-4-4.
 */
@Service
public class FriendlyLinkServiceImpl implements IFriendlyLinkService {

    @Autowired
    private FriendlyLinkMapper friendlyLinkMapper;

    @Override
    public void saveFriendlyLink(FriendlyLink friendlyLink) {
        friendlyLinkMapper.saveFriendlyLink(friendlyLink);
    }

    @Override
    public List<FriendlyLink> getLinksByPage(FriendlyLinkDTO friendlyLinkDTO) {
        return friendlyLinkMapper.getFriendlyLinksByPage(
                (friendlyLinkDTO.getPage() - 1) * friendlyLinkDTO.getPageCount(),
                friendlyLinkDTO.getPageCount(),
                friendlyLinkDTO.getFriendName(),
                friendlyLinkDTO.getUrl());
    }

    @Override
    public Integer getLinkCount(FriendlyLinkDTO friendlyLinkDTO) {
        return friendlyLinkMapper.getFriendlyLinkCount(friendlyLinkDTO.getFriendName(),
                friendlyLinkDTO.getUrl());
    }

    @Override
    public void deleteLink(Integer id) {
        friendlyLinkMapper.deleteFriendlyLink(id);
    }

}
