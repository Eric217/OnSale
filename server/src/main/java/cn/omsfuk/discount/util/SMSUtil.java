package cn.omsfuk.discount.util;

import okhttp3.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

/**
 * Talk is cheap. Show me the code
 * 多说无益，代码上见真章
 * -------  by omsfuk  2017/9/13
 */
public abstract class SMSUtil {

//    private static final Logger logger = LoggerFactory.getLogger(SMSUtil.class);

    private static final MediaType JSON = MediaType.parse("application/json; charset=utf-8");

    private static OkHttpClient client = new OkHttpClient();

    public static String post(String url, String authHeader, String json)  {
        RequestBody body = RequestBody.create(JSON, json);
        Request request = new Request.Builder()
                .header("Content-Type", "application/json")
                .header("Authorization", authHeader)
                .url(url)
                .post(body)
                .build();

        try {
            System.out.println(request.body().contentLength() + request.body().contentType().toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(authHeader + " ||||| " + request + " ||||| " + json);
        String response = null;
        try {
            response = client.newCall(request).execute().body().string();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return response;
    }
}
