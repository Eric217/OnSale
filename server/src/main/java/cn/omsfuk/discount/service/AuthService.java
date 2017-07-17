package cn.omsfuk.discount.service;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.base.ResultCache;
import cn.omsfuk.discount.dao.UserDao;
import cn.omsfuk.discount.dto.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Service
public class AuthService {

    @Autowired
    private UserDao userDao;
    public Result loginWithEmail(String email, String password) {
        User user = userDao.getUserByEmail(email);
        if (user == null) {
            return ResultCache.getFailure("no such user");
        }
        if (!user.getPassword().equals(password)) {
            return ResultCache.getFailure("wrong password");
        }
        return ResultCache.getOk();
    }

    public Result loginWithPhone(String phone, String password) {
        User user = userDao.getUserByPhone(phone);
        if (user == null) {
            return ResultCache.getFailure("no such user");
        }
    }
}
