package com.dfmy.dao.device;

import com.dfmy.entity.device.AtiDevice;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface AtiDeviceDao extends PagingAndSortingRepository<AtiDevice, String>,
        JpaSpecificationExecutor<AtiDevice> {
}
