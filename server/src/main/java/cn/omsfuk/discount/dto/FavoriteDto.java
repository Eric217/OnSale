package cn.omsfuk.discount.dto;

import cn.omsfuk.discount.vo.GoodsVo;
import lombok.Data;

import java.util.List;

/**
 * Created by omsfuk on 2017/7/19.
 */

@Data
public class FavoriteDto {

    private Integer id;

    private Integer userId;

    private List<GoodsVo> favorite;
}
