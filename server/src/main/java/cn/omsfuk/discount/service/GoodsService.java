package cn.omsfuk.discount.service;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.base.ResultCache;
import cn.omsfuk.discount.dao.GoodsDao;
import cn.omsfuk.discount.dto.GoodsDto;
import cn.omsfuk.discount.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.sql.Timestamp;
import java.util.stream.Stream;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Service
public class GoodsService {

    @Autowired
    private FileService fileService;

    @Autowired
    private GoodsDao goodsDao;

    public Result uploadGoods(Integer type, String title, String description, String location,
                              Double longitude, Double latitude, Timestamp deadline, MultipartFile[] picFiles) {
        File[] files = fileService.writePic(picFiles);
        if (files == null) {
            return ResultCache.FAILURE;
        }

        StringBuilder sb = new StringBuilder();
        Stream.of(files).forEach(file -> {
            sb.append(transferToUrl(file)).append(';');
        });
        String pic = sb.toString();
        goodsDao.insertGoods(new GoodsDto(type, title, description, location, longitude, latitude, null, deadline, null, SessionUtil.user().getId(), pic));
        return ResultCache.OK;
    }

    private String transferToUrl(File file) {
        return file.getName();
    }

}
