package com.swime.service;

import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupRatingPageDTO;
import com.swime.domain.GroupRatingVO;
import com.swime.domain.GroupVO;
import com.swime.mapper.GroupMapper;
import com.swime.mapper.GroupRatingMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class GroupRatingServiceImpl implements GroupRatingService{

    private GroupRatingMapper groupRatingMapper;
    private GroupMapper groupMapper;

    @Transactional
    @Override
    public int register(GroupRatingVO groupRating) {
        // 해당 후기를 등록한다.
        groupRatingMapper.insert(groupRating);

        // grpSn 구해서 update 한다.
        updateGroupRating(groupRating.getGrpSn());

        return 1;
    }

    @Override
    public GroupRatingVO get(Long sn) {
        return groupRatingMapper.read(sn);
    }

    @Transactional
    @Override
    public List<GroupRatingVO> getListWithPaging(Long grpSn, GroupCriteria cri) {
        return groupRatingMapper.getListWithPaging(grpSn, cri);
    }

    @Override
    public GroupRatingPageDTO getListPage(GroupCriteria cri, Long grpSn) {

        return new GroupRatingPageDTO(groupRatingMapper.getRatingCountByGrpSn(grpSn), groupRatingMapper.getListWithPaging(grpSn, cri));
    }

    @Transactional
    @Override
    public int modify(GroupRatingVO groupRating) {

        // 해당 후기 update
        groupRatingMapper.update(groupRating);

        // grpSn 구해서 update 한다.
        updateGroupRating(groupRating.getGrpSn());

        return 1;
    }

    @Transactional
    @Override
    public int delete(Long sn) {
        Long grpSn = groupRatingMapper.getGrpSnBySn(sn);

        // 해당 후기 삭제
        int result = groupRatingMapper.delete(sn);

        // grpSn 구해서 update 한다.
        updateGroupRating(grpSn);

        return result;
    }

    private void updateGroupRating(Long grpSn) {

        GroupVO group = groupMapper.read(grpSn);

        if(group == null) {
            return;
        }

        log.info(">>>>>>>>>>>>>>>>>group: " + group);

        // 그 가져온놈의 rating을 평균을 가져와서 set한다.
        group.setRating(groupRatingMapper.getRatingByGrpSn(grpSn));
        // 그 가져온놈의 rating의 개수를 가져와서 set한다.
        group.setRatingCount(groupRatingMapper.getRatingCountByGrpSn(grpSn));
        // 그 가져온놈들을 update
        groupMapper.update(group);
    }
}
