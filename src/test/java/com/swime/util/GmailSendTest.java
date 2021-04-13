package com.swime.util;

import com.swime.domain.MailVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class, com.swime.config.SecurityConfig.class})
@Log4j
public class GmailSendTest {

    @Setter(onMethod_ = @Autowired)
    GmailSend gmailSend;

    @Test
    public void test(){
        MailVO vo = new MailVO();
        vo.setReceiver("tht1234551@gmail.com");
        vo.setSubject("테스트중");
        vo.setText("http://localhost/user/auth");
        Assert.assertTrue(gmailSend.sendAuthMail(vo));
    }
}
