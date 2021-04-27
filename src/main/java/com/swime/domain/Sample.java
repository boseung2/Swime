package com.swime.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Sample {
    int a;
    int b;

//    public Sample(){
//        this(1, 1);
//    }
//
//    public Sample(int a, int b){
//        this.a = a;
//        this.b = b;
//    }
}
