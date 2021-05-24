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
    private StudyListMapper listMapper;

    @Setter(onMethod_ = @Autowired)
    private StudySurveyMapper surveyMapper;

    //Tx : 스터디 생성 -> 참가명단에 스터디장 insert
    @Transactional
    @Override
    public void register(StudyVO study, List<String> qList) {

        //1. 스터디를 insert한다.
        log.info("register study..................." + study);
        mapper.insertSelectKey(study);

        // 2. 설문이 있으면 등록한다.
        if(qList.size() > 0) {

            int order = 1;
            long stdSn = study.getSn();

            // 질문이 있으면 surveyVO 객체만들어서 등록해주기
            for(int i = 0; i < qList.size(); i++) {

                if(!"".equals(qList.get(i))) {
                    StudySurveyVO survey= new StudySurveyVO();
                    survey.setStdSn(stdSn);
                    survey.setQuestionSn(order++);
                    survey.setQuestion(qList.get(i));

                    surveyMapper.insert(survey);
                }
            }
        }

        // 3. 만들어진 스터디의 번호, 스터디장 id, 가입상태(무조건 STUS01)를 참여명단 객체에 저장
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(study.getSn());
        param.setUserId(study.getRepresentation());
        param.setStatus("STUS01");

        listMapper.insert(param);

    }

    // 스터디정보와 참여인원 정보 같이 얻어오기
    @Override
    public StudyVO get(Long sn) {

        StudyVO study = mapper.get(sn);
        if(study != null) study.setAttendants(listMapper.count(sn));

        return study;
    }

    // 스터디 내용 수정
    @Transactional
    @Override
    public void modify(StudyVO study, List<String> qList) {

        // 스터디 수정
        mapper.update(study);

        // 스터디 설문 삭제
        surveyMapper.delete(study.getSn());

        // 들어온 설문이 있으면 설문 새로 등록
        if(qList.size() > 0) {

            int order = 1;
            long stdSn = study.getSn();

            // 질문이 있으면 surveyVO 객체만들어서 등록해주기
            for(int i = 0; i < qList.size(); i++) {

                if(!"".equals(qList.get(i))) {
                    StudySurveyVO survey= new StudySurveyVO();
                    survey.setStdSn(stdSn);
                    survey.setQuestionSn(order++);
                    survey.setQuestion(qList.get(i));

                    surveyMapper.insert(survey);
                }
            }
        }

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
    public GroupStudyListDTO getPastList(StudyCriteria cri, long grpSn) {
        GroupStudyListDTO groupStudyList = new GroupStudyListDTO();
        groupStudyList.setList(mapper.getPastListWithPaging(cri, grpSn));
        groupStudyList.setCount(mapper.countPastStudy(grpSn));

        groupStudyList.getList().forEach(study -> study.setAttendants(listMapper.count(study.getSn())));

        return groupStudyList;
    }

    @Override
    public int countStudy(long grpSn) {
        return mapper.countStudy(grpSn);
    }

}
