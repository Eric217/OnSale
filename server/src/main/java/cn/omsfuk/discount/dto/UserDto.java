package cn.omsfuk.discount.dto;

import lombok.Data;
import lombok.ToString;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Data
@ToString
public class UserDto {

    private Integer id;

    private String nickname;

    private String realName;

    private String realId;

    private String gender;

    private String email;

    private String phone;

    private String password;

    private Integer roleId;

    public UserDto() {
    }

    public UserDto(String nickname, String gender, String realName, String realId, String email, String phone, String password, Integer roleId) {
        this.nickname = nickname;
        this.gender = gender;
        this.realName = realName;
        this.realId = realId;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.roleId = roleId;
    }
}
