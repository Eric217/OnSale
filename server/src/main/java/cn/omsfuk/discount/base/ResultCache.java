package cn.omsfuk.discount.base;

/**
 * Created by omsfuk on 2017/7/17.
 */
public final class ResultCache {

    public static final String MSG_OK = "ok";

    public static final String MSG_FAILURE = "failure";

    public static final String MSG_PERMISSION_DENIED = "permission denied";

    public static final Result OK = new Result(200, MSG_OK, null);

    public static final Result FAILURE = new Result(300, MSG_FAILURE, null);

    public static final Result PERMISSION_DENIED = new Result(400, MSG_PERMISSION_DENIED, null);

    public static final Result WRONG_PARAMETER_FORMAT = new Result(300, "wrong parameter format", null);

    public static Result getOk(Object object) {
        return new Result(200, MSG_OK, object);
    }

    public static Result getFailure(String message) {
        return new Result(300, message, null);
    }
}
