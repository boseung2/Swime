package com.swime.service;

import com.swime.domain.AuthVO;
import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
import com.swime.mapper.AuthMapper;
import com.swime.mapper.MemberMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Log4j
@Service
//@AllArgsConstructor
public class AuthServiceImpl implements AuthService{

    @Setter(onMethod_ = @Autowired)
    private AuthMapper mapper;


    @Override
    public List<AuthVO> getList(String id) {
        return mapper.getList(id);
    }

    @Override
    public boolean register(String id, String auth) {
        return mapper.insert(id,auth) == 1;
    }

    @Override
    public boolean remove(String id) {
        return mapper.delete(id) > 0;
    }

    @Override
    public boolean removeAuth(String id, String auth) {
        return mapper.deleteAuth(id, auth) == 1;
    }

    @Override
    public AuthVO select(String id, String auth) {
        return mapper.select(id, auth);
    }

    @Override
    public boolean isAready(String id, String auth) {
        return mapper.select(id, auth) != null;
    }
}
