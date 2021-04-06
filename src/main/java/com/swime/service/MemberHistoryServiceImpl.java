package com.swime.service;

import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
import com.swime.mapper.MemberHistoryMapper;
import com.swime.mapper.MemberMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@Log4j
@Service
@AllArgsConstructor
public class MemberHistoryServiceImpl implements MemberHistoryService{

    @Setter(onMethod_ = @Autowired)
    MemberMapper memberMapper;

    @Setter(onMethod_ = @Autowired)
    MemberHistoryMapper memberHistoryMapper;

    @Override
    public boolean registerHistory(MemberVO indata, String updUserId, String description) { //변경하려는 데이터가 들어와야함
        MemberHistoryVO memberHistoryVO = new MemberHistoryVO();
        memberHistoryVO.setEmail(indata.getId());
        memberHistoryVO.setUpdUserId(updUserId);
        memberHistoryVO.setDescription(description);
        //무엇이 변경되었는지 확인되어야함
        //memberMapper 로 먼저 불러와서 비교
        MemberVO data = memberMapper.read(indata.getId());

        change(memberHistoryVO,"name",data.getName(),indata.getName());
        change(memberHistoryVO,"password",data.getPassword(),indata.getPassword());
        change(memberHistoryVO,"birth",data.getBirth(),indata.getBirth());
        change(memberHistoryVO,"status",data.getStatus(),indata.getStatus());
        change(memberHistoryVO,"picture",data.getPicture(),indata.getPicture());
        change(memberHistoryVO,"emailAuth",data.getEmailAuth(),indata.getEmailAuth());

        //틀린게 있을때마다
        //history 로 만들어서 인서트 해야함

        return false;
    }

    void change(MemberHistoryVO vo,String mtr,Object o1, Object o2){
        String s1 = "", s2 = "";

        if(o1 instanceof String && o2 instanceof String){
            s1 = (String)o1;
            s2 = (String)o2;
        }

        if(o1 instanceof Date && o2 instanceof Date){
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("YYYY/MM/DD HH:MM:SS");
            s1 = simpleDateFormat.format(o1);
            s2 = simpleDateFormat.format(o2);
        }

        if(!s1.equals(s2)){
            vo.setBefVal(s1);
            vo.setAftVal(s2);
            vo.setUpdMtr(mtr);
            memberHistoryMapper.insert(vo);
        }

    }

}
