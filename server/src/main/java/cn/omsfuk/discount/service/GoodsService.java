package cn.omsfuk.discount.service;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.base.ResultCache;
import cn.omsfuk.discount.dao.CommentDao;
import cn.omsfuk.discount.dao.GoodsDao;
import cn.omsfuk.discount.dao.UserDao;
import cn.omsfuk.discount.dto.CommentDto;
import cn.omsfuk.discount.dto.GoodsDto;
import cn.omsfuk.discount.plugin.OrderType;
import cn.omsfuk.discount.plugin.Pager;
import cn.omsfuk.discount.util.FileUtil;
import cn.omsfuk.discount.util.SessionUtil;
import cn.omsfuk.discount.util.UUIDUtil;
import cn.omsfuk.discount.vo.GoodsVo;
import cn.omsfuk.discount.vo.MultiRowsResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.sql.Timestamp;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Stream;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Service
@Transactional
public class GoodsService {

    private static final int MARK_INC_FIRST_UPLOAD = 100;

    private static final int MARK_INC_NONE_FIRST_UPLOAD = 10;

    private static final int MARK_INC_COMMENT = 1;

    @Autowired
    private FileService fileService;

    @Autowired
    private GoodsDao goodsDao;

    @Autowired
    private CommentDao commentDao;

    @Autowired
    private UserDao userDao;

    public Result uploadGoods(Integer type, String title, String description, String loc0, String loc1, String loc2,
                              String location, Double longitude, Double latitude, Timestamp deadline, MultipartFile[] picFiles, MultipartFile[] picSamllFiles, String picRatio) {

        StringBuilder sb = new StringBuilder();
        List<String> fileNames = new LinkedList<>();
        for (int i = 0; i < picFiles.length; i++) {
            String name = picFiles[i].getOriginalFilename().replaceAll("(.+)\\.(png|jpg|jpeg|gif)", UUIDUtil.uuid() + ".$2");
            System.out.println(name);
            sb.append("/static/img/").append(name).append(';');
            FileUtil.save(name, picFiles[i]);
            if (picSamllFiles.length > i) {
                FileUtil.save(name.replaceAll("(.+)\\.(png|jpg|jpeg|gif)", "$1_sm.$2"), picSamllFiles[i]);
            }
        }

        String pic = sb.toString();
        goodsDao.insertGoods(new GoodsDto(type, title, description, loc0, loc1, loc2, location, longitude, latitude, null, deadline, null, SessionUtil.user().getId(), pic, picRatio));
        userDao.updateUploadMark(SessionUtil.user().getId());
        return ResultCache.OK;
    }

    public Result getGoods(Integer id, Integer userId, String title, String loc0, String loc1, String loc2,
                           Integer isValid, Integer begin, Integer rows) {
        List<GoodsVo> goodsVos = goodsDao.getGoods(id, userId, title, loc0, loc1, loc2, isValid, begin, rows);
        goodsVos.stream().forEach(GoodsVo::transferPic);
        return ResultCache.getOk(new MultiRowsResult(goodsVos));
    }

    private String transferToUrl(File file) {
        return file.getName();
    }

    public Result comment(Integer goodsId, String conent) {
        int userId = SessionUtil.user().getId();
        commentDao.insertComment(new CommentDto(goodsId, userId, conent));
        userDao.updateCommentMark(userId);
        return ResultCache.OK;
    }

    public Result getComment(Integer id, Integer userId, Integer goodsId, Integer begin, Integer rows) {
        List<CommentDto> commentDtos = commentDao.getComment(id, userId, goodsId, begin, rows);
        Integer total = commentDao.getCommentCount(id, userId, goodsId);
        return ResultCache.getOk(new MultiRowsResult(total, commentDtos));
    }

    public Result deleteComment(Integer commentID) {
        return ResultCache.getOk(commentDao.deleteComment(commentID));
    }

    public Result deleteGoods(int goodsId) {
        return ResultCache.getOk(goodsDao.deleteGoods(goodsId));
    }

    public Result getAllGoods() {
        Pager<GoodsVo> pager = new Pager<>();
        pager.setCurrentPage(2);
        pager.setPageSize(3);
        pager.setOrderColumns("id");
        pager.setOrderType(OrderType.ASC);
        Result result = ResultCache.getOk(goodsDao.getAllGoods(pager, 1));
        return result;
    }

    public Result searchTitle(String keyWord) {
        return ResultCache.getOk(goodsDao.searchTitle(keyWord));
    }
}
