package com.swime.task;

import com.swime.domain.GroupAttachVO;
import com.swime.mapper.GroupAttachMapper;
import com.swime.util.CheckOS;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Log4j
@Component
public class FileCheckTask {

    @Setter(onMethod_ = {@Autowired})
    private GroupAttachMapper groupAttachMapper;

//    @Setter(onMethod_ = {@Autowired})
    CheckOS checkOS = CheckOS.getInstance();

    final String uploadFolder = checkOS.getImgFilePath();

    private String getFolderYesterDay() {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Calendar cal = Calendar.getInstance();

        cal.add(Calendar.DATE, -1);

        String str = sdf.format(cal.getTime());

        return str.replace("-", File.separator);
    }
    @Scheduled(cron="0 0 2 * * *")
    public void checkFiles() throws Exception {

        log.warn("File Check Task run...................");
        log.warn(new Date());

        List<GroupAttachVO> fileList = groupAttachMapper.getOldFiles();

        List<Path> fileListPaths = fileList.stream().map(vo -> Paths.get(uploadFolder, vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName())).collect(Collectors.toList());

        fileList.stream().filter(vo -> vo.isFileType() == true).map(vo -> Paths.get(uploadFolder, vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName())).forEach(p -> fileListPaths.add(p));

        log.warn("===========================================");

        fileListPaths.forEach(p -> log.warn(p));

        File targetDir = Paths.get(uploadFolder, getFolderYesterDay()).toFile();

        File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);

        log.warn("-------------------------------------");
        for(File file : removeFiles) {
            log.warn(file.getAbsolutePath());
            file.delete();
        }
    }
}


//@Log4j
//@Component
//public class FileCheckTask {
//
//    @Setter(onMethod_ = {@Autowired})
//    private GroupAttachMapper groupAttachMapper;
//
//    private String getFolderYesterDay() {
//
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//
//        Calendar cal = Calendar.getInstance();
//
//        cal.add(Calendar.DATE, -1);
//
//        String str = sdf.format(cal.getTime());
//
//        return str.replace("-", File.separator);
//    }
//    @Scheduled(cron="0 0 2 * * *")
//    public void checkFiles() throws Exception {
//
//        log.warn("File Check Task run...................");
//        log.warn(new Date());
//
//        List<GroupAttachVO> fileList = groupAttachMapper.getOldFiles();
//
//        List<Path> fileListPaths = fileList.stream().map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), vo.getUuid() + "_" + vo.getFileName())).collect(Collectors.toList());
//
//        fileList.stream().filter(vo -> vo.isFileType() == true).map(vo -> Paths.get("C:\\upload", vo.getUploadPath(), "s_" + vo.getUuid() + "_" + vo.getFileName())).forEach(p -> fileListPaths.add(p));
//
//        log.warn("===========================================");
//
//        fileListPaths.forEach(p -> log.warn(p));
//
//        File targetDir = Paths.get("C:\\upload", getFolderYesterDay()).toFile();
//
//        File[] removeFiles = targetDir.listFiles(file -> fileListPaths.contains(file.toPath()) == false);
//
//        log.warn("-------------------------------------");
//        for(File file : removeFiles) {
//            log.warn(file.getAbsolutePath());
//            file.delete();
//        }
//    }
//}