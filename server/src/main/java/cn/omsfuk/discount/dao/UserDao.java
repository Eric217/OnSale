package cn.omsfuk.discount.dao;

import cn.omsfuk.discount.dto.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Repository
public interface UserDao {

    User getUserById(@Param("id") int id);

    User getUserByEmail(@Param("id") String email);

    User getUserByPhone(@Param("phone") String phone);

}
