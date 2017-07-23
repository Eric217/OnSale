package cn.omsfuk.discount.filter;

import cn.omsfuk.discount.base.ResultCache;
import com.alibaba.fastjson.JSONObject;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by omsfuk on 2017/7/19.
 */
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        if (!((HttpServletRequest)request).getRequestURI().contains("api/anonymous")) {
            String login = (String) request.getAttribute("login");
            if ("true".equals(login)) {
                chain.doFilter(request, response);
            } else {
                PrintWriter writer = response.getWriter();
                writer.write(JSONObject.toJSONString(ResultCache.UNAUTHORIZED));
                writer.flush();
            }
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {

    }
}
