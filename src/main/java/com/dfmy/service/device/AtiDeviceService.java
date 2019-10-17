package com.dfmy.service.device;

import com.dfmy.entity.device.AtiDevice;
import org.springframework.data.domain.Page;

public interface AtiDeviceService {


    Page<AtiDevice> pageList(int pageNumber, int pageSize, String sortColom, final AtiDevice atiDevice);

    AtiDevice saveAtiDevice(AtiDevice atiProject);

    AtiDevice findAtiDeviceById(String id);

    void deleteAtiDevice(String id);
}
