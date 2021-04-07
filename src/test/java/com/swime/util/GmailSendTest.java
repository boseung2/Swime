package com.swime.util;

import com.swime.domain.MailVO;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class GmailSendTest {

    @Test
    public void test(){
        GmailSend gmailSend = new GmailSend();
        MailVO vo = new MailVO();
        vo.setReceiver("tht1234551@gmail.com");
        vo.setSubject("테스트중");
        vo.setText("http://localhost/user/auth");
        Assert.assertTrue(gmailSend.sendAuthMail(vo));
    }
}
