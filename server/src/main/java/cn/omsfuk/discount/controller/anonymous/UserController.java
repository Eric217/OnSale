package cn.omsfuk.discount.controller.anonymous;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by omsfuk on 2017/7/19.
 */

@RestController
@RequestMapping("api/anonymous/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "getUserInfo", method = RequestMethod.GET)
    public Result getUserInfo(Integer id, String nickName, String email, String phone) {
        return userService.getUserInfo(id, nickName, email, phone);
    }

    public static void main(String[] args) {
        Class<?> cls = UserController.class;
    }

}
