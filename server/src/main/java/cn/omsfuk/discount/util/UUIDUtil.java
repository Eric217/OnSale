package cn.omsfuk.discount.util;

import java.util.UUID;

/**
 * Talk is cheap. Show me the code
 * 多说无益，代码上见真章
 * -------  by omsfuk  2017/9/13
 */
public class UUIDUtil {

    public static String uuid() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }
}
