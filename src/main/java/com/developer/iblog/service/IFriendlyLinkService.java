package com.developer.iblog.service;

import com.developer.iblog.model.dto.FriendlyLinkDTO;
import com.developer.iblog.model.persistent.FriendlyLink;

import java.util.List;

/**
 * Created by cnbo on 17-4-4.
 */
public interface IFriendlyLinkService {

    void saveFriendlyLink(FriendlyLink friendlyLink);

    List<FriendlyLink> getLinksByPage(FriendlyLinkDTO friendlyLinkDTO);

    Integer getLinkCount(FriendlyLinkDTO friendlyLinkDTO);

    List<FriendlyLink> getAll();

    Integer deleteLink(Integer id);

    Integer updateLink(FriendlyLink friendlyLink);

}
