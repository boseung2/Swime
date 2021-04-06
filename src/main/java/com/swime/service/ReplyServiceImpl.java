package com.swime.service;

import com.swime.domain.ReplyVO;
import com.swime.mapper.ReplyMapper;
import jdk.nashorn.internal.objects.annotations.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService{

    private ReplyMapper mapper;

    @Override
    public int register(ReplyVO vo) {

        log.info("register: " + vo);
        return mapper.insert(vo);
    }

    @Override
    public ReplyVO get(Long sn) {

        log.info("get: " + sn);
        return mapper.read(sn);
    }

    @Override
    public int modify(ReplyVO vo) {

        log.info("modify" + vo);
        return mapper.update(vo);
    }

    @Override
    public int remove(Long sn) {

        log.info("remove" + sn);
        return mapper.delete(sn);
    }

    //*페이징처리*
    //public List.....
}
