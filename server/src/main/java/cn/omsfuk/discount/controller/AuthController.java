package cn.omsfuk.discount.controller;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.base.ResultCache;
import cn.omsfuk.discount.dto.UserDto;
import cn.omsfuk.discount.service.AuthService;
import cn.omsfuk.discount.util.ObjectUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 * Created by omsfuk on 2017/7/17.
 */


@RestController
@RequestMapping("api/")
public class AuthController {

    @Autowired
    private AuthService authService;

    @RequestMapping(value = "user/signIn")
    public Result signIn(String email, String phone, String password) {
        if (ObjectUtil.notNull(email, password)) {
            return authService.loginWithEmail(email, password);
        } else if (ObjectUtil.notNull(phone, password)) {
            return authService.loginWithPhone(phone, password);
        } else {
            return ResultCache.getFailure("wrong parameter format");
        }
    }

    @RequestMapping(value = "user/signUp", method = RequestMethod.POST)
    public Result signUp(String email, String phone, String nickName, String password, String gender) {
        if (ObjectUtil.notNull(email, password, nickName, gender)) {
            return authService.registerWithEmail(email, nickName, password, gender);
        } else if (ObjectUtil.notNull(phone, password, nickName)) {
            return authService.registerWithPhone(phone, nickName, password, gender);
        } else {
            return ResultCache.getFailure("wrong parameter format");
        }
    }

    @RequestMapping(value = "user/changeInfo", method = RequestMethod.POST)
    public Result changeInfo(UserDto user) {
        return authService.updateUser(user);
    }

    @RequestMapping(value = "user/validateSignUp", method = RequestMethod.POST)
    public Result validate(String email, String phone, String nickname) {
        return authService.validate(email, phone, nickname);
    }

    @RequestMapping(value = "user/getUserInfo", method = RequestMethod.GET)
    public Result getUserInfo(Integer id, String nickName, String email, String phone) {
        return authService.getUserInfo(id, nickName, email, phone);
    }

    @RequestMapping(value = "user/chagePic", method = RequestMethod.POST)
    public Result changPortrait(MultipartFile data) {
        if (data == null) {
            return ResultCache.WRONG_PARAMETER_FORMAT;
        }
        return authService.changePortrait(data);
    }

    @RequestMapping(value = "user/addCollection", method = RequestMethod.GET)
    public Result addCollection(Integer goodsID) {
        if (goodsID == null) {
            return ResultCache.WRONG_PARAMETER_FORMAT;
        }
        return authService.addFavorite(goodsID);
    }

    @RequestMapping(value = "user/getCollection", method = RequestMethod.GET)
    public Result getCollection(@RequestParam(defaultValue = "1") Integer page,
                                @RequestParam(defaultValue = "10") Integer rows) {
        return authService.getFavorite((page - 1) * rows, rows);
    }

}
