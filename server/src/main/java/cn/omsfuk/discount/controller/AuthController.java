package cn.omsfuk.discount.controller;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.base.ResultCache;
import cn.omsfuk.discount.dto.UserDto;
import cn.omsfuk.discount.service.AuthService;
import cn.omsfuk.discount.util.ObjectUtil;
import cn.omsfuk.discount.vo.UserVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
    public Result signUp(String email, String phone, String nickname, String password) {
        if (ObjectUtil.notNull(email, password, nickname)) {
            return authService.registerWithEmail(email, nickname, password);
        } else if (ObjectUtil.notNull(phone, password, nickname)) {
            return authService.registerWithPhone(phone, nickname, password);
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
}
