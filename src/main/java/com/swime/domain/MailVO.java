package com.swime.domain;

import lombok.Data;

@Data
public class MailVO {
    String Subject = "";
    String Text = "";
    String receiver = "";

    public MailVO(String receiver, String subject, String text){
        this.receiver = receiver;
        this.Subject = subject;
        this.Text = text;
    }

    public MailVO(String receiver, String key){
        this(receiver,"swime 인증메일입니다","안녕하세요 다음 url을 클릭해서 인증을 마치세요\n"
                +"http://localhost/user/auth" + "?id=" + receiver + "&key=" + key);
    }

//    private String makeContent(String receiver, String key) {
//        String content =
//    }
}
