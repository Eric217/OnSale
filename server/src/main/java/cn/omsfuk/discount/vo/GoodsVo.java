package cn.omsfuk.discount.vo;

import cn.omsfuk.discount.dto.GoodsDto;
import lombok.Data;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.stream.Stream;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Data
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

    public GoodsVo(GoodsDto goodsDto) {
        this.id = goodsDto.getId();
        this.type = goodsDto.getType();
        this.title = goodsDto.getTitle();
        this.description = goodsDto.getDescription();
        this.loc0 = goodsDto.getLoc0();
        this.loc1 = goodsDto.getLoc1();
        this.loc2 = goodsDto.getLoc2();
        this.longitude = goodsDto.getLongitude();
        this.latitude = goodsDto.getLatitude();
        this.date = goodsDto.getDate();
        this.deadline = goodsDto.getDeadline();
        this.isValid = goodsDto.getIsValid();
        this.userId = goodsDto.getUserId();
        this.pic = transferPic(goodsDto.getPic(), goodsDto.getUserId());
    }

    private List<String> transferPic(String pic, Integer id) {
        if (pic == null) {
            return new ArrayList<>();
        }
        List<String> ans = new LinkedList<>();
        Stream.of(pic.split(";")).forEach(item -> {
            if (!(item == null || item.length() == 0 || "".equals(item))) {
                ans.add("img/" + id + "/" + item);
            }
        });
        return ans;
    }
}
