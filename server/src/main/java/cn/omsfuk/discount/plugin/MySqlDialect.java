package cn.omsfuk.discount.plugin;

/**
 * Created by omsfuk on 2017/7/23.
 */
public class MySqlDialect implements Dialect {

    @Override
    public String getLimitString(String sql, int offset, int limit) {
        StringBuilder stringBuilder = new StringBuilder(sql);
        stringBuilder.append(" limit ");
        if (offset > 0) {
            stringBuilder.append(offset).append(",").append(limit);
        } else {
            stringBuilder.append(limit);
        }
        return stringBuilder.toString();
    }

    @Override
    public String getOrderString(String sql, String orderColumns, OrderType orderType) {
        return new StringBuilder(sql).append(" order by ").append(orderColumns).append(" ")
                .append(orderType.toString()).toString();
    }
}
