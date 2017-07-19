package cn.omsfuk.discount.dao;

import cn.omsfuk.discount.dto.GoodsDto;
import cn.omsfuk.discount.vo.GoodsVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Repository
public interface GoodsDao {

    int insertGoods(GoodsDto goods);

    List<GoodsVo> getGoods(@Param("id") Integer id,
                           @Param("userId") Integer userId,
                           @Param("loc0") String loc0,
                           @Param("loc1") String loc1,
                           @Param("loc2") String loc2,
                           @Param("isValid") Integer isValid,
                           @Param("begin") Integer begin,
                           @Param("rows") Integer rows);
}
