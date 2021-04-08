package com.swime.mapper;


import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MemberMapper {

    //가입처리
    MemberVO read(String id);

    int insert(MemberVO vo);

    int update(MemberVO vo);

    int delete(String id);

    List<MemberVO> getlist();

    //이력관리
    int registerHistory(MemberHistoryVO vo);

    List<MemberHistoryVO> getHistory(String id);

    //인증처리
    int insertKey(@Param("id") String id, @Param("key") String key);

    String selectKey(@Param("id") String id, @Param("key") String key);

    int deleteKey(String id);

}
