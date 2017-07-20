package cn.omsfuk.discount.controller.anonymous;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.base.ResultCache;
import cn.omsfuk.discount.dto.UserDto;
import cn.omsfuk.discount.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 * Created by omsfuk on 2017/7/19.
 */

@RestController
@RequestMapping("api/anonymous/user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "changeInfo", method = RequestMethod.POST)
    public Result changeInfo(UserDto user) {
        return userService.updateUser(user);
    }

    @RequestMapping(value = "getUserInfo", method = RequestMethod.GET)
    public Result getUserInfo(Integer id, String nickName, String email, String phone) {
        return userService.getUserInfo(id, nickName, email, phone);
    }

    @RequestMapping(value = "chagePic", method = RequestMethod.POST)
    public Result changPortrait(MultipartFile data) {
        if (data == null) {
            return ResultCache.WRONG_PARAMETER_FORMAT;
        }
        return userService.changePortrait(data);
    }

}
