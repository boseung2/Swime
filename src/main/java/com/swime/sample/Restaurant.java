package com.swime.sample;

import lombok.Data;
import lombok.Setter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Data
@Component
public class Restaurant {

    @Setter(onMethod_= @Autowired)
    private Chef chef;

}
