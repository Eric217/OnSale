package cn.omsfuk.discount.controller;

import cn.omsfuk.discount.base.Result;
import cn.omsfuk.discount.base.ResultCache;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by omsfuk on 2017/7/20.
 */

@RestController
public class ReloadController implements ApplicationContextAware {

    private ConfigurableApplicationContext applicationContext;

    @RequestMapping(value = "api/anonymous/fuck", method = RequestMethod.GET)
    public Result reload() {
        long startTime = System.currentTimeMillis();
        applicationContext.refresh();
        return ResultCache.getOk("Time elapsed : [ " + (System.currentTimeMillis() - startTime) + " ]");
    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = (ConfigurableApplicationContext) applicationContext;
    }
}
