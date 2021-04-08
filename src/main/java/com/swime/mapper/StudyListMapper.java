package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyListVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudyListMapper {
    public List<StudyListVO> getList();

    public List<StudyListVO> getListWithPaging(StudyCriteria cri);

    // 해당 스터디, 해당 회원의 참여 명단을 가져오기
    public StudyListVO getAttendant(@Param("stdSn") long stdSn, @Param("userId") String userId);

    public int insert(StudyListVO attendant);

    //삭제도 status update로 처리
    public int update(@Param("stdSn") long stdSn, @Param("userId") String userId, @Param("status") String status);

    // 참여인원 세기
    public int count(long stdSn);
}
