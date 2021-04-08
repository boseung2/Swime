package com.swime.util;

public class MakeRandomValue {
    int length;

    MakeRandomValue(){
        this.length = 20;
    }

    String MakeAuthKey(){
        boolean isStr = false;
        int randomValue = 0;
        char str = ' ';
        String result = "";

        for (int i = 0; i < length; i++) {
            isStr = (int)(Math.random()*2) == 0;
            randomValue = (int)(Math.random()*26);

            if(isStr) result += (char)('A'+randomValue);
            if(!isStr) result += randomValue;

        }
        return result;
    }

}
