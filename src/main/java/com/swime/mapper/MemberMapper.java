package com.swime.mapper;


import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MemberMapper {

    MemberVO read(String id);

    int insert(MemberVO vo);

    int update(MemberVO vo);

    int delete(String id);

    List<MemberVO> getlist();

    int registerHistory(MemberHistoryVO vo);

    List<MemberHistoryVO> getHistory(String id);

    int insertKey(@Param("id") String id,@Param("key") String key);

}
