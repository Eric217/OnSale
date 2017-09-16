package cn.omsfuk.discount.controller.normal;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.base.ResultCache;
import cn.omsfuk.discount.dto.UserDto;
import cn.omsfuk.discount.service.GoodsService;
import cn.omsfuk.discount.service.UserService;
import cn.omsfuk.discount.util.ObjectUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Timestamp;

/**
 * Created by omsfuk on 2017/7/19.
 */

@RestController("normalMainController")
@RequestMapping("api/normal")
public class MainController {

    @Autowired
    private UserService userService;

    @Autowired
    private GoodsService goodsService;

    @RequestMapping(value = "changeInfo", method = RequestMethod.POST)
    public Result changeInfo(UserDto user) {
        return userService.updateUser(user);
    }

    @RequestMapping(value = "changePic", method = RequestMethod.POST)
    public Result changPortrait(MultipartFile data) {
        if (data == null) {
            return ResultCache.WRONG_PARAMETER_FORMAT;
        }
        return userService.changePortrait(data);
    }

    @RequestMapping(value = "favorite/addFavorite", method = RequestMethod.GET)
    public Result addCollection(Integer goodsID) {
        if (goodsID == null) {
            return ResultCache.WRONG_PARAMETER_FORMAT;
        }
        return userService.addFavorite(goodsID);
    }

    @RequestMapping(value = "favorite/getFavorite", method = RequestMethod.GET)
    public Result getCollection(@RequestParam(defaultValue = "1") Integer page,
                                @RequestParam(defaultValue = "10") Integer rows) {
        return userService.getFavorite((page - 1) * rows, rows);
    }

    @RequestMapping(value = "favorite/deleteFavor", method = RequestMethod.GET)
    public Result deleteFavor(Integer goodsID) {
        if (goodsID == null) {
            return ResultCache.WRONG_PARAMETER_FORMAT;
        }
        return userService.deleteFavor(goodsID);
    }

    @RequestMapping(value = "history/addHistory", method = RequestMethod.GET)
    public Result addHistory(Integer goodsID) {
        if (goodsID == null) {
            return ResultCache.WRONG_PARAMETER_FORMAT;
        }
        return userService.addHistory(goodsID);
    }

    @RequestMapping(value = "history/getHistory", method = RequestMethod.GET)
    public Result getHistory(@RequestParam(defaultValue = "1") Integer page,
                                @RequestParam(defaultValue = "10") Integer rows) {
        return userService.getHistory((page - 1) * rows, rows);
    }

    @RequestMapping(value = "history/deleteHistory", method = RequestMethod.GET)
    public Result deleteHistory() {
        return userService.deleteHistory();
    }

    @RequestMapping(value = "care/addCare", method = RequestMethod.GET)
    public Result addCare(Integer personID) {
        return userService.addCare(personID);
    }
    
    @RequestMapping(value = "care/getCare", method = RequestMethod.GET)
    public Result getCare(@RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "10") Integer rows) {
        return userService.getCare((page - 1) * rows, rows);
    }

    @RequestMapping(value = "care/deleteCare", method = RequestMethod.GET)
    public Result deleteCare(Integer personID) {
        return userService.deleteCare(personID);
    }

    @RequestMapping(value = "goods/upload")
    public Result upload(Integer type, String title, String description, String l1, String l2, String l3, String location,
                         Double longitude, Double latitude, Timestamp deadline, MultipartFile[] pic, MultipartFile[] picSmall) {
        if (!ObjectUtil.notNull(type, l1, l2, l3, location, longitude, latitude, deadline)) {
            return ResultCache.WRONG_PARAMETER_FORMAT;
        }
        return goodsService.uploadGoods(type, title, description, l1, l2, l3, location, longitude, latitude, deadline, pic, picSmall);
    }

    @RequestMapping(value = "comment/deleteGoods", method = RequestMethod.GET)
    public Result comment(Integer goodsID) {
        if (goodsID == null) {
            return ResultCache.WRONG_PARAMETER_FORMAT;
        }
        return goodsService.deleteGoods(goodsID);
    }

    @RequestMapping(value = "comment/addComment", method = RequestMethod.POST)
    public Result comment(Integer goodsID, String content) {
        if (!ObjectUtil.notNull(goodsID, content)) {
            return ResultCache.WRONG_PARAMETER_FORMAT;
        }
        return goodsService.comment(goodsID, content);
    }

    @RequestMapping(value = "comment/deleteComment", method = RequestMethod.GET)
    public Result deleteComment(Integer commentID) {
        if (commentID == null) {
            return ResultCache.WRONG_PARAMETER_FORMAT;
        }
        return goodsService.deleteComment(commentID);
    }
}
