package com.swime.etc;

import com.swime.domain.ProfileCriteria;
import org.junit.Test;

import java.util.Arrays;

public class criTest {

    @Test
    public void whyNotWorking(){
        ProfileCriteria[] cris;

        cris = new ProfileCriteria[]{
                new ProfileCriteria(1,2),
                new ProfileCriteria(3,4),
                new ProfileCriteria(5,6)
        };

    }
}

