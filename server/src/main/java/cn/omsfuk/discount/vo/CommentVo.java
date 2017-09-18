package cn.omsfuk.discount.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
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

    @JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
    private Timestamp date;

}
