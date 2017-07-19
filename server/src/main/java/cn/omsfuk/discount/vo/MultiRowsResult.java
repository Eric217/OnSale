package cn.omsfuk.discount.vo;

import lombok.Data;

/**
 * Created by omsfuk on 2017/7/19.
 */

@Data
public class MultiRowsResult {

    private Integer total;

    private Object data;

    public MultiRowsResult(Integer total, Object data) {
        this.total = total;
        this.data = data;
    }
}
