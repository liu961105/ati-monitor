package com.dfmy.controller.photo;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.dataProduct.ClhzData;
import com.dfmy.entity.device.AtiDeviceDataRecordHistory;
import com.dfmy.entity.project.AtiProject;
import com.dfmy.service.device.AtiDeviceDataRecordHistoryService;
import com.dfmy.service.modelexport.ModelExportService;
import com.dfmy.service.project.AtiProjectService;
import com.dfmy.util.FreeMarkerToWord;

/**
 * 数据生成
 * 
 * @author
 *
 */
@Controller
@RequestMapping("/dataReport")
public class DataReportController extends BaseController {
	@Resource
	private AtiDeviceDataRecordHistoryService atiDeviceDataRecordHistoryService;
	@Resource
	private AtiProjectService atiProjectService;
	@Autowired
	private ModelExportService modelExportService;
	
	
	/**
	 * 数据生成分页
	 * @param pageCurrent
	 * @param atiDeviceDataRecordHistory
	 * @param uploadTimeBegin
	 * @param uploadTimeEnd
	 * @param sortOrder
	 * @return
	 */
	@RequestMapping("/getableData")
	@ResponseBody
	public ResultEntity getTableData(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent, AtiDeviceDataRecordHistory atiDeviceDataRecordHistory,
			String uploadTimeBegin,String uploadTimeEnd,@RequestParam(value = "sortOrder", defaultValue = "uploadTime") String sortOrder){
		ResultEntity res = new ResultEntity();		
		try{   			   
			   Page<AtiDeviceDataRecordHistory> pageInfo = modelExportService.pageList(Integer.parseInt(pageCurrent), PAGESIZE, sortOrder, atiDeviceDataRecordHistory,uploadTimeBegin,uploadTimeEnd);
			   if (pageInfo.getTotalPages() > 0) {
	                res.setData(pageInfo);
	                res.setMessage(GET_SUCCESS);
	                res.setSuccess(SUCCESS);
	            } else {
	                res.setMessage(IS_NULL);
	                res.setSuccess(NULL);
	            }
		}catch (Exception e) {
			e.printStackTrace();		
			res.setSuccess(ERROR);
			}
		return res;
	}

	@RequestMapping("/dataDownload")
	@ResponseBody
	public String downLoadReport(String projectId, String monitorTypeId, String monitorParamId,String monitorSitesId,
		String uploadTimeBegin,String uploadTimeEnd,	HttpServletResponse response, HttpServletRequest request) throws IOException, Exception {
		// 准备ftl模板
		String ftlFileDir = request.getSession().getServletContext().getRealPath("res/ftl"); // ftl文件夹位置--用于配置freemarker
		// 报告导出ftl文件
		String ftlPath = "aaaa" + ".ftl";
		// 默认导出名称
		String wordPath = "桥梁结构健康监测参数数据.doc";
		// 准备数据
		Map<String, Object> dataMap = new HashMap<String, Object>();//最终结果map
		//Map<String, Object> resMap = new HashMap<String, Object>();
		List<ClhzData> clhzList = new ArrayList<ClhzData>();
		List<ClhzData> itemList = new ArrayList<ClhzData>();
		List<Map<String, Object>> titleList = modelExportService.getTitle(projectId, monitorParamId,monitorSitesId);
		AtiProject atiProject = atiProjectService.findProjectById(projectId);
		if (titleList != null && titleList.size()>0) {
			for (Map<String, Object> map : titleList) {
				ClhzData clhzData = new ClhzData();
				clhzList = new ArrayList<ClhzData>();
				dataMap.put("title", map.get("monitor_param_name"));
				clhzData.setTitle(map.get("monitor_param_name").toString()); //标题
				clhzData.setGcmc(atiProject.getProjectName());
				clhzData.setCode("无");
				clhzData.setGcbw(map.get("site_name").toString());
				clhzData.setJcyj("无");
				clhzData.setData(map.get("monitor_param_name").toString());
				clhzData.setZyyqsb(map.get("device_name")+"("+map.get("device_code")+")");
				 clhzList.add(clhzData);
				dataMap.put("clhzList", clhzList);
			}
		}
		List<AtiDeviceDataRecordHistory> dataHistory = modelExportService.findReportData(projectId, monitorParamId,monitorSitesId,uploadTimeBegin,uploadTimeEnd);
		if(dataHistory != null && dataHistory.size() >0) {
			
			for (AtiDeviceDataRecordHistory o : dataHistory) {		
				ClhzData clhzData = new ClhzData();
			    clhzData.setSj( o.getUploadTime());
				clhzData.setJtl(o.getDeviceUploadData());
				itemList.add(clhzData);
			}
			dataMap.put("itemList",itemList );
		}else{
			ClhzData clhzData = new ClhzData();
			clhzData.setSj("");
			clhzData.setJtl("");
			itemList.add(clhzData);
			dataMap.put("itemList",itemList);
		}
		File wrodfile = null;
		InputStream fin = null;
		ServletOutputStream out = null;
		try {
			// 调用工具类WordGenerator的createDoc方法生成Word文档
			wrodfile = FreeMarkerToWord.freeMarkerToWord(ftlFileDir, ftlPath, dataMap, wordPath);
			fin = new FileInputStream(wrodfile);

			response.setCharacterEncoding("utf-8");
			response.setContentType("application/msword");
			// 设置浏览器以下载的方式处理该文件
			response.addHeader("Content-Disposition",
					"attachment;filename=" + java.net.URLEncoder.encode(wordPath, "UTF-8"));

			out = response.getOutputStream();
			byte[] buffer = new byte[1024]; // 缓冲区
			int bytesToRead = -1;
			// 通过循环将读入的Word文件的内容输出到浏览器中
			while ((bytesToRead = fin.read(buffer)) != -1) {
				out.write(buffer, 0, bytesToRead);
			}
		} finally {
			if (fin != null)
				fin.close();
			if (out != null)
				out.close();
			if (wrodfile != null)
				wrodfile.delete(); // 删除临时文件
		}
		return null;
	}
}
