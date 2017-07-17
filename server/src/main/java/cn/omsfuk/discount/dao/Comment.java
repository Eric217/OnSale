package cn.omsfuk.discount.dao;

import lombok.Data;

import java.sql.Timestamp;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Data
public class Comment {

    private Integer id;

    private Integer GoodsId;

    private Integer userId;

    private String content;

    private Timestamp date;

    public Comment() {
    }

    public Comment(Integer id, Integer goodsId, Integer userId, String content, Timestamp date) {
        this.id = id;
        GoodsId = goodsId;
        this.userId = userId;
        this.content = content;
        this.date = date;
    }
}
