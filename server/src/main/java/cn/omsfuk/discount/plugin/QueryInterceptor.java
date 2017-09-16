package cn.omsfuk.discount.plugin;

import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.executor.statement.BaseStatementHandler;
import org.apache.ibatis.executor.statement.RoutingStatementHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.logging.jdbc.ConnectionLogger;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.plugin.*;
import org.springframework.util.ReflectionUtils;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;
import java.util.Properties;
import java.util.stream.Stream;

/**
 * Created by omsfuk on 2017/7/23.
 */
//从签名里可以看出，要拦截的目标类型是StatementHandler（注意：type只能配置成接口类型），拦截的方法是名称为prepare参数为Connection类型的方法。
@Intercepts({@Signature(type = StatementHandler.class, method = "prepare", args = {Connection.class})})
public class QueryInterceptor implements Interceptor, Serializable {

    private static final long serialVersionUID = 1L;

    protected Dialect DIALECT = new MySqlDialect();

    /**
     * 对ID做正则匹配，只对query开头的方法进行处理
     */
    protected String _SQL_PATTERN = ".*get.*";

    /**
     * 真正实现拦截器业务逻辑的方法
     */
    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        //StatementHandler的默认实现类是RoutingStatementHandler，因此拦截的实际对象是它。
        // RoutingStatementHandler的主要功能是分发，它根据配置Statement类型创建真正执行数据库操作的StatementHandler，
        // 并将其保存到delegate属性里。
        if (invocation.getTarget() instanceof RoutingStatementHandler) {
            RoutingStatementHandler statementHandler = (RoutingStatementHandler) invocation.getTarget();
            BaseStatementHandler delegate =
                    (BaseStatementHandler) getField(RoutingStatementHandler.class, "delegate").get(statementHandler);
            MappedStatement mappedStatement =
                    (MappedStatement) getField(BaseStatementHandler.class, "mappedStatement").get(delegate);
            //重新需要分页的SQL
            if (mappedStatement.getId().matches(_SQL_PATTERN)) {
                BoundSql boundSql = delegate.getBoundSql();
                String originalSql = boundSql.getSql();

                if(StringUtils.isBlank(originalSql)){
                    return invocation.proceed();
                }

                Map parameterObject = (Map) boundSql.getParameterObject();
                //查询参数--上下文传参
                Pager pager = getPager(parameterObject.get("pager"));

                // 第一个参数为Connection
                System.out.println("----------------------start------------------------");
                Stream.of(invocation.getArgs()).forEach(System.out::println);
                System.out.println("-----------------------end-------------------------");
                ConnectionLogger connection = (ConnectionLogger) invocation.getArgs()[0];

                if (pager != null) {
                    //处理排序
                    originalSql = generateOrderSql(originalSql, pager, DIALECT);
                    //处理分页
                    String pageSql = generatePageSql(originalSql, pager, DIALECT);
                    //赋值，将新的SQL覆盖原SQL
                    setFieldValue(boundSql, "sql", pageSql);
                }
            }
        }
        //交给下一个拦截器
        return invocation.proceed();
    }

    /** 这几个私有方法可以单独提取出去，在SQL处理类里面，这里放在一个类里是为了方便查看 */

    private Field getField(Class<?> clazz, String name){
        Field field = ReflectionUtils.findField(clazz, name);
        field.setAccessible(true);
        return field;
    }

    private Pager getPager(Object object){
        if (object instanceof Pager){
            return (Pager)object;
        }
        return null;
    }

    private String generateOrderSql(String sql,Pager pager,Dialect dialect){
        if (StringUtils.isBlank(pager.getOrderColumns())){
            return sql;
        }
        return dialect.getOrderString(sql, pager.getOrderColumns(),pager.getOrderType());
    }

    private String generatePageSql(String sql,Pager pager,Dialect dialect){
        int pageSize = pager.getPageSize();
        int index = (pager.getCurrentPage() - 1) * pageSize;
        int start = index < 0 ? 0 : index;
        return dialect.getLimitString(sql, start, pageSize);
    }

    private void setFieldValue(Object object,String fieldName,Object value){
        try {
            Field field = object.getClass().getDeclaredField(fieldName);
            field.setAccessible(true);
            field.set(object,value);
        } catch (NoSuchFieldException | IllegalAccessException e) {
            //这里不可能抛出异常
            e.printStackTrace();
        }
    }

    public static int queryForTotalCount(Connection connection, String sql) {
        String prefix = sql.substring(0, sql.indexOf("select") + 6);
        String suffix = sql.substring(sql.indexOf("where"), sql.length());
        String ret = prefix + " count(1) " + suffix;
//        System.out.println(ret);
        try {
            connection.prepareStatement(ret);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

//    public static void main(String[] args) {
//        queryForTotalCount(null, "select * from note where id = 1");
//    }

    @Override
    public Object plugin(Object target) {
        if (target instanceof StatementHandler) {
            //目标属于StatementHandler时才包装该类
            return Plugin.wrap(target, this);
        } else {
            //否则，直接返回目标类，减少代理次数
            return target;
        }
    }

    @Override
    public void setProperties(Properties properties) {

    }
}