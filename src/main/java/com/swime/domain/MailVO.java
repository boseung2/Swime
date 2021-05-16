package com.swime.domain;

import lombok.Data;

@Data
public class MailVO {
    String subject = "";
    String Text = "";
    String receiver = "";

    public MailVO(String receiver, String subject, String text, String a){
        this.receiver = receiver;
        this.subject = subject;
        this.Text = text;
    }

    public MailVO(String receiver, String key, String getServerName){
        this(receiver,"SWIME 인증메일",
                "        <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"100%\" bgcolor=\"#f4f4f4\">\n" +
                "            <tbody>\n" +
                "                <tr>\n" +
                "                    <td width=\"100%\" height=\"80\"></td>\n" +
                "                </tr>\n" +
                "                <tr>\n" +
                "                    <td>\n" +
                "                    <table align=\"center\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"760\" style=\"margin:0 auto\">\n" +
                "                        <tbody>\n" +
                "                            <tr>\n" +
                "                                <td colspan=\"3\"><img src=\"" + getServerName + "/resources/img/logo.png\" style=\"width : 100px;\"></td>\n" +
                "                            </tr>\n" +
                "                            <tr>\n" +
                "                                <td colspan=\"3\" height=\"14\"></td>\n" +
                "                            </tr>\n" +
                "                            <tr>\n" +
                "                                <td colspan=\"3\" height=\"1\" bgcolor=\"#dfdfdf\"></td>\n" +
                "                            </tr>\n" +
                "                            <tr>\n" +
                "                                <td width=\"1\" bgcolor=\"#dfdfdf\"></td> \n" +
                "                                <td width=\"758\" bgcolor=\"#ffffff\">\n" +
                "                                    <table align=\"center\" cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"624\" style=\"margin:0 auto\">\n" +
                "                                        <tbody>\n" +
                "                                            <tr>\n" +
                "                                                <td height=\"53\"></td>\n" +
                "                                            </tr>\n" +
                "                                            <tr>\n" +
                "                                                <td>\n" +
                "                                                    <h1 style=\"margin : 0; text-align : center; font-family: fantasy; font-size : 1.8em; color :rgb(26, 24, 24)\">회원 인증</h1>\n" +
                "                                                </td>\n" +
                "                                            </tr>\n" +
                "                                            <tr>\n" +
                "                                                <td height=\"35\"></td>\n" +
                "                                            </tr>\n" +
                "                                            <tr>\n" +
                "                                                <td height=\"2\" bgcolor=\"#cccccc\"></td>\n" +
                "                                            </tr>\n" +
                "                                            <tr>\n" +
                "                                                <td height=\"50\"></td>\n" +
                "                                            </tr>\n" +
                "                                            <tr><td>\n" +
                "                                                <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"100%\">\n" +
                "                                                <tbody><tr><td rowspan=\"3\" width=\"9\"></td><td style=\"font-weight:bold;font-size:16px;font-family:'돋움',dotum,sans-serif;color:#1b1b1b; text-align:center;\">안녕하세요. SWIME 입니다.</td></tr>\n" +
                "                                                <tr><td height=\"6\"></td></tr>\n" +
                "                                                <tr><td style=\"font-size:12px;font-family:'돋움',dotum,sans-serif;color:#444;line-height:20px; text-align:center;\">\n" +
                "                                                                        SWIME  아이디 인증을 다음과 같이 알려드립니다.\n" +
                "                                                                    <br><br>\n" +
                "                                                    <strong style=\"color:#f56a4f\">회원 인증을 원하시면 아래 버튼을 클릭해주세요.</strong><br>\n" +
                "                                                    인증번호는 메일이 발송된 시점부터 <strong>10분간만 유효</strong>합니다.</td></tr>\n" +
                "                                                </tbody></table>\n" +
                "                                            </td></tr>\n" +
                "                                            <tr><td>\n" +
                "                                                <table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"100%\">\n" +
                "                                                    <tbody><tr>\n" +
                "                                                        <a href=\"" + "http://" + getServerName + "/user/auth?id=" + receiver + "&key=" + key + "\" style=\"text-decoration: none;\"><div style=\"border : solid 1px; width : 150px; height : 30px; margin : 50px auto; padding-top : 8px;\n" +
                "                                                        border-radius : 0.3em; color : white; background-color : rgb(100, 194, 231); text-align: center; vertical-align : center; cursor : pointer;\">인증하기</div></a>\n" +
                "                                                    </tbody></table>\n" +
                "                                            </td></tr>\n" +
                "                                        </tbody>\n" +
                "                                    </table>\n" +
                "                                </td>\n" +
                "                                <td width=\"1\" bgcolor=\"#dfdfdf\"></td> \n" +
                "                            </tr>\n" +
                "                            <tr>\n" +
                "                                <td colspan=\"3\" height=\"1\" bgcolor=\"#dfdfdf\"></td>\n" +
                "                            </tr>\n" +
                "                        </tbody>\n" +
                "                    </table>\n" +
                "                    </td>\n" +
                "                </tr>\n" +
                "                <tr>\n" +
                "                    <td width=\"100%\" height=\"80\"></td>\n" +
                "                </tr>\n" +
                "            </tbody>\n" +
                "        </table>\n", "");
    }


}
