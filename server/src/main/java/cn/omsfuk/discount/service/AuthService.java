package cn.omsfuk.discount.service;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.base.ResultCache;
import cn.omsfuk.discount.dao.UserDao;
import cn.omsfuk.discount.dto.UserDto;
import cn.omsfuk.discount.util.SessionUtil;
import cn.omsfuk.discount.vo.UserVo;
import cn.omsfuk.discount.model.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Service
public class AuthService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private FileService fileService;

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
        // TODO 返回用户信息
        return ResultCache.getOk(user);
    }

    private Result register(UserDto user) {
        fileService.initUserDir(user);
        return ResultCache.getOk(userDao.insertUser(user));
    }

    public Result registerWithEmail(String email, String nickname, String password) {
        return register(new UserDto(nickname, null, null, null, email, null, password, Role.NORMAL));
    }

    public Result registerWithPhone(String phone, String nickname, String password) {
        return register(new UserDto(nickname, null, null, null, null, phone, password, Role.NORMAL));
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


}
