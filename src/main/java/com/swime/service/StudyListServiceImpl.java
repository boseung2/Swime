package com.swime.service;

import com.swime.domain.*;
import com.swime.mapper.*;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j
@Service
public class StudyListServiceImpl implements StudyListService{

    @Setter(onMethod_ = @Autowired)
    private StudyListMapper listMapper;
//
    @Setter(onMethod_ = @Autowired)
    private StudyAnswerMapper answerMapper;

    // 참여멤버 반환
    @Override
    public List<StudyListVO> getAttendantList(long stdSn) {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(stdSn);
        param.setStatus("STUS01");

        return listMapper.getList(param);
    }

    // 참여멤버 페이징처리
    @Override
    public List<StudyListVO> getAttendantList(StudyCriteria cri, long stdSn) {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(stdSn);
        param.setStatus("STUS01");

        return listMapper.getListWithPaging(cri, param);
    }

    // 대기멤버 반환
    @Override
    public List<StudyListVO> getWaitingList(long stdSn) {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(stdSn);
        param.setStatus("STUS03");
        return listMapper.getList(param);
    }

    // 대기멤버 페이징처리
    @Override
    public List<StudyListVO> getWaitingList(StudyCriteria cri, long stdSn) {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(stdSn);
        param.setStatus("STUS03");

        return listMapper.getListWithPaging(cri, param);
    }

    // 영구강퇴 멤버 반환
    @Override
    public List<StudyListVO> getBanList(long stdSn) {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(stdSn);
        param.setStatus("STUS04");

        return listMapper.getList(param);
    }

    // 사용자의 참여정보 반환
    @Override
    public StudyListVO getAttendant(StudyParamVO param) {
        return listMapper.getAttendant(param);
    }

    // 사용자가 해당 그룹에서 참여한 스터디를 모두 반환
    @Override
    public List<StudyVO> getStudiesOfGroup(long grpSn, String userId) {
        return listMapper.getStudiesOfGroup(grpSn, userId);
    }

    @Override
    public List<StudyVO> getNoRatingStudies(long grpSn, String userId) {
        return listMapper.getNoRatingStudies(grpSn, userId);
    }

    // 참석
    @Override
    public int registerAttendant(StudyParamVO param) {
        return listMapper.insert(param);
    }

    // 참가상태 변경
    @Override
    public int modifyAttendant(StudyParamVO param) {
        return listMapper.update(param);
    }

    // 스터디 참여명단에서 삭제하고 해당 스터디에 해당 유저의 설문답변이 남아있으면 지운다.
    @Transactional
    @Override
    public int removeAttendant(StudyParamVO param) {

        int cnt = 0;

        // 해당 유저를 해당스터디 참여명단에서 삭제한다.
        cnt += listMapper.delete(param);

        // 해당 스터디에 해당 유저의 설문 답변이 있으면 삭제한다.
        List<StudyAnswerVO> answers = answerMapper.get(param);

        if (answers.size() > 0) {
            answerMapper.delete(param);
        }

        return cnt;
    }

    @Override
    public int countAttendants(long stdSn) {
        return listMapper.count(stdSn);
    }
}
