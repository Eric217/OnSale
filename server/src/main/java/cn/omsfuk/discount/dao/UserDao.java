package cn.omsfuk.discount.dao;

import cn.omsfuk.discount.dto.UserDto;
import cn.omsfuk.discount.vo.UserVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Repository
public interface UserDao {

    int insertUser(UserDto user);

    UserVo getUserById(@Param("id") int id);

    UserVo getUserByEmail(@Param("email") String email);

    UserVo getUserByPhone(@Param("phone") String phone);

    UserVo getUserByNickName(@Param("nickName") String nickName);

    int updateUser(UserDto user);

    int updateUploadMark(@Param("userId") int userId);

    int updateCommentMark(@Param("userId") int userId);

    List<UserVo> getUserByCare(@Param("user_id") Integer userId);

}
