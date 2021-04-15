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
    public List<StudyVO> getList() {
        return mapper.getList();
    }

    @Override
    public List<StudyVO> getList(StudyCriteria cri) {
//        return mapper.getListWithPaging(cri);
        List<StudyVO> list = mapper.getListWithPaging(cri);

        list.forEach(study -> study.setAttendants(listMapper.count(study.getSn())));

        return list;
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

        //1. 답변을 등록한다.
        cnt += answerMapper.insert(answer);

        StudyParamVO param = new StudyParamVO();
        param.setStdSn(answer.getStdSn());
        param.setUserId(answer.getUserId());

        //2. 참여명단에 해당스터디번호와 해당 user_id를 가진 레코드가 있는지 확인한다.
        //2-1. 레코드가 존재하며, 가입/탈퇴/검토중/영구강퇴 중에 상태가 탈퇴인 경우만 update가능
        StudyListVO attendant = listMapper.getAttendant(param);
        param.setStatus("STUS03");

        if(attendant != null){
            if(!"STUS02".equals(attendant.getStatus())) return -1;

            cnt += listMapper.update(param);
            return cnt;
        }

        //3. 참여명단에 레코드가 존재하지 않으면
        // 답변객체로부터 std_sn, user_id 받고 status = STUS03(검토중)으로 설정해서 참여명단에 insert
        cnt += listMapper.insert(param);

        return cnt; // 정상적으로 완료될 경우 결과값이 2여야함
    }

    @Override
    public int removeAnswer(StudyParamVO param) {
        return answerMapper.delete(param);
    }
}
