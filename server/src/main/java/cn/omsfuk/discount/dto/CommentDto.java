package cn.omsfuk.discount.dto;

import lombok.Data;

import java.sql.Timestamp;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Data
public class CommentDto {

    private Integer id;

    private Integer GoodsId;

    private Integer userId;

    private String content;

    private Timestamp date;

    public CommentDto() {
    }

    public CommentDto(Integer goodsId, Integer userId, String content) {
        this.id = id;
        GoodsId = goodsId;
        this.userId = userId;
        this.content = content;
        this.date = date;
    }
}
