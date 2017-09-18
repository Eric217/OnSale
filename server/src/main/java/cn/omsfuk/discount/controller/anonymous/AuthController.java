package cn.omsfuk.discount.controller.anonymous;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.base.ResultCache;
import cn.omsfuk.discount.service.UserService;
import cn.omsfuk.discount.util.ObjectUtil;
import cn.omsfuk.discount.util.SessionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by omsfuk on 2017/7/19.
 */

@RestController
@RequestMapping("api/anonymous")
public class AuthController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "user/signIn", method = RequestMethod.POST)
    public Result signIn(String email, String phone, String password, String nickName) {
        if (ObjectUtil.notNull(nickName, password)) {
            return userService.loginWithNickName(nickName, password);
        }
        if (ObjectUtil.notNull(email, password)) {
            return userService.loginWithEmail(email, password);
        } else if (ObjectUtil.notNull(phone, password)) {
            return userService.loginWithPhone(phone, password);
        } else {
            return ResultCache.getFailure("wrong parameter format");
        }
    }

    @RequestMapping(value = "signUp", method = RequestMethod.POST)
    public Result signUp(String email, String phone, String nickName, String password, String gender) {
        if (ObjectUtil.notNull(email, password, nickName, gender)) {
            return userService.registerWithEmail(email, nickName, password, gender);
        } else if (ObjectUtil.notNull(phone, password, nickName)) {
            return userService.registerWithPhone(phone, nickName, password, gender);
        } else {
            return ResultCache.getFailure("wrong parameter format");
        }
    }
    @RequestMapping(value = "user/logout", method = RequestMethod.GET)
    public Result logout() {
        SessionUtil.setAttribute("login", "false");
        return ResultCache.OK;
    }

    @RequestMapping(value = "validateSignUp", method = RequestMethod.POST)
    public Result validate(String email, String phone, String nickname) {
        return userService.validate(email, phone, nickname);
    }

    @RequestMapping(value = "verify/phone", method = RequestMethod.POST)
    public Result verify_phone(String phone) {
        return userService.sendCode(phone);
    }
    
    @RequestMapping(value = {"verify/code1", "verify/code2"}, method = RequestMethod.POST)
    public Result verifyCode1(String code) {
        if (code == null || "".equals(code)) {
            return ResultCache.WRONG_PARAMETER_FORMAT;
        }
        if (!code.equals(SessionUtil.getAttribue("code"))) {
            return ResultCache.getOk(false);
        }

        return ResultCache.getOk(true);
    }

}
