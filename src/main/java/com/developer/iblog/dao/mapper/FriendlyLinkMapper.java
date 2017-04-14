package com.developer.iblog.dao.mapper;

import com.developer.iblog.model.persistent.FriendlyLink;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Created by cnbo on 17-4-4.
 */
public interface FriendlyLinkMapper {

    void saveFriendlyLink(FriendlyLink friendlyLink);

    void deleteFriendlyLink(Integer id);

    void updateFriendlyLink(FriendlyLink friendlyLink);

    List<FriendlyLink> getAllFriendlyLink();

    List<FriendlyLink> getFriendlyLinksByPage(@Param("start") Integer start,
                                              @Param("pageCount") Integer pageCount,
                                              @Param("friendName") String friendName,
                                              @Param("url") String url);

    Integer getFriendlyLinkCount(@Param("friendName") String friendName,
                                 @Param("url") String url);
}
