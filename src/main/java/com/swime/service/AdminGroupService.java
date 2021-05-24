package com.swime.service;

import com.swime.domain.AdminGroupCriteria;
import com.swime.domain.AdminGroupPageDTO;

public interface AdminGroupService {

    //어드민 모임 리스트 페이징
    AdminGroupPageDTO adminGetGroupListWithPagingBySn(AdminGroupCriteria cri);

    //어드민 모임 삭제
    int adminGroupRemove(Long sn);

}
