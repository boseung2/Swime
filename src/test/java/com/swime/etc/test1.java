package com.swime.etc;

import lombok.extern.log4j.Log4j;

import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Scanner;

public class test1{
    public static void main(String[] args) {
//        new Exercise4_15();
        new number();
    }
}

@Log4j
class Exercise4_15{

    Exercise4_15(){
        Scanner sc = new Scanner(System.in);

        int number = 0;

        try {
            log.info("숫자입력 : ");
            number = sc.nextInt();
        } catch (Exception e) {
            log.info("숫자가 아님");
            return;
        }


        int tmp = number;
        int result =0; // number 변수 를 거꾸로 변환해서 담을 변수
        while(tmp !=0) {
            result = result*10 + tmp % 10; // 10 . 기존 결과에 을 곱해서 더한다
            tmp /= 10;
        }
        if(number == result)
            System.out.println( number + " 는 회문수 입니다.");
        else
            System.out.println( number + " 는 회문수가 아닙니다.");
    } // main
}

@Log4j
class number{
    number(){
        Scanner sc = new Scanner(System.in);

        log.info("문자열 입력 : ");
        String number = sc.nextLine();

        if(number.length() == 3) return;
        for (int i = 0; i < number.length(); i++) {
            char tmp = number.charAt(i);
//            log.info(tmp);
            if(!('0'<= tmp && tmp <= '9')) throw new NumberFormatException();
        }


    }
}