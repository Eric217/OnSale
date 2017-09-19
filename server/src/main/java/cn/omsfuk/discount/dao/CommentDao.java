package cn.omsfuk.discount.dao;

import cn.omsfuk.discount.dto.CommentDto;
import cn.omsfuk.discount.vo.CommentVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Repository
public interface CommentDao {

    int insertComment(CommentDto comment);

    List<CommentVo> getComment(@Param("id") Integer id,
                             @Param("userId") Integer userId,
                             @Param("goodsId") Integer goodsId,
                             @Param("begin") Integer begin,
                             @Param("rows") Integer rows);

    int getCommentCount(@Param("id") Integer id,
                   @Param("userId") Integer userId,
                   @Param("goodsId") Integer goodsId);

    int deleteComment(@Param("id") int id);

    CommentVo getCommentById(@Param("id") int id);
}
