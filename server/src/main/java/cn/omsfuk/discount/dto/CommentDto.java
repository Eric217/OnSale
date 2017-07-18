package cn.omsfuk.discount.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.sql.Timestamp;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Data
public class CommentDto {

    private Integer id;

    @JsonProperty("goodsID")
    private Integer goodsId;

    @JsonProperty("userID")
    private Integer userId;

    private String content;

    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Timestamp date;

    public CommentDto() {
    }

    public CommentDto(Integer goodsId, Integer userId, String content) {
        this.id = id;
        this.goodsId = goodsId;
        this.userId = userId;
        this.content = content;
        this.date = date;
    }
}
