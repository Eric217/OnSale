package cn.omsfuk.discount.service;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.base.ResultCache;
import cn.omsfuk.discount.dao.FavoriteDao;
import cn.omsfuk.discount.dao.UserDao;
import cn.omsfuk.discount.dto.UserDto;
import cn.omsfuk.discount.util.SessionUtil;
import cn.omsfuk.discount.vo.MultiRowsResult;
import cn.omsfuk.discount.vo.UserVo;
import cn.omsfuk.discount.model.Role;
import com.mysql.cj.api.Session;
import org.apache.ibatis.annotations.ResultType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Service
public class UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private FileService fileService;

    @Autowired
    private FavoriteDao favoriteDao;

    public Result loginWithEmail(String email, String password) {
        return login(userDao.getUserByEmail(email), password);
    }

    public Result loginWithPhone(String phone, String password) {
        return login(userDao.getUserByPhone(phone), password);
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
        // TODO 返回用户信息
        return ResultCache.getOk(user);
    }

    private Result register(UserDto user) {
        userDao.insertUser(user);
        fileService.initUserDir(user);
        return ResultCache.OK;
    }

    public Result registerWithEmail(String email, String nickname, String password, String gender) {
        return register(new UserDto(nickname, 0, gender, null, null, email, null, password, Role.NORMAL));
    }

    public Result registerWithPhone(String phone, String nickname, String password, String gender) {
        return register(new UserDto(nickname, 0, gender, null, null, null, phone, password, Role.NORMAL));
    }

    public Result validate(String email, String phone, String nickname) {
        if (email != null) {
            if (userDao.getUserByEmail(email) != null) {
                return ResultCache.getFailure("email duplicate");
            }
        }
        if (phone != null) {
            if (userDao.getUserByPhone(phone) != null) {
                return ResultCache.getFailure("phone duplicate");
            }
        }
        if (nickname != null) {
            if (userDao.getUserByNickName(nickname) != null) {
                return ResultCache.getFailure("nickname duplicate");
            }
        }
        return ResultCache.OK;
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
        return ResultCache.getOk(new MultiRowsResult(favoriteDao.getFavoriteCountByUserId(userId),
                favoriteDao.getFavoriteByUserId(userId, begin, rows).getFavorite()));
    }

    public Result addFavorite(Integer goodsId) {
        return ResultCache.getOk(favoriteDao.insertFavorite(SessionUtil.user().getId(), goodsId));
    }
}
