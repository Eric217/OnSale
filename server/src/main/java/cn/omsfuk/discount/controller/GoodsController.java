package cn.omsfuk.discount.controller;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.base.ResultCache;
import cn.omsfuk.discount.dto.GoodsDto;
import cn.omsfuk.discount.service.GoodsService;
import cn.omsfuk.discount.util.ObjectUtil;
import cn.omsfuk.discount.util.SessionUtil;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.UUID;

/**
 * Created by omsfuk on 2017/7/17.
 */

@RestController
@RequestMapping("api/goods")
public class GoodsController {

    @Autowired
    private GoodsService goodsService;

    @RequestMapping(value = "upload")
    public Result upload(Integer type, String title, String description, String loc0, String loc1, String loc2,
                         Double longitude, Double latitude, Timestamp deadline, MultipartFile[] pic) {
        if (!ObjectUtil.notNull(type, loc0, loc1, loc2, longitude, latitude, longitude, deadline, pic)) {
            return ResultCache.WRONG_PARAMETER_FORMAT;
        }
        return goodsService.uploadGoods(type, title, description, loc0, loc1, loc2, longitude, latitude, deadline, pic);
    }

    @RequestMapping(value = "getGoods", method = RequestMethod.POST)
    public Result getGoods(Integer id,
                           @RequestParam(value = "page", defaultValue = "1") Integer page,
                           @RequestParam(value = "rows", defaultValue = "10") Integer rows,
                           String l1, String l2, String l3,
                           Integer userID, Integer isValid) {
        return goodsService.getGoods(id, userID, l1, l2, l3, isValid, (page - 1) * rows, rows);
    }

    @RequestMapping(value = "comment", method = RequestMethod.POST)
    public Result comment(Integer goodsID, String content) {
        if (!ObjectUtil.notNull(goodsID, content)) {
            return ResultCache.WRONG_PARAMETER_FORMAT;
        }
        return goodsService.comment(goodsID, content);
    }

    @RequestMapping(value = "getComment", method = RequestMethod.GET)
    public Result getComment(Integer id, Integer goodsID, Integer userID,
                             @RequestParam(value = "page", defaultValue = "1") Integer page,
                             @RequestParam(value = "rows", defaultValue = "10") Integer rows) {
        return goodsService.getComment(id, userID, goodsID, (page - 1) * rows, rows);
    }
}
