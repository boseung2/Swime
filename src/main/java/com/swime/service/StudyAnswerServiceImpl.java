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
public class StudyAnswerServiceImpl implements StudyAnswerService{

    @Setter(onMethod_ = @Autowired)
    private StudyListMapper listMapper;

    @Setter(onMethod_ = @Autowired)
    private StudyAnswerMapper answerMapper;

    // 답변 가져오기
    @Override
    public List<StudyAnswerVO> getAnswer(StudyParamVO param) {
        return answerMapper.get(param);
    }

    // Tx: 설문 답변 후 참가명단에 insert
    @Transactional
    @Override
    public void registerAnswers(List<StudyAnswerVO> answers) {

        StudyParamVO param = new StudyParamVO();
        param.setStdSn(answers.get(0).getStdSn());
        param.setUserId(answers.get(0).getUserId());

        // 1. 해당유저의 참여상태를 확인
        int check = checkAttendantForRegister(param);

        // 가입상태 : 가입/검토중/영구강퇴는 return
        if (check == -1) return;

        //2. 답변들을 모두 등록한다.
        for(int i = 0; i < answers.size(); i++) {
            answerMapper.insert(answers.get(i));
        }

        // 설문 답변 등록 후에 상태는 무조건 검토중
        param.setStatus("STUS03");

        // 참여명단에 검토중으로 넣는다.
        if (check == 1) {
            // 가입상태 : 미가입
            listMapper.insert(param);
        } else {
            // 가입상태 : 탈퇴
            listMapper.update(param);
        }
        
    }

    @Override
    public int removeAnswer(StudyParamVO param) {
        return answerMapper.delete(param);
    }

    // 등록을 위해 해당 스터디의 유저 가입상태를 확인해주는 함수
    public int checkAttendantForRegister(StudyParamVO studyParam) {
        StudyListVO attendant = listMapper.getAttendant(studyParam);

        //참여명단에 레코드가 존재하지 않는 경우 1 반환 -> insert
        if(attendant == null) return 1;

        // 참여명단에 유저가 존재하며 상태가 탈퇴인 경우 2 반환 -> update
        // 참여명단에 유저가 존재하며 상태가 가입/검토중/영구탈퇴인 경우  -1 반환 -> 아무일도 안함
        return ("STUS02".equals(attendant.getStatus()) ? 2 : -1);
    }
}
