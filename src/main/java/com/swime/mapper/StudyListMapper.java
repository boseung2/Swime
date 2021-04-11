package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyListVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudyListMapper {
    public List<StudyListVO> getList(long stdSn);

    public List<StudyListVO> getListWithPaging(StudyCriteria cri);

    public List<StudyListVO> getWaitingList(long stdSn);

    public List<StudyListVO> getWaitingListWithPaging(StudyCriteria cri);

    // 해당 스터디, 해당 회원의 참여 정보를 가져오기
    public StudyListVO getAttendant(@Param("stdSn") long stdSn, @Param("userId") String userId);

    public int insert(StudyListVO attendant);

    // status : 가입/탈퇴/검토중/영구강퇴
    public int update(@Param("stdSn") long stdSn, @Param("userId") String userId, @Param("status") String status);

    // 스터디 참여인원 세기
    public int count(long stdSn);
}
