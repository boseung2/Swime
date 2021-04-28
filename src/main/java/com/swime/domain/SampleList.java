package com.swime.domain;

import lombok.Data;

import java.util.ArrayList;

@Data
public class SampleList {
    ArrayList<Sample> list;

    public SampleList(){
        list = new ArrayList<>();
    }
}
