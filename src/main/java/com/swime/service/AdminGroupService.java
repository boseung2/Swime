package com.swime.service;

import com.swime.domain.AdminGroupCriteria;
import com.swime.domain.AdminGroupPageDTO;

public interface AdminGroupService {

    AdminGroupPageDTO adminGetGroupListWithPagingBySn(AdminGroupCriteria cri);


}
