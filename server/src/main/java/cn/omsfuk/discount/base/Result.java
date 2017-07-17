package cn.omsfuk.discount.base;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Data
@AllArgsConstructor
public class Result {

    private Integer status;

    private String message;

    private Object data;
}
