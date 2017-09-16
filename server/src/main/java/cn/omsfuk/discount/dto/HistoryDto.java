package cn.omsfuk.discount.dto;

import cn.omsfuk.discount.vo.GoodsVo;
import lombok.Data;

import java.util.List;

/**
 * Talk is cheap. Show me the code
 * 多说无益，代码上见真章
 * -------  by omsfuk  2017/7/30
 */

@Data
public class HistoryDto {

    private Integer id;

    private Integer userId;

    private List<GoodsVo> history;

}
