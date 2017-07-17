package cn.omsfuk.discount.util;

import cn.omsfuk.discount.vo.UserVo;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

/**
 * Created by omsfuk on 2017/7/17.
 */
public class SessionUtil {

    public static UserVo user() {
        return (UserVo) RequestContextHolder.getRequestAttributes().getAttribute("user", RequestAttributes.SCOPE_SESSION);
    }

    public static void setAttribute(String key, Object value) {
        RequestContextHolder.getRequestAttributes().setAttribute(key, value, RequestAttributes.SCOPE_SESSION);
    }
}
