package com.swime.service;

import com.swime.domain.*;
import com.swime.mapper.*;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.acl.Group;
import java.util.List;

@Log4j
@Service
public class StudyServiceImpl implements StudyService{

    @Setter(onMethod_ = @Autowired)
    private StudyMapper mapper;

    @Setter(onMethod_ = @Autowired)
    private WishStudyMapper WishMapper;

    @Setter(onMethod_ = @Autowired)
    private StudyListMapper listMapper;

    @Setter(onMethod_ = @Autowired)
    private StudySurveyMapper surveyMapper;

    @Setter(onMethod_ = @Autowired)
    private StudyAnswerMapper answerMapper;

    //Tx : 스터디 생성 -> 참가명단에 스터디장 insert
    @Transactional
    @Override
    public int register(StudyVO study) {
        int cnt = 0;

        //1. 스터디를 insert한다.
        log.info("register study..................." + study);
        cnt += mapper.insertSelectKey(study);

        log.info("---------------------------------만들어진 스터디번호 : " + study.getSn());

        // 만들어진 스터디의 번호, 스터디장 id, 가입상태(무조건 STUS01)를 참여명단 객체에 저장
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(study.getSn());
        param.setUserId(study.getRepresentation());
        param.setStatus("STUS01");

        cnt += listMapper.insert(param);

        assert (cnt == 2);
        return cnt;
    }

    // 스터디정보와 참여인원 정보 같이 얻어오기
    @Override
    public StudyVO get(Long sn) {

        StudyVO study = mapper.get(sn);
        if(study != null) study.setAttendants(listMapper.count(sn));

        return study;
    }

    // 스터디 내용 수정
    @Override
    public int modify(StudyVO study) {
        return mapper.update(study);
    }

    // 스터디 참가 모집 마감
    @Override
    public int endStudy(StudyParamVO param) {
        param.setStatus("STST03");
        return mapper.updateStatus(param);
    }

    // 스터디 삭제
    @Override
    public int remove(StudyParamVO param) {
        param.setStatus("STST02");
        return mapper.updateStatus(param);
    }

    @Override
    public List<StudyVO> getList(long grpSn) {
        return mapper.getList(grpSn);
    }

    @Override
    public GroupStudyListDTO getList(StudyCriteria cri, long grpSn) {
        GroupStudyListDTO groupStudyList = new GroupStudyListDTO();
        groupStudyList.setList(mapper.getListWithPaging(cri, grpSn));
        groupStudyList.setCount(mapper.countStudy(grpSn));

        groupStudyList.getList().forEach(study -> study.setAttendants(listMapper.count(study.getSn())));

        return groupStudyList;
    }

    @Override
    public int countStudy(long grpSn) {
        return mapper.countStudy(grpSn);
    }

    //WishStudy
    @Override
    public List<StudyVO> getWishList(StudyCriteria cri, String userId) {
        return WishMapper.getList(cri, userId);
    }

    @Override
    public WishStudyVO getWish(StudyParamVO param) {
        return WishMapper.get(param);
    }

    @Override
    public int registerWish(WishStudyVO wish) {
        return WishMapper.insert(wish);
    }

    @Override
    public int removeWish(StudyParamVO param) {
        return WishMapper.delete(param);
    }

    // StudyList
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

    @Override
    public List<StudyListVO> getWaitingList(long stdSn) {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(stdSn);
        param.setStatus("STUS03");
        return listMapper.getList(param);
    }

    @Override
    public List<StudyListVO> getWaitingList(StudyCriteria cri, long stdSn) {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(stdSn);
        param.setStatus("STUS03");
        return listMapper.getListWithPaging(cri, param);
    }

    @Override
    public StudyListVO getAttendant(StudyParamVO param) {
        return listMapper.getAttendant(param);
    }

    @Override
    public List<StudyVO> getStudiesOfGroup(long grpSn, String userId) {
        return listMapper.getStudiesOfGroup(grpSn, userId);
    }

    @Override
    public int registerAttendant(StudyParamVO param) {
        return listMapper.insert(param);
    }

    @Override
    public int modifyAttendant(StudyParamVO param) {
        return listMapper.update(param);
    }

    @Override
    public int countAttendants(long stdSn) {
        return listMapper.count(stdSn);
    }

    //StudySurvey
    @Override
    public List<StudySurveyVO> getSurveyList(long stdSn) {
        return surveyMapper.getList(stdSn);
    }

    @Override
    public int registerSurvey(StudySurveyVO survey) {
        return surveyMapper.insert(survey);
    }

    @Override
    public int removeSurvey(long stdSn) {
        return surveyMapper.delete(stdSn);
    }

    @Override
    public List<StudyAnswerVO> getAnswer(StudyParamVO param) {
        return answerMapper.get(param);
    }

    //StudyAnswer
    // Tx: 설문 답변 후 참가명단에 insert
    @Transactional
    @Override
    public int registerAnswer(StudyAnswerVO answer) {
        int cnt = 0;

        StudyParamVO param = new StudyParamVO();
        param.setStdSn(answer.getStdSn());
        param.setUserId(answer.getUserId());
        
        // 설문 답변 등록 후에 상태는 검토중이어야하므로
        param.setStatus("STUS03");

        // 1. 해당유저의 참여상태를 확인
        int check = checkAttendantForRegister(param);
        
        // 가입상태 : 가입/검토중/영구강퇴
        if (check == -1) return -1;

        //2. 답변을 등록한다.
        cnt += answerMapper.insert(answer);
        
        // 참여명단에 없음
        if (check == 1) {
            cnt += listMapper.insert(param);
        } else {
            // 가입상태 : 탈퇴
            cnt += listMapper.update(param);
        }

        return cnt; // 정상적으로 등록될 경우 결과값이 2여야함
    }

    // 등록을 위해 해당 스터디의 유저 가입상태를 확인해주는 함수
    @Override
    public int checkAttendantForRegister(StudyParamVO studyParam) {
        StudyListVO attendant = listMapper.getAttendant(studyParam);

        //참여명단에 레코드가 존재하지 않는 경우 1 반환 -> insert
        if(attendant == null) return 1;

        // 참여명단에 유저가 존재하며 상태가 탈퇴인 경우 2 반환 -> update
        // 참여명단에 유저가 존재하며 상태가 가입/검토중/영구탈퇴인 경우  -1 반환 -> 아무일도 안함
        return ("STUS02".equals(attendant.getStatus()) ? 2 : -1);
    }

    // 탈퇴를 위해 해당 스터디의 유저 가입상태를 확인해주는 함수
    @Override
    public int checkAttendantForRemove(StudyParamVO studyParam) {
        StudyListVO attendant = listMapper.getAttendant(studyParam);

        if(attendant == null) return -1;

        // 참여명단에 유저가 존재하며 가입상태인 경우 : 1 반환
        // 참여명단에 유저가 존재하며 검토중인 경우 : 2 반환
        // 그 외 : -1
        return ("STUS01".equals(attendant.getStatus()) ? 1 : "STUS03".equals(attendant.getStatus())? 2 : -1);
    }

    @Override
    public int removeAnswer(StudyParamVO param) {
        return answerMapper.delete(param);
    }
}
