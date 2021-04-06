package com.swime.service;

import com.swime.domain.GroupVO;
import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
import com.swime.mapper.GroupMapper;
import com.swime.mapper.MemberMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService{

    private MemberMapper mapper;


    @Override
    public MemberVO get(String id) {
        MemberVO memberVO = mapper.read(id);
        if(memberVO.getStatus().equals("USST03")) return null;
        return memberVO;
    }

    @Override
    public boolean register(MemberVO vo) {
        return mapper.insert(vo) == 1;
    }

    @Override
    public boolean modify(MemberVO vo) {
        return mapper.update(vo) == 1;
    }

    @Override
    public boolean remove(String id) {
        return mapper.delete(id) == 1;
    }

    @Override
    public List<MemberVO> getlist() {
        return mapper.getlist();
    }

    @Override
    public boolean checkIdPw(MemberVO vo) {
        MemberVO memberVO = mapper.read(vo.getId());
        return memberVO != null ? memberVO.getPassword().equals(vo.getPassword()) : false;
    }

    @Override
    public boolean registerHistory(MemberVO vo, String updUserId, String description) {
        return false;
    }

    void change(MemberHistoryVO vo, String mtr, Object o1, Object o2){
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
//            memberHistoryMapper.insert(vo);
        }

    }
}
