package cn.omsfuk.discount.cache;

import cn.omsfuk.discount.vo.UserVo;
import com.alibaba.fastjson.JSONObject;
import org.apache.ibatis.cache.Cache;
import redis.clients.jedis.Jedis;

import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

/**
 * Created by omsfuk on 2017/7/20.
 */
public class RedisCache implements Cache {

    private String id;

    public RedisCache(String id) {
        System.out.println("invoke RedisCache");
        this.id = id;
    }

    private ReadWriteLock readWritetLock = new ReentrantReadWriteLock();

    private Jedis getJedis() {
        return new Jedis("139.199.39.220", 5379);
    }

    @Override
    public String getId() {
        System.out.println("invoke getId");
        return this.id;
    }

    @Override
    public void putObject(Object key, Object value) {
        System.out.println("invoke putObject");
        System.out.println("key : " + key);
        System.out.println("value : " + value);
        getJedis().set(JSONObject.toJSONString(key), JSONObject.toJSONString(value));
    }

    @Override
    public Object getObject(Object key) {
        System.out.println("invoke getObject");
        return JSONObject.parseArray(getJedis().get(JSONObject.toJSONString(key)), UserVo.class);
    }

    @Override
    public Object removeObject(Object key) {
        System.out.println("invoke removeObject");
        return getJedis().del(JSONObject.toJSONString(key));
    }

    @Override
    public void clear() {
        System.out.println("invoke clear");
    }

    @Override
    public int getSize() {
        System.out.println("invoke getSize");
        return 1000;
    }

    @Override
    public ReadWriteLock getReadWriteLock() {
        System.out.println("invoke getReadWriteLock");
        return this.readWritetLock;
    }

    public static void main(String[] args) {
//        new RedisCache().getJedis().set("omsfuk", "admin");
    }
}
