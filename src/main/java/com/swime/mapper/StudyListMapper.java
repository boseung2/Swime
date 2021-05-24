package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyListVO;
import com.swime.domain.StudyParamVO;
import com.swime.domain.StudyVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudyListMapper {
    // 참여멤버/ 대기멤버 불러오기
    public List<StudyListVO> getList(StudyParamVO param);

    public List<StudyListVO> getListWithPaging(@Param("cri") StudyCriteria cri, @Param("param") StudyParamVO param);

    // 해당 스터디, 해당 회원의 참여 정보를 가져오기
    public StudyListVO getAttendant(StudyParamVO param);

    public List<StudyVO> getStudiesOfGroup(@Param("grpSn")long grpSn, @Param("userId")String userId);

    public List<StudyVO> getNoRatingStudies(@Param("grpSn")long grpSn, @Param("userId")String userId);

    // 등록 : 사용자 가입/검토
    public int insert(StudyParamVO param);

    // 수정 : 가입/탈퇴/영구강퇴
    public int update(StudyParamVO param);
    
    // 삭제 : 해당 사용자를 명단에서 삭제
    public int delete(StudyParamVO param);

    // 스터디 참여인원 세기
    public int count(long stdSn);
}
