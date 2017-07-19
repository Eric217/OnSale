package cn.omsfuk.discount.service;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.base.ResultCache;
import cn.omsfuk.discount.dao.UserDao;
import cn.omsfuk.discount.dto.CommentDto;
import cn.omsfuk.discount.dao.CommentDao;
import cn.omsfuk.discount.dao.GoodsDao;
import cn.omsfuk.discount.dto.GoodsDto;
import cn.omsfuk.discount.dto.UserDto;
import cn.omsfuk.discount.util.SessionUtil;
import cn.omsfuk.discount.vo.CommentVo;
import cn.omsfuk.discount.vo.GoodsVo;
import cn.omsfuk.discount.vo.MultiRowsResult;
import com.mysql.cj.api.Session;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.theme.SessionThemeResolver;

import java.io.File;
import java.sql.Timestamp;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;
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
        goodsDao.insertGoods(new GoodsDto(type, title, description, loc0, loc1, loc2, longitude, latitude, null, deadline, null, SessionUtil.user().getId(), pic));
        userDao.updateUploadMark(SessionUtil.user().getId());
        return ResultCache.OK;
    }

    public Result getGoods(Integer id, Integer userId, String loc0, String loc1, String loc2,
                           Integer isValid, Integer begin, Integer rows) {
        int total = goodsDao.getGoodsCount(id, userId, loc0, loc1, loc2, isValid);
        List<GoodsVo> goodsVos = goodsDao.getGoods(id, userId, loc0, loc1, loc2, isValid, begin, rows);
        goodsVos.stream().forEach(GoodsVo::transferPic);
        return ResultCache.getOk(new MultiRowsResult(total, goodsVos));
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
        int total = commentDao.getCommentCount(id, userId, goodsId);
        List<CommentDto> commentDtos = commentDao.getComment(id, userId, goodsId, begin, rows);
        return ResultCache.getOk(new MultiRowsResult(total, commentDtos));
    }

}
