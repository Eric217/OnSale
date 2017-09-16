package cn.omsfuk.discount.error;

import cn.omsfuk.discount.base.Result;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by omsfuk on 2017/7/20.
 */

@ControllerAdvice
public class ControllerExceptionHandler {

    private static Logger logger = LoggerFactory.getLogger(ControllerExceptionHandler.class);

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Result exception(Exception exception) {
        exception.printStackTrace();
        return new Result(500, "server internal error", null);
    }
}
