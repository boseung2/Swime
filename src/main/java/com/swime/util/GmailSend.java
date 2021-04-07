package com.swime.util;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

public class GmailSend {
    String user = "studywithmeauth@gmail.com"; // 네이버일 경우 네이버 계정, gmail경우 gmail 계정
    String password = "1q2w3e4r5t6Y";   // 패스워드

    // SMTP 서버 정보를 설정한다.
    Properties prop = new Properties();
    GmailSend() {
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", 465);
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.ssl.enable", "true");
        prop.put("mail.smtp.ssl.trust", "smtp.gmail.com");


        Session session = Session.getDefaultInstance(prop, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(user));

            //수신자메일주소
            message.addRecipient(Message.RecipientType.TO, new InternetAddress("tht1234551@naver.com"));

            // Subject
            message.setSubject("제목 테스트중입니다"); //메일 제목을 입력

            // Text
            message.setText("내용 테스트중입니다");    //메일 내용을 입력

            // send the message
            Transport.send(message); ////전송
            System.out.println("message sent successfully...");
        } catch (
        AddressException ae) {
            // TODO Auto-generated catch block
            ae.printStackTrace();
        } catch (
        MessagingException me) {
            // TODO Auto-generated catch block
            me.printStackTrace();
        }
    }


}
