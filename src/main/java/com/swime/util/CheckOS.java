package com.swime.util;

import lombok.extern.log4j.Log4j;

@Log4j
public class CheckOS {
    final static String OS = System.getProperty("os.name").toLowerCase();
    static CheckOS checkos;

    public CheckOS(){
        log.info("Use OS is " + OS);
    }

    public static CheckOS getInstance(){
        if(checkos == null) checkos = new CheckOS();
        return checkos;
    }

    public boolean isLinux(){
        return OS.contains("linux");
    }

    public boolean isWindows(){
        return OS.contains("win");
    }

    public boolean isMac(){
        return OS.contains("mac");
    }

    public String getImgFilePath(){
        String filePath = "";
        if(isWindows())
            filePath = "c:/upload/";

        if(!isWindows())
            filePath = (this.getClass().getResource("").getPath()) + "../../../../../resources/upload/";

//        System.out.println(filePath);

        return filePath;
    }

    public String withoutDeleteFilePath(){
        String filePath = "";
//        if(isWindows())
//            filePath = "c:/upload/";
//
//
//        if(!isWindows())
//            filePath = (this.getClass().getResource("").getPath()) + "../../../../../resources/upload/";

        return filePath;
    }

    public String convertSlash(String str){
        String result = str.replaceAll("/", "\\");
        return result;
    }
}
