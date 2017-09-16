package cn.omsfuk.discount.dao;

import cn.omsfuk.discount.dto.CareDto;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

/**
 * Talk is cheap. Show me the code
 * 多说无益，代码上见真章
 * -------  by omsfuk  2017/9/6
 */

@Repository
public interface CareDao {

    CareDto getCareByUserId(@Param("follower") int follower, @Param("begin") int begin, @Param("rows") int rows);

    Integer getCareCountByUserId(@Param("follower") int follower);

    int insertCare(@Param("follower") int follower, @Param("followed") int followed);

    int deleteCare(@Param("follower") int follower, @Param("followed") int followed);
}
