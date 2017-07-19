package cn.omsfuk.discount.controller.anonymous;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.base.ResultCache;
import cn.omsfuk.discount.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by omsfuk on 2017/7/19.
 */

@RestController
@RequestMapping("api")
public class GoodsController {

    @Autowired
    private UserService userService;

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
}
