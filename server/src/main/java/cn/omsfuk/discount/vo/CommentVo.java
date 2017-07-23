package cn.omsfuk.discount.vo;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.sql.Timestamp;

/**
 * Created by omsfuk on 2017/7/18.
 */
@Data
public class CommentVo {
    private Integer id;

    @JsonProperty("goodsID")
    private Integer goodsId;

    private UserVo user;

    private String content;

    private Timestamp date;

}
