package cn.omsfuk.discount.service;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.base.ResultCache;
import cn.omsfuk.discount.dao.*;
import cn.omsfuk.discount.dto.CareDto;
import cn.omsfuk.discount.dto.FavoriteDto;
import cn.omsfuk.discount.dto.HistoryDto;
import cn.omsfuk.discount.dto.UserDto;
import cn.omsfuk.discount.model.Role;
import cn.omsfuk.discount.util.CrytoUtil;
import cn.omsfuk.discount.util.RandomUtil;
import cn.omsfuk.discount.util.SMSUtil;
import cn.omsfuk.discount.util.SessionUtil;
import cn.omsfuk.discount.vo.GoodsVo;
import cn.omsfuk.discount.vo.MultiRowsResult;
import cn.omsfuk.discount.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Service
@Transactional
public class UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private FileService fileService;

    @Autowired
    private FavoriteDao favoriteDao;

    @Autowired
    private HistoryDao historyDao;

    @Autowired
    private CareDao careDao;

    @Autowired
    private GoodsDao goodsDao;

    public Result loginWithEmail(String email, String password) {
        return login(userDao.getUserByEmail(email), password);
    }

    public Result loginWithPhone(String phone, String password) {
        return login(userDao.getUserByPhone(phone), password);
    }

    public Result loginWithNickName(String nickName, String password) {
        return login(userDao.getUserByNickName(nickName), password);
    }

    private Result login(UserVo user, String password) {
        if (user == null) {
            return ResultCache.getFailure("no such user");
        }
        if (!user.getPassword().equals(password)) {
            return ResultCache.getFailure("wrong password");
        }
        SessionUtil.setAttribute("user", user);
        SessionUtil.setAttribute("login", "true");
        return ResultCache.getOk(user);
    }

    private Result register(UserDto user) {
        userDao.insertUser(user);
        fileService.initUserDir(user);
        return ResultCache.OK;
    }

    public Result registerWithEmail(String email, String nickname, String password, String gender) {
        return register(new UserDto(nickname, null, 0, gender, null, null, email, null, password, Role.NORMAL, null));
    }

    public Result registerWithPhone(String phone, String nickname, String password, String gender) {
        return register(new UserDto(nickname, null, 0, gender, null, null, null, phone, password, Role.NORMAL, null));
    }

    public Result validate(String email, String phone, String nickname) {
        if (email != null) {
            if (userDao.getUserByEmail(email) != null) {
                return ResultCache.getOk(true);
            }
        }
        if (phone != null) {
            if (userDao.getUserByPhone(phone) != null) {
                return ResultCache.getOk(true);
            }
        }
        if (nickname != null) {
            if (userDao.getUserByNickName(nickname) != null) {
                return ResultCache.getOk(true);
            }
        }
        return ResultCache.getOk(false);
    }

    public Result getUserInfo(Integer id, String nickName, String email, String phone) {
        if (id != null) {
            return ResultCache.getOk(userDao.getUserById(id));
        }
        if (nickName != null) {
            return ResultCache.getOk(userDao.getUserByNickName(nickName));
        }
        if (email != null) {
            return ResultCache.getOk(userDao.getUserByEmail(email));
        }
        if (phone != null) {
            return ResultCache.getOk(userDao.getUserByPhone(phone));
        }
        return ResultCache.WRONG_PARAMETER_FORMAT;
    }

    public Result updateUser(UserDto user) {
        user.setId(SessionUtil.user().getId());
        return ResultCache.getOk(userDao.updateUser(user));
    }

    public Result changePortrait(MultipartFile data) {
        if (fileService.overridePortrait(data)) {
            return ResultCache.OK;
        } else {
            return ResultCache.FAILURE;
        }
    }

    public Result getFavorite(int begin, int rows) {
        int userId = SessionUtil.user().getId();
        List<GoodsVo> favorite = goodsDao.getGoodsByFavorite(userId);
//        FavoriteDto favorite = favoriteDao.getFavoriteByUserId(userId, begin, rows);
        Integer total = favoriteDao.getFavoriteCountByUserId(userId);
        return ResultCache.getOk(new MultiRowsResult(total, favorite == null ? null : favorite));
    }

    public Result addFavorite(int goodsId) {
        return ResultCache.getOk(favoriteDao.insertFavorite(SessionUtil.user().getId(), goodsId));
    }

    public Result deleteFavor(int goodsId) {
        return ResultCache.getOk(favoriteDao.deleteFavorite(SessionUtil.user().getId(), goodsId));
    }

    public Result getHistory(int begin, int rows) {
        int userId = SessionUtil.user().getId();
        List<GoodsVo> history = goodsDao.getGoodsByHistory(userId);
//        HistoryDto history = historyDao.getHistoryByUserId(userId, begin, rows);
        Integer total = historyDao.getHistoryCountByUserId(userId);
        return ResultCache.getOk(new MultiRowsResult(total, history == null ? null : history));
    }

    public Result addHistory(int goodsId) {
        return ResultCache.getOk(historyDao.insertHistory(SessionUtil.user().getId(), goodsId));
    }

    public Result deleteHistory() {
        return ResultCache.getOk(historyDao.deleteHistory(SessionUtil.user().getId()));
    }

    public Result getCare(int begin, int rows) {
        int userId = SessionUtil.user().getId();
        List<UserVo> users = userDao.getUserByCare(userId);
//        CareDto care = careDao.getCareByUserId(userId, begin, rows);
        Integer total = careDao.getCareCountByUserId(userId);
        return ResultCache.getOk(new MultiRowsResult(total, users));
    }

    public Result addCare(int followed) {
        return ResultCache.getOk(careDao.insertCare(SessionUtil.user().getId(), followed));
    }

    public Result deleteCare(int followed) {
        return ResultCache.getOk(careDao.deleteCare(SessionUtil.user().getId(), followed));
    }

    public Result sendCode(String phone) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
        String token = "85005e015360167cd4aaaea88613e3d5";
        String userId = "4e481c5a75eba023b85e5d8cb6953033";
        String timestamp = simpleDateFormat.format(System.currentTimeMillis());
        String sig = CrytoUtil.md5(userId + token + timestamp).toUpperCase();
        String url = "https://api.ucpaas.com/2014-06-30/Accounts/4e481c5a75eba023b85e5d8cb6953033/Messages/templateSMS?sig=" + sig;
        String auth = CrytoUtil.encodeBase64(userId + ':' + timestamp);
        String code = RandomUtil.getNum(4);
        System.out.println(SMSUtil.post(url, auth, "{\"templateSMS\":{\"appId\":\"804f8b6aef4a42c3a45c4278f4590ca6\",\"param\":\""
                + code
                +  "\",\"templateId\":\"151913\",\"to\":\"" + phone + "\"}}"));

        SessionUtil.setAttribute("code", code);
        return ResultCache.OK;
    }
}
