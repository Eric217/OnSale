package cn.omsfuk.discount.vo;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by omsfuk on 2017/7/17.
 */
public class GoodsVo {

    private Integer id;

    private Integer type;

    private String title;

    private String description;

    private String location;

    private Double longitude;

    private Double latitude;

    private Timestamp date;

    private Timestamp deadline;

    private Integer isValid;

    private Integer userId;

    private List<String> pic;

    public GoodsVo() {
    }

    public GoodsVo(Integer type, String title, String description, String location,
                   Double longitude, Double latitude, Timestamp date, Timestamp deadline, Integer isValid,
                   Integer userId, List<String> pic) {
        this.type = type;
        this.title = title;
        this.description = description;
        this.location = location;
        this.longitude = longitude;
        this.latitude = latitude;
        this.date = date;
        this.deadline = deadline;
        this.isValid = isValid;
        this.userId = userId;
        this.pic = pic;
    }
}
