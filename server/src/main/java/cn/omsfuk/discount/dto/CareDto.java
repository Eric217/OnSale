package cn.omsfuk.discount.dto;

import cn.omsfuk.discount.vo.UserVo;
import lombok.Data;

import java.util.List;

/**
 * Talk is cheap. Show me the code
 * 多说无益，代码上见真章
 * -------  by omsfuk  2017/9/6
 */

@Data
public class CareDto {

    private Integer id;

    private Integer userId;

    private List<UserVo> users;

}
