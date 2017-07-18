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

    private String loc0;

    private String loc1;

    private String loc2;

    private Double longitude;

    private Double latitude;

    private Timestamp date;

    private Timestamp deadline;

    private Integer isValid;

    private Integer userId;

    private List<String> pic;

    public GoodsVo() {
    }

    public GoodsVo(Integer type, String title, String description, String loc0, String loc1, String loc2,
                   Double longitude, Double latitude, Timestamp date, Timestamp deadline, Integer isValid,
                   Integer userId, List<String> pic) {
        this.type = type;
        this.title = title;
        this.description = description;
        this.loc0 = loc0;
        this.loc1 = loc1;
        this.loc2 = loc2;
        this.longitude = longitude;
        this.latitude = latitude;
        this.date = date;
        this.deadline = deadline;
        this.isValid = isValid;
        this.userId = userId;
        this.pic = pic;
    }
}
