package cn.omsfuk.discount.dao;

import cn.omsfuk.discount.dto.FavoriteDto;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Created by omsfuk on 2017/7/19.
 */

@Repository
public interface FavoriteDao {

    FavoriteDto getFavoriteByUserId(@Param("userId") int userId, @Param("begin") int begin, @Param("rows") int rows);

    int getFavoriteCountByUserId(@Param("userId") int userId);

    int insertFavorite(@Param("userId") int userId, @Param("goodsId") int goodsId);

}
