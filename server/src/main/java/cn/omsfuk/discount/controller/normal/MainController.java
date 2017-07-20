package cn.omsfuk.discount.controller.normal;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.base.ResultCache;
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

    @RequestMapping(value = "goods/upload")
    public Result upload(Integer type, String title, String description, String l1, String l2, String l3,
                         Double longitude, Double latitude, Timestamp deadline, MultipartFile[] pic) {
        if (!ObjectUtil.notNull(type, l1, l2, l3, longitude, latitude, deadline, pic)) {
            return ResultCache.WRONG_PARAMETER_FORMAT;
        }
        return goodsService.uploadGoods(type, title, description, l1, l2, l3, longitude, latitude, deadline, pic);
    }

    @RequestMapping(value = "comment/addComment", method = RequestMethod.POST)
    public Result comment(Integer goodsID, String content) {
        if (!ObjectUtil.notNull(goodsID, content)) {
            return ResultCache.WRONG_PARAMETER_FORMAT;
        }
        return goodsService.comment(goodsID, content);
    }
}
