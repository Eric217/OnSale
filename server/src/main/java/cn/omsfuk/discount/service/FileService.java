package cn.omsfuk.discount.service;

import cn.omsfuk.discount.dto.UserDto;
import cn.omsfuk.discount.util.FileUtil;
import cn.omsfuk.discount.util.SessionUtil;
import cn.omsfuk.discount.vo.UserVo;
import org.apache.commons.io.FileUtils;
import org.springframework.aop.framework.AopContext;
import org.springframework.stereotype.Service;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

import static cn.omsfuk.discount.util.FileUtil.CLASSPATH;

/**
 * Created by omsfuk on 2017/7/17.
 */

@Service
public class FileService implements ServletContextAware {

    private static String basePath;

    public boolean initUserDir(UserDto user) {

        try {
            File dir = new File(basePath + user.getId() + "/");
            if (!dir.exists()) {
                dir.mkdirs();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        setDefaultPortrait(user);
        return true;
    }

    private void setDefaultPortrait(UserDto user) {
        try {
            FileUtils.copyFile(new File(basePath + "portrait.png"), new File(basePath + "static/img/" + user.getId() + "/portrait.png"));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public boolean overridePortrait(MultipartFile file) {
        try {
            file.transferTo(new File(basePath + "static/img/" + SessionUtil.user().getId() + "/portrait.png"));
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    public File[] writePic(MultipartFile[] files) {
        File[] savedFiles = new File[files.length];
        UserVo user = SessionUtil.user();
        for (int i = 0; i < files.length; i++) {
            savedFiles[i] = new File(basePath + user.getId() + "/" + UUID.randomUUID() + ".png");
            try {
                files[i].transferTo(savedFiles[i]);
            } catch (IOException e) {
                try {
                    for (int j = 0; j < i; j++) {
                        savedFiles[j].delete();
                    }
                } catch (Exception e1) {
                    e1.printStackTrace();
                }
                e.printStackTrace();
                return null;
            }
        }
        return savedFiles;
    }

    @Override
    public void setServletContext(ServletContext servletContext) {
        basePath = FileUtil.CLASSPATH + "/";
//        basePath = servletContext.getRealPath("").replace("\\", "/") + "image/";
    }
}
