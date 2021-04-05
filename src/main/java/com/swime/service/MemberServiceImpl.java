package com.swime.service;

import com.swime.domain.GroupVO;
import com.swime.domain.MemberVO;
import com.swime.mapper.GroupMapper;
import com.swime.mapper.MemberMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService{

    private MemberMapper mapper;


    @Override
    public MemberVO get(String id) {
        return mapper.read(id);
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
}
