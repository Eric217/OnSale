package cn.omsfuk.discount.dto;

import cn.omsfuk.discount.model.Role;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Data
@ToString
public class User {

    private Integer id;

    private String email;

    private String phone;

    private String password;

    private Role role;

    public User() {
    }

    public User(Integer id, String email, String phone, String password, Role role) {
        this.id = id;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.role = role;
    }
}
