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

/**
 * Created by omsfuk on 2017/7/17.
 */

@RestController
@RequestMapping("api/goods")
public class GoodsController {

    @Autowired
    private GoodsService goodsService;

    @RequestMapping(value = "upload")
    public Result upload(Integer type, String title, String description, String location,
                         Double longitude, Double latitude, Timestamp deadline, MultipartFile[] pic) {
        System.out.println(pic);
        if (!ObjectUtil.notNull(type, location, longitude, latitude, longitude, deadline, pic)) {
            return ResultCache.getFailure("wrong parameter format");
        }
        return goodsService.uploadGoods(type, title, description, location, longitude, latitude, deadline, pic);
    }

    @RequestMapping(value = "getGoods", method = RequestMethod.GET)
    public Result getGoods(Integer id, @RequestParam(value = "page", defaultValue = "1") Integer page,
                           @RequestParam(value = "rows", defaultValue = "10") Integer rows,
                           Integer userID, Integer isValid) {
        return null;
    }

    @RequestMapping(value = "comment", method = RequestMethod.POST)
    public Result comment(Integer ) {

    }
}
