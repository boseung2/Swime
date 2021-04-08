package com.swime.domain;

import lombok.Data;

@Data
public class MailVO {
    String Subject = "";
    String Text = "";
    String receiver = "";
}
