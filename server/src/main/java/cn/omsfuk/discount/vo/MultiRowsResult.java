package cn.omsfuk.discount.vo;

import lombok.Data;

/**
 * Created by omsfuk on 2017/7/19.
 */

@Data
public class MultiRowsResult {

    private Object data;

    private Integer total;

    public MultiRowsResult(Object data) {
        this.data = data;
    }

    public MultiRowsResult(Integer total, Object data) {
        this.total = total;
        this.data = data;
    }
}
