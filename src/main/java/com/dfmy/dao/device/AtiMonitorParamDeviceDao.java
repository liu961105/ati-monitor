package com.dfmy.dao.device;

import com.dfmy.entity.device.AtiMonitorParamDevice;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.List;
import java.util.Map;

public interface AtiMonitorParamDeviceDao extends PagingAndSortingRepository<AtiMonitorParamDevice, String>,
        JpaSpecificationExecutor<AtiMonitorParamDevice> {

    /**
     * 根据设备id删除
     * @param deviceId
     */
    @Modifying
    @Query("delete from AtiMonitorParamDevice where deviceId = :deviceId")
    void deleteByDeviceId(@Param("deviceId") String deviceId);

    @Modifying
    @Query("delete from AtiMonitorParamDevice where paramId not in (:paramIds) and deviceId = :deviceId")
    void deleteByNotInParamIdsAndDeviceId(@Param("paramIds") Collection<String> paramIds,@Param("deviceId") String deviceId);

    List<AtiMonitorParamDevice> findAllByDeviceId(String deviceId);
    
    List<AtiMonitorParamDevice> findByParamId(String paramId);
}
