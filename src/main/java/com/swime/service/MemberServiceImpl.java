package com.swime.service;

import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
import com.swime.mapper.MemberMapper;
import com.swime.util.MakeRandomValue;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

@Log4j
@Service
//@AllArgsConstructor
public class MemberServiceImpl implements MemberService{

    @Setter(onMethod_ = @Autowired)
    private MemberMapper mapper;


    @Override
    public MemberVO get(String id) {
        return mapper.read(id);
    }

    @Override
    public boolean register(MemberVO vo) {
//        registerHistory(vo);
//        vo.setPassword(passwordEncoder.encode(vo.getPassword()));
        boolean result = mapper.insert(vo) == 1;
//        if(result) registerKey(vo.getId(), new MakeRandomValue().MakeAuthKey());
        return result;
    }

    @Override
    public boolean modify(MemberVO vo, MemberHistoryVO hvo) {
        registerHistory(vo, hvo);
        return mapper.update(vo) == 1;
    }

    @Override
    public boolean remove(String id, MemberHistoryVO hvo) {
        MemberVO vo = mapper.read(id);
        vo.setStatus("USST03");
        registerHistory(vo, hvo);
        return mapper.delete(id) == 1;
    }

    @Override
    public List<MemberVO> getlist() {
        return mapper.getlist();
    }

    @Override
    public boolean checkIdPw(MemberVO vo) {
        MemberVO memberVO = mapper.read(vo.getId());
        return memberVO != null && !memberVO.getStatus().equals("USST03")
                ? memberVO.getPassword().equals(vo.getPassword()) : false;
    }

    @Override
    public boolean registerHistory(MemberVO vo) {
        MemberHistoryVO hvo = new MemberHistoryVO();
        hvo.setEmail(vo.getId());
        hvo.setUpdMtr("register");
        hvo.setBefVal("");
        hvo.setAftVal("");
        return mapper.registerHistory(hvo) == 1;
    }


    @Override
    public List<MemberHistoryVO> getHistList(String id) {
        return mapper.getHistory(id);
    }

    @Override
    public boolean registerHistory(MemberVO afterData, MemberHistoryVO hvo) { //변경하려는 데이터가 들어와야함

//        // 1. memberVO로 바뀐데이터를 받아온다.
//        파라미터 afterData

//        // 2. 원래 데이터 read한다.
        MemberVO beforeData = mapper.read(afterData.getId());

//        // 3. 두개를 비교한다.
        Map diff = new MemberServiceUtil().compare(beforeData, afterData);

        // 4. 다른부분들을 history테이블에 insert한다.
        diff.forEach((k,v) -> {
            hvo.setUpdMtr((String) k);
            hvo.setBefVal(((String[])v)[0]);
            hvo.setAftVal(((String[])v)[1]);
            mapper.registerHistory(hvo);
//            if(mapper.registerHistory(hvo) == 1) return false;
        });

        return true;
    }


    @Override
    public boolean registerKey(String id, String key) {
        return mapper.insertKey(id, key) == 1;
    }

    @Override
    public boolean isKey(String id, String key) {
        return mapper.selectKey(id).equals(key);
    }

    @Override
    public boolean deleteKey(String id) {
        return mapper.deleteKey(id) == 1;
    }

}



class MemberServiceUtil{
    public Map compare(MemberVO vo1, MemberVO vo2){
        String[] mtr = {"name", "password", "birth", "status", "picture", "emailAuth"};
        String[] beforeVal = makeList(vo1);
        String[] afterVal = makeList(vo2);
        Map<String, String[]> compareResult = new HashMap<>();
        for (int i = 0; i < mtr.length; i++)
            if((beforeVal[i] != null && afterVal[i] != null) && !(beforeVal[i].equals(afterVal[i])))
                compareResult.put(mtr[i], new String[]{beforeVal[i], afterVal[i]});
        return compareResult;
    }

    public String[] makeList(MemberVO vo){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("YYYY/MM/DD HH:MM:SS");
        String[] list = new String[]{vo.getName(), vo.getPassword(), vo.getBirth(), vo.getStatus(), vo.getPicture(), ""};
        if(vo.getEmailAuth() != null) list[5] = simpleDateFormat.format(vo.getEmailAuth());
        return list;
    }
}