package cn.omsfuk.discount.model;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Data
public class Role {

    private Integer id;

    private String name;

    private List<String> privileges;

    public boolean hasPrivilege(String privilegeName) {
        return privileges.contains(privilegeName);
    }

    public Role(Integer id, String name, List<String> privileges) {
        this.id = id;
        this.name = name;
        this.privileges = privileges;
    }

    public Role() {
    }

    @Override
    public String toString() {
        return name;
    }
}
