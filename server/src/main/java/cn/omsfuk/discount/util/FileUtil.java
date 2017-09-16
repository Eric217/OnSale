package cn.omsfuk.discount.util;

import org.springframework.util.ResourceUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Calendar;
import java.util.Date;
import java.util.UUID;

/**
 * Talk is cheap. Show me the code
 * 多说无益，代码上见真章
 * -------  by omsfuk  2017/9/10
 */
public abstract class FileUtil {

    public static String CLASSPATH;

    static {
        try {
            CLASSPATH = ResourceUtils.getFile("classpath:.").getPath();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static String mixedWithDate(String fileName) {
        StringBuilder sb = new StringBuilder();
        sb.append(mixedDate()).append('/').append(fileName);
        return sb.toString();
    }

    private static String mixedDate() {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date(System.currentTimeMillis()));
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int day = calendar.get(Calendar.DAY_OF_MONTH);
        StringBuilder sb = new StringBuilder();
        sb.append(CLASSPATH).append("/static/img/").append(year).append('/').append(month)
                .append('/').append(day);
        return sb.toString();
    }

    public static File mixedWithDate(MultipartFile file) throws IOException {
        String dir = mixedDate();
        new File(dir).mkdirs();
        File fil = new File(dir + '/' + file.getOriginalFilename());
        file.transferTo(fil);
        return fil;
    }

    public static File save(String fileName, MultipartFile file) {
        File fil = new File(CLASSPATH + "/static/img/" + fileName);
        try {
            file.transferTo(fil);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return fil;
    }
}
