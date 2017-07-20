package cn.omsfuk.discount.controller.anonymous;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by omsfuk on 2017/7/19.
 */

@RestController("annonymousMainController")
@RequestMapping("api/anonymous")
public class MainController {

    @Autowired
    private GoodsService goodsService;

    @RequestMapping(value = "comment/getComment", method = RequestMethod.GET)
    public Result getComment(Integer id, Integer goodsID, Integer userID,
                             @RequestParam(value = "page", defaultValue = "1") Integer page,
                             @RequestParam(value = "rows", defaultValue = "10") Integer rows) {
        return goodsService.getComment(id, userID, goodsID, (page - 1) * rows, rows);
    }

    @RequestMapping(value = "goods/getGoods", method = RequestMethod.POST)
    public Result getGoods(Integer id,
                           @RequestParam(value = "page", defaultValue = "1") Integer page,
                           @RequestParam(value = "rows", defaultValue = "10") Integer rows,
                           String l1, String l2, String l3,
                           Integer userID, Integer isValid) {
        return goodsService.getGoods(id, userID, l1, l2, l3, isValid, (page - 1) * rows, rows);
    }
}
