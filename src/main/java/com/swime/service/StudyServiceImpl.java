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
        StudyListVO attendant = new StudyListVO();
        attendant.setStdSn(study.getSn());
        attendant.setUserId(study.getRepresentation());
        attendant.setStatus("STUS01");

        cnt += listMapper.insert(attendant);

        return cnt; // 2여야함
    }

//    @Override
//    public int register(StudyVO study) {
//        log.info("register........." + study);
//        return mapper.insertSelectKey(study);
//    }

    @Override
    public StudyVO get(Long sn) {

        return mapper.read(sn);
    }

    @Override
    public int modify(StudyVO study) {

        return mapper.update(study);
    }

    @Override
    public int remove(Long sn) {

        return mapper.delete(sn);
    }

    @Override
    public List<StudyVO> getList() {

        return mapper.getList();
    }

    @Override
    public List<StudyVO> getList(StudyCriteria cri) {

        return mapper.getListWithPaging(cri);
    }

    //WishStudy
    @Override
    public List<StudyVO> getWishList(StudyCriteria cri) {
        return WishMapper.getList(cri);
    }

    @Override
    public int registerWish(WishStudyVO wish) {
        return WishMapper.insert(wish);
    }

    @Override
    public int removeWish(Long stdSn, String userId) {
        return WishMapper.delete(stdSn, userId);
    }

    // StudyList
    @Override
    public List<StudyListVO> getAttendantList() {
        return listMapper.getList();
    }

    @Override
    public List<StudyListVO> getAttendantList(StudyCriteria cri) {
        return listMapper.getListWithPaging(cri);
    }

    @Override
    public int registerAttendant(StudyListVO attendant) {
        return listMapper.insert(attendant);
    }

    @Override
    public int modifyAttendant(long stdSn, String userId, String status) {
        return listMapper.update(stdSn, userId, status);
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
    public List<StudyAnswerVO> getAnswer(long stdSn, String userId) {
        return answerMapper.get(stdSn, userId);
    }

    //StudyAnswer
    // Tx: 설문 답변 후 참가명단에 insert
    @Transactional
    @Override
    public int registerAnswer(StudyAnswerVO answer) {
        int cnt = 0;

        //1. 답변을 등록한다.
        cnt += answerMapper.insert(answer);

        long stdSn = answer.getStdSn();
        String userId = answer.getUserId();

        //2. 참여명단에 해당스터디번호와 해당 user_id를 가진 레코드가 있는지 확인한다.
        //2-1. 레코드가 존재하며, 가입/탈퇴/검토중/영구강퇴 중에 상태가 탈퇴인 경우만 update가능
        StudyListVO attendant = listMapper.getAttendant(stdSn, userId);

        if(attendant != null){
            if(!"STUS02".equals(attendant.getStatus())) return -1;

            return listMapper.update(stdSn, userId, "STUS01");
        }

        //3. 참여명단에 레코드가 존재하지 않으면
        // 답변객체로부터 std_sn, user_id 받고 status = STUS03(검토중)으로 설정해서 참여명단에 insert
        StudyListVO newAttendant = new StudyListVO();
        newAttendant.setStdSn(stdSn);
        newAttendant.setUserId(userId);
        newAttendant.setStatus("STUS03");

        cnt += listMapper.insert(newAttendant);
        
        return cnt; // 정상적으로 완료될 경우 결과값이 2여야함
    }

//    @Override
//    public int registerAnswer(StudyAnswerVO answer) {
//        return answerMapper.insert(answer);
//    }

    @Override
    public int removeAnswer(long stdSn, String userId) {
        return answerMapper.delete(stdSn, userId);
    }


}
