package com.developer.iblog.controller;

import com.developer.iblog.common.web.AbstractController;
import com.developer.iblog.model.dto.FriendlyLinkDTO;
import com.developer.iblog.model.persistent.FriendlyLink;
import com.developer.iblog.service.IFriendlyLinkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * Created by cnbo on 17-4-4.
 */
@Controller
@RequestMapping("/admin/friendly-link")
public class FriendlyLinkController extends AbstractController {

    @Autowired
    private IFriendlyLinkService friendlyLinkService;

    @RequestMapping(value = "/manage", method = RequestMethod.GET)
    public String manage() {
        return "admin/friendly-link-manage";
    }

    @RequestMapping(value = "/add", method = RequestMethod.POST)
    public String addFriendlyLink(FriendlyLink friendlyLink) {

        logger.info(friendlyLink.toString());

        friendlyLinkService.saveFriendlyLink(friendlyLink);

        return "admin/friendly-link-manage";
    }

    @RequestMapping(value = "/page", produces = "application/json", method = RequestMethod.POST)
    public @ResponseBody FriendlyLinkDTO getByPage(@RequestBody FriendlyLinkDTO friendlyLinkDTO) {

//        logger.info(friendlyLinkDTO.toString());

        List<FriendlyLink> links = friendlyLinkService.getLinksByPage(friendlyLinkDTO);

        int linkCount = friendlyLinkService.getLinkCount(friendlyLinkDTO);
        int pages = (int)Math.ceil((double)linkCount / friendlyLinkDTO.getPageCount());
        logger.info("pages="+pages);
        friendlyLinkDTO.setLinks(links);
        friendlyLinkDTO.setPages(pages);

//        logger.info(friendlyLinkDTO.toString());
//        logger.info(friendlyLinkDTO.getLinks().size()+"");

        return friendlyLinkDTO;
    }

    @RequestMapping(value = "/delete/{id}", method = RequestMethod.POST)
    public @ResponseBody Integer deleteLink(@PathVariable Integer id) {
        Integer deleteResult = friendlyLinkService.deleteLink(id);

        return deleteResult;
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public @ResponseBody Integer updateLink(@RequestBody FriendlyLink friendlyLink) {
        Integer updateResult = friendlyLinkService.updateLink(friendlyLink);

        return updateResult;
    }

}
