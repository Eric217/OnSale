package cn.omsfuk.discount.dao;

import cn.omsfuk.discount.dto.HistoryDto;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Talk is cheap. Show me the code
 * 多说无益，代码上见真章
 * -------  by omsfuk  2017/7/30
 */

@Repository
public interface HistoryDao {

    HistoryDto getHistoryByUserId(@Param("userId") int userId, @Param("begin") int begin, @Param("rows") int rows);

    Integer getHistoryCountByUserId(@Param("userId") int userId);

    int insertHistory(@Param("userId") int userId, @Param("goodsId") int goodsId);

    int deleteHistory(@Param("userId") int userId);
}
