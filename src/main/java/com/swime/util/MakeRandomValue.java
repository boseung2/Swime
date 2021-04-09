package com.swime.util;

public class MakeRandomValue {
    int length;

    public MakeRandomValue(){
        this.length = 20;
    }

    public String MakeAuthKey(){
        boolean isStr = false;
        String result = "";
        char randomNum = ' ', randomChar = ' ';

        for (int i = 0; i < length; i++) {
            isStr = (int)(Math.random()*2) == 0;
            randomChar = (char)('A' + (int)(Math.random()*26));
            randomNum = (char)('0' + (int)(Math.random()*10));
            result += isStr ? randomChar : randomNum;
        }

        return result;
    }

}
