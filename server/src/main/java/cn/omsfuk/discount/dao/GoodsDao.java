package cn.omsfuk.discount.dao;

import cn.omsfuk.discount.dto.GoodsDto;
import org.springframework.stereotype.Repository;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Repository
public interface GoodsDao {

    int insertGoods(GoodsDto goods);
}
