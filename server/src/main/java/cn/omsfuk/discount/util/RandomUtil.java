package cn.omsfuk.discount.util;

import java.util.Random;

/**
 * Talk is cheap. Show me the code
 * 多说无益，代码上见真章
 * -------  by omsfuk  2017/9/13
 */
public class RandomUtil {

    public static String getNum(int n) {
        Random random  = new Random();
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < n; i++) {
            sb.append(random.nextInt(10));
        }
        return sb.toString();
    }

}
