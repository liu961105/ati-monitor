
package com.dfmy.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.druid.sql.ast.statement.SQLIfStatement.Else;
import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.basedata.AtiMonitorParam;
import com.dfmy.entity.basedata.EmailService;
import com.dfmy.entity.device.AtiDevice;
import com.dfmy.entity.device.AtiDeviceDataRecord;
import com.dfmy.entity.device.AtiDeviceDataRecordHistory;
import com.dfmy.entity.device.AtiProjectMonitorSites;
import com.dfmy.entity.project.AtiProject;
import com.dfmy.entity.sys.SysUser;
import com.dfmy.service.basedata.AtiMonitorParamService;
import com.dfmy.service.basedata.EmailServiceService;
import com.dfmy.service.device.AtiDeviceDataRecordHistoryService;
import com.dfmy.service.device.AtiDeviceDataRecordService;
import com.dfmy.service.device.AtiDeviceService;
import com.dfmy.service.device.AtiProjectMonitorSitesService;
import com.dfmy.service.project.AtiProjectService;
import com.dfmy.service.sys.SysUserService;
import com.dfmy.util.MailUtil;
import com.dfmy.util.SendEmailUtils;

@RestController
@RequestMapping(value = "/dataTransfer", produces = "application/json;charset=utf-8")
public class DataTransferController extends BaseController {

	@Autowired
	private AtiProjectService atiProjectService;
	@Autowired
	private AtiMonitorParamService atiMonitorParamService;
	@Autowired
	private AtiDeviceService atiDeviceService;
	@Autowired
	private AtiProjectMonitorSitesService atiProjectMonitorSitesService;
	@Autowired
	private AtiDeviceDataRecordService atiDeviceDataRecordService;
	@Autowired
	private AtiDeviceDataRecordHistoryService atiDeviceDataRecordHistoryService;
	@Autowired
	private EmailServiceService emailserviceService;
	@Autowired
	private SysUserService sysUserService;

	@RequestMapping("/addhydrodata")
	public ResultEntity addhydrodata(String projectId, String monitorParamId, String deviceId, String channelid,
			String monitorSiteId, String uploadVal,String unit, String uploadVal2,String unit2, String uploadTime, String temp, String isGroup,
			String fft, String fftSize, String dataSize, String sampleRate, HttpServletRequest request,
			HttpServletResponse response) {
		ResultEntity res = new ResultEntity();
		try {
			unit = StringUtils.isNotBlank(unit)?unit:"";
			unit2 = StringUtils.isNotBlank(unit2)?unit2:"";
			// 项目名：实时数据测试项目（勿删）
			/*
			 * projectId = "402881eb6b9cb274016b9cc6579b0001"; monitorParamId =
			 * "40289f756b8c99cf016b8cb233d30005"; deviceId = ""; monitorSiteId
			 * = "";
			 */
			AtiProject project = atiProjectService.findProjectById(projectId);
			AtiMonitorParam monitorParam = atiMonitorParamService.findById(monitorParamId);
			AtiDevice device = atiDeviceService.findAtiDeviceById(deviceId);
			AtiProjectMonitorSites monitorSites = atiProjectMonitorSitesService.findMonitorById(monitorSiteId);

			if (project == null) {
				res.setSuccess(ERROR);
				res.setMessage("项目获取失败，id:"+projectId);
				System.out.println("项目获取失败，id:"+projectId);
			} else if (monitorParam == null){
				res.setSuccess(ERROR);
				res.setMessage("监测参数获取失败，id:"+monitorParamId);
				System.out.println("监测参数获取失败，id:"+monitorParamId);
			} else if (device == null){
				res.setSuccess(ERROR);
				res.setMessage("设备获取失败，id:"+deviceId);
				System.out.println("设备获取失败，id:"+deviceId);
			}  else if (monitorSites == null){
				res.setSuccess(ERROR);
				res.setMessage("监测点位获取失败，id:"+monitorSiteId);
				System.out.println("监测点位获取失败，id:"+monitorSiteId);
			} else {
				//获取预警值
				double yellowVal = monitorSites.getOneWarnLevel()==null?0:monitorSites.getOneWarnLevel();
				double orangeVal = monitorSites.getTwoWarnLevel()==null?0:monitorSites.getTwoWarnLevel();
				double redVal = monitorSites.getTreeWarnLevel()==null?0:monitorSites.getTreeWarnLevel();
				
				// 历史数据沉淀
				AtiDeviceDataRecordHistory dataRecordHistory = new AtiDeviceDataRecordHistory();
				dataRecordHistory.setProjectId(projectId);
				dataRecordHistory.setProjectName(project.getProjectName());
				dataRecordHistory.setMonitorTypeId(monitorParam.getAtiMonitorItem().getAtiMonitorType().getId());
				dataRecordHistory.setMonitorTypeName(monitorParam.getAtiMonitorItem().getAtiMonitorType().getName());
				dataRecordHistory.setMonitorParamId(monitorParamId);
				dataRecordHistory.setMonitorParamName(monitorParam.getName());
				dataRecordHistory.setDeviceId(deviceId);
				dataRecordHistory.setDeviceCode(device.getDeviceCode());
				dataRecordHistory.setDeviceName(device.getDeviceName());
				dataRecordHistory.setMonitorSitesId(monitorSiteId);
				dataRecordHistory.setMonitorSitesName(monitorSites.getName());
				dataRecordHistory.setUnit(String.valueOf(unit));
				dataRecordHistory.setUnitSpare(unit2);
				dataRecordHistory.setChannelid(channelid);
				dataRecordHistory.setTemperature(temp);
				dataRecordHistory.setUploadTime(uploadTime);
				dataRecordHistory.setState("1");
				dataRecordHistory.setDealStatus("0");
				dataRecordHistory.setWarnMessage("黄："+yellowVal+";橙："+orangeVal+";红："+redVal);
				
				if ("1".equals(isGroup)) {
					dataRecordHistory.setIsGroup("1");
					dataRecordHistory.setGroupData(uploadVal);
					dataRecordHistory.setDeviceUploadData("");// 处理之后的数据
					dataRecordHistory.setDeviceUploadDataSpare("");
					dataRecordHistory.setRunningState("1");
					dataRecordHistory.setWarnLevel(0);
					dataRecordHistory.setFft(fft);
					dataRecordHistory.setFftSize(fftSize);
					dataRecordHistory.setDataSize(dataSize);
					dataRecordHistory.setSampleRate(sampleRate);
				} else {
					Integer warnLevel = getWarnLevel(uploadVal, yellowVal, orangeVal, redVal);
					if (warnLevel>0) {
						dataRecordHistory.setRunningState("2");
						project.setWarnCount(project.getWarnCount()+1);
						atiProjectService.save(project);
						List<EmailService> emailServices = emailserviceService.findByState("1");
						if (emailServices != null && emailServices.size() > 0) {
							String content = emailServices.get(0).getContent();
							content = content.replace("${projectName}", project.getProjectName());
							SysUser manager = sysUserService.findUser(project.getManagerId());
							
							//SendEmailUtils.sendMessage(emailServices.get(0).getServiceNum(), emailServices.get(0).getAuthorizationCode(), manager.getEmail(), "", "",emailServices.get(0).getSubject(), content, null);
							//SendEmailUtils.sendMessage("737404745@qq.com", "djaunmudilfqbcgg", "65551438@qq.com", "", "", "监测平台实时数据报警", "您管理的项目["+project.getProjectName()+"]出现数据异常报警，请及时登录系统进行查看", null);
							
							//邮箱发送
							/*String serviceNum = emailServices.get(0).getServiceNum();
							if (serviceNum.endsWith("qq.com")) {
								SendEmailUtils.sendMessage(serviceNum, emailServices.get(0).getAuthorizationCode(), manager.getEmail(), "", "",emailServices.get(0).getSubject(), content, null);
							} else if (serviceNum.endsWith("163.com")){
								MailUtil.testSendMail(serviceNum, emailServices.get(0).getAuthorizationCode(), manager.getEmail(), emailServices.get(0).getSubject(), content);
							}*/
							
						}
						
					} else {
						dataRecordHistory.setRunningState("1");
					}
					dataRecordHistory.setIsGroup("0");
					dataRecordHistory.setDeviceUploadData(uploadVal);
					dataRecordHistory.setDeviceUploadDataSpare(uploadVal2);
					dataRecordHistory.setWarnLevel(warnLevel);
				}

				atiDeviceDataRecordHistoryService.save(dataRecordHistory);

				// 最新数据更新
				AtiDeviceDataRecord deviceDataRecord = atiDeviceDataRecordService.findIsExist(deviceId, monitorParamId,
						monitorSiteId, projectId);
				if (deviceDataRecord != null) {
					if ("1".equals(isGroup)) {
						atiDeviceDataRecordService.updateNewData("","", uploadVal, fft, fftSize, dataSize, sampleRate, temp,"",0,"1","0",uploadTime, deviceId, monitorParamId, monitorSiteId, projectId);
					} else {
						Integer level = getWarnLevel(uploadVal, yellowVal, orangeVal, redVal);
						if (level > 0) {
							atiDeviceDataRecordService.updateNewData(uploadVal,unit, "", fft, fftSize, dataSize, sampleRate, temp,unit2,level,"2","0",uploadTime, deviceId, monitorParamId, monitorSiteId, projectId);
						} else {
							atiDeviceDataRecordService.updateNewData(uploadVal,unit, "", fft, fftSize, dataSize, sampleRate, temp,unit2,level,"1","0",uploadTime, deviceId, monitorParamId, monitorSiteId, projectId);
						}
					}
				} else {
					deviceDataRecord = new AtiDeviceDataRecord();
					deviceDataRecord.setProjectId(projectId);
					deviceDataRecord.setProjectName(project.getProjectName());
					deviceDataRecord.setMonitorTypeId(monitorParam.getAtiMonitorItem().getAtiMonitorType().getId());
					deviceDataRecord.setMonitorTypeName(monitorParam.getAtiMonitorItem().getAtiMonitorType().getName());
					deviceDataRecord.setMonitorParamId(monitorParamId);
					deviceDataRecord.setMonitorParamName(monitorParam.getName());
					deviceDataRecord.setDeviceId(deviceId);
					deviceDataRecord.setDeviceCode(device.getDeviceCode());
					deviceDataRecord.setDeviceName(device.getDeviceName());
					deviceDataRecord.setMonitorSitesId(monitorSiteId);
					deviceDataRecord.setMonitorSitesName(monitorSites.getName());
					deviceDataRecord.setUnit("℃1");
					deviceDataRecord.setUnitSpare(unit2);
					deviceDataRecord.setChannelid(channelid);
					deviceDataRecord.setTemperature(temp);
					deviceDataRecord.setUploadTime(uploadTime);
					deviceDataRecord.setState("1");
					deviceDataRecord.setDealStatus("0");
					deviceDataRecord.setWarnMessage("黄："+yellowVal+";橙："+orangeVal+";红："+redVal);
					
					if ("1".equals(isGroup)) {
						deviceDataRecord.setIsGroup("1");
						deviceDataRecord.setGroupData(uploadVal);
						deviceDataRecord.setDeviceUploadData("");
						deviceDataRecord.setDeviceUploadDataSpare("");
						deviceDataRecord.setRunningState("1");
						deviceDataRecord.setWarnLevel(0);
						deviceDataRecord.setFft(fft);
						deviceDataRecord.setFftSize(fftSize);
						deviceDataRecord.setDataSize(dataSize);
						deviceDataRecord.setSampleRate(sampleRate);
					} else {
						Integer warnLevel = getWarnLevel(uploadVal, yellowVal, orangeVal, redVal);
						if (warnLevel >0) {
							deviceDataRecord.setRunningState("2");
						} else {
							deviceDataRecord.setRunningState("1");
						}
						deviceDataRecord.setIsGroup("0");
						deviceDataRecord.setDeviceUploadData(uploadVal);
						deviceDataRecord.setDeviceUploadDataSpare(uploadVal2);
						deviceDataRecord.setWarnLevel(warnLevel);
					}

					atiDeviceDataRecordService.save(deviceDataRecord);
				}

				System.out.println("项目["+project.getProjectName()+"]监测参数["+monitorParam.getName()+"]监测点位["+monitorSites.getName()+"]数据上传成功");
				res.setSuccess(SUCCESS);
				res.setMessage(OPERATE_SUCCESS);
			}
			res.setSuccess(SUCCESS);
			res.setMessage(OPERATE_SUCCESS);
			return res;
		} catch (Exception e) {
			e.printStackTrace();
			res.setSuccess(ERROR);
			res.setMessage(OPERATE_ERROR + ":" + e.getMessage());
		}
		return res;
	}
	
	public Integer getWarnLevel(String uploadVal,Double yellowVal,Double orangeVal,Double redVal){
		Integer level = 0;
		if (StringUtils.isNotBlank(uploadVal)) {
			if (yellowVal != null && Math.abs(Double.parseDouble(uploadVal)) > yellowVal) {
				level = 1;
			}
			if (orangeVal != null && Math.abs(Double.parseDouble(uploadVal)) > orangeVal) {
				level = 2;
			}
			if (redVal != null && Math.abs(Double.parseDouble(uploadVal)) > redVal) {
				level = 3;
			}
		}
		return level;
	}

}
