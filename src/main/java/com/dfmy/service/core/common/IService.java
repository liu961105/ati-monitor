package com.dfmy.service.core.common;

import java.util.List;
import java.util.Map;

/**
 * 服务层底层接口
 * @author wang
 */
public interface IService {
	public String saveObject(String objectId, Map<String,Object> requestVal)throws Exception;

}
