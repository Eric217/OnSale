package cn.omsfuk.discount.dto;

import lombok.Data;
import lombok.ToString;

import java.util.Date;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Data
@ToString
public class UserDto {

    private Integer id;

    private Integer mark;

    private Integer type;

    private String nickName;

    private String signature;

    private String realName;

    private String realId;

    private String gender;

    private String email;

    private String phone;

    private String password;

    private Integer roleId;

    private Date birthday;

    public UserDto() {
    }

    public UserDto(String nickName, String signature, Integer mark, String gender, String realName, String realId, String email, String phone, String password, Integer roleId, Date birthday) {
        this.nickName = nickName;
        this.signature = signature;
        this.mark = mark;
        this.gender = gender;
        this.realName = realName;
        this.realId = realId;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.roleId = roleId;
        this.birthday = birthday;
    }
}
