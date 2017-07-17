package cn.omsfuk.discount.vo;

import cn.omsfuk.discount.model.Role;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;
import lombok.ToString;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Data
@ToString
public class UserVo {

    private Integer id;

    private String nickname;

    private String realName;

    private String realId;

    private String gender;

    private String email;

    private String phone;

    private String password;

    @JsonIgnore
    private Role role;

    public UserVo() {
    }

    public UserVo(String nickname, String realName, String realId, String gender, String email, String phone, String password, Role role) {
        this.nickname = nickname;
        this.realName = realName;
        this.realId = realId;
        this.gender = gender;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.role = role;
    }
}
