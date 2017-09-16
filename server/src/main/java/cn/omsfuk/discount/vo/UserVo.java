package cn.omsfuk.discount.vo;

import cn.omsfuk.discount.model.Role;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.ToString;

import java.util.Date;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Data
@ToString
public class UserVo {

    private Integer id;

    private Integer mark;

    private String nickName;

    private String signature;

    private String realName;

    @JsonProperty("realID")
    private String realId;

    private String gender;

    private String email;

    private String phone;

    private String password;

    private Date birthday;

    @JsonIgnore
    private Role role;

    public UserVo() {
    }

    public UserVo(String nickName, String signature, String realName, String realId, String gender, String email, String phone, String password, Role role, Date birthday) {
        this.nickName = nickName;
        this.signature = signature;
        this.realName = realName;
        this.realId = realId;
        this.gender = gender;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.role = role;
        this.birthday = birthday;
    }
}
