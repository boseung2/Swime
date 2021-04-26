package com.swime.service;

import com.swime.domain.GroupVO;
import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
import com.swime.domain.ProfileCriteria;
import com.swime.mapper.MemberMapper;
import com.swime.mapper.ProfileMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Log4j
@Service
//@AllArgsConstructor
public class ProfileServiceImpl implements ProfileService{

    @Setter(onMethod_ = @Autowired)
    private ProfileMapper mapper;

    @Override
    public List<GroupVO> getOwnerGroupList(String id) {
        return mapper.ownerList(id);
    }

    @Override
    public GroupVO read(Long sn, String id) {
        return mapper.read(sn, id);
    }

    @Override
    public List<GroupVO> getJoinGroupList(String id) {
        return mapper.joinList(id);
    }

    @Override
    public List<GroupVO> getWishGroupList(String id) {
        return mapper.wishList(id);
    }

    @Override
    public List<GroupVO> joinListWithPaging(String id, ProfileCriteria cri) {
        return mapper.joinListWithPaging(id, cri);
    }
}

