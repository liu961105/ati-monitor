package com.dfmy.controller.sys;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.sys.SysDepartment;
import com.dfmy.service.sys.DepartmentService;
import com.dfmy.service.sys.SysCompanyInfoService;
import com.dfmy.util.StringHelper;
import com.dfmy.util.TimeHelper;
import com.google.common.collect.Maps;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
public class DeptController extends BaseController {
	@Autowired
	private DepartmentService departmentService;
	@Autowired
	private SysCompanyInfoService sysCompanyInfoService;

	private static final String PAGE_SIZE = "10";
	private static Map<String, String> sortTypes = Maps.newLinkedHashMap();
	private String alertType = "";
	static {
		sortTypes.put("auto", "自动");
		sortTypes.put("checkTime", "标题");
	}

	private SysDepartment sysDepartment;

	public SysDepartment getSysDepartment() {
		return sysDepartment;
	}

	public void setSysDepartment(SysDepartment sysDepartment) {
		this.sysDepartment = sysDepartment;
	}

	/**
	 * 表单保存信息
	 */
	@RequestMapping(value = "/sys/departmentSave", method = RequestMethod.POST)
	public ModelAndView systemSave(String deptId, SysDepartment sysDepartment, HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			if (!StringHelper.isNotBlack(sysDepartment.getState())) {
				sysDepartment.setState("1");
				sysDepartment.setCreateTime(TimeHelper.getCurrentTime());
			}
			sysDepartment.setUpdateTime(TimeHelper.getCurrentTime());
			departmentService.save(sysDepartment);
			alertType = "1";
		} catch (Exception e) {
			e.printStackTrace();
			alertType = "2";
		}
		return new ModelAndView("redirect:/sys/departmentTableList?companyId="+sysDepartment.getCompanyId());
	}
	
	
	/**
	 * 2014-07-29
	 * guolei
	 * 新版本部门管理
	 */
	@RequestMapping(value = "/sys/departmentTableList", method = RequestMethod.GET)
	public ModelAndView tableList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,Model model,String companyId) {
		try {
			try {
				Page<SysDepartment> pageInfo = departmentService.getPage(Integer.parseInt(pageCurrent), PAGESIZE, "createTime",companyId);
				setName(pageInfo.getContent());
				model.addAttribute("pageInfo", pageInfo);
				model.addAttribute("alertType", alertType);
				model.addAttribute("companyId", companyId);
				alertType = "";
				// 将搜索条件编码成字符串，用于排序，分页的URL
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ModelAndView("/manage/sys/department_table_list");
	}


	private void setName(List<SysDepartment> content) {
		// TODO Auto-generated method stub
		for (SysDepartment sysDepartment : content) {
			try {
				setName(sysDepartment);
			} catch (NumberFormatException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	private void setName(SysDepartment sysDepartment) throws Exception {
		if (StringHelper.isNotBlack(sysDepartment.getParentDeptCode())) {
			SysDepartment pDepartment = this.departmentService.findByCode(sysDepartment.getParentDeptCode(),sysDepartment.getCompanyId());
			if (pDepartment != null) {
				sysDepartment.setParentDepartment(pDepartment);
			}
		}
	}

	/**
	 * 返回完整的组织机构树的数据
	 * 按照setid（帐套的物理id过滤）
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/sys/departmenttree", method = RequestMethod.GET)
	public void departmenttree(HttpServletRequest request, HttpServletResponse response, String param) {
		try {
			List<SysDepartment> list = departmentService.findAllByCompanyId(param);
			List<Map<String, String>> treeList = new ArrayList<Map<String, String>>();
			if (list != null && !list.isEmpty()) {
				for (SysDepartment sysDepartment : list) {
					Map<String, String> map = Maps.newHashMapWithExpectedSize(7);
					map.put("id", sysDepartment.getDeptCode());
					map.put("pId", sysDepartment.getParentDeptCode());
					map.put("name", sysDepartment.getDeptName());
					map.put("title", sysDepartment.getDeptName());
					map.put("tld", String.valueOf(sysDepartment.getDeptId()));
					map.put("viewtype", "1");
					map.put("regiontype", "1");
					map.put("open", "true");
					map.put("seq", String.valueOf(sysDepartment.getDeptSeq()));
					treeList.add(map);
				}
			}
			JSONArray array = JSONArray.fromObject(treeList);
			PrintWriter out = response.getWriter();
			String json = array.toString();
			out.write(json);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/sys/departmenttree", method = RequestMethod.POST)
	public void departmenttreePost(HttpServletRequest request, HttpServletResponse response) {
		String param = request.getParameter("param");
		this.departmenttree(request, response,param);
	}

	/**
	 * 异步获取组织机构的完整信息并以json的格式返回
	 * 只需要传过组织机构的id（物理主键deptId即可）
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/sys/department/getRegion", method = RequestMethod.POST)
	public void getRegion(HttpServletRequest request, HttpServletResponse response) {
		try {
			String deptId = request.getParameter("key");
			String companyId = request.getParameter("companyId");
			SysDepartment sysDepartment = this.departmentService.findByKey(deptId);
			if (sysDepartment != null) {
				if (StringHelper.isNotBlack(sysDepartment.getParentDeptCode())) {
					SysDepartment pDepartment = this.departmentService.findByCode(sysDepartment.getParentDeptCode(),companyId);
					if (pDepartment != null) {
						sysDepartment.setParentDeptName(pDepartment.getDeptName());
					}
				}
				JSONObject object = JSONObject.fromObject(sysDepartment);
				PrintWriter out = response.getWriter();
				String json = object.toString();
				out.write(json);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	


	/**
	 * 方法描述 : 部门重命名
	 * @param request
	 * @param response
	 */
	@RequestMapping(value = "/sys/department/updateName", method = RequestMethod.POST)
	public void updateName(HttpServletRequest request, HttpServletResponse response) {
		try {
			String deptId = request.getParameter("key");
			SysDepartment dept = departmentService.findByKey(deptId);
			String newName = request.getParameter("newName");
			String companyId = request.getParameter("companyId"
					+ "");
			//获取部门根节点
			List<SysDepartment> deptGenList= departmentService.findByParentDeptCodeAndComId("0",companyId);
			SysDepartment deptGen=deptGenList.get(0);
			String deptGenCode=deptGen.getDeptCode();
			String deptCode=dept.getDeptCode();
			int count=deptCode.replace(deptGenCode, "000").length()/3;
			List<SysDepartment> sysDeptListAll=new ArrayList<SysDepartment>();
			for(int i=0;i<count-1;i++){
				List<SysDepartment> sysDeptListZi= departmentService.checkUniqueDeptName(newName, deptCode.substring(0,deptCode.length()-(i+1)*3),companyId);
				if(sysDeptListZi.size()==1){
					sysDeptListAll.add(sysDeptListZi.get(0));
				}else{
					//提示部门有重复,有脏数据
				}
			}
			String oldDeptName=dept.getDeptName();
			String deptCodeNew=deptCode.substring(0, deptCode.length()-3)+"___";
			if(!newName.equals(oldDeptName)){
				List<SysDepartment> sysDeptList = departmentService.checkUniqueDeptName(newName, deptCodeNew,companyId);
				// sysDeptList 同级节点验证    sysDeptListAll 父级节点验证
				boolean sysDeptListIsNotNull = sysDeptList!=null && sysDeptList.size()>0;
				boolean sysDeptListAllIsNotNull = sysDeptListAll!=null && sysDeptListAll.size()>0;
				if(sysDeptListIsNotNull || sysDeptListAllIsNotNull){
					response.setContentType("text/plain");
					response.setCharacterEncoding("utf-8");
					response.getWriter().write("repeat");
				}else{
					response.getWriter().write("success");
					dept.setDeptName(newName);
					departmentService.save(dept);
				}
			}else{
				response.getWriter().write("success");
				dept.setDeptName(newName);
				departmentService.save(dept);
			}
		} catch (Exception e) {
			e.printStackTrace();
			try {
				response.getWriter().write(e.getLocalizedMessage());
			} catch (Exception ex) {

			}
		}
	}

	/**
	 * 树保存信息
	 */
	@RequestMapping(value = "/sys/department/save", method = RequestMethod.POST)
	public void treeSave(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			String seq = request.getParameter("seq");
			String name = request.getParameter("name");
			String parId = request.getParameter("parId");
			String dcode = request.getParameter("dcode");
			String companyId = request.getParameter("companyId");
			SysDepartment dept = departmentService.findByCode(dcode,companyId);
			Map<String, Object> resMap = Maps.newHashMapWithExpectedSize(3);
			if(dept!=null && dept.getDeptId()!=null){
				resMap.put("ret", 2);
				response.getWriter().write(org.json.simple.JSONObject.toJSONString(resMap));
			}else{
				SysDepartment sysDept = new SysDepartment();
				sysDept.setDeptName(name);
				sysDept.setParentDeptCode(parId);
				sysDept.setDeptCode(dcode);
				sysDept.setDeptSeq(Integer.parseInt(seq));
				sysDept.setCreateTime(TimeHelper.getCurrentTime());
				sysDept.setUpdateTime(TimeHelper.getCurrentTime());
				sysDept.setState("1");
				sysDept.setCompanyId(companyId);
				SysDepartment saveDept = departmentService.save(sysDept);
				resMap.put("ret", 1);
				resMap.put("id", saveDept.getDeptId());
				response.getWriter().write(org.json.simple.JSONObject.toJSONString(resMap));
			}
		} catch (Exception e) {
			e.printStackTrace();
			try {
				Map<String, Object> resMap = Maps.newHashMapWithExpectedSize(1);
				resMap.put("ret", 0);
				response.getWriter().write(org.json.simple.JSONObject.toJSONString(resMap));
			} catch (Exception ex) {

			}
		}
	}

	/**
	 * 验证部门名称的唯一性
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/sys/department/checkDeptName", method = RequestMethod.GET)
	public void checkDeptName(HttpServletRequest request,HttpServletResponse response)throws Exception {
		try {
			String deptNameInput=StringUtils.trim((String)request.getParameter("regionName"));
			String deptNameold=StringUtils.trim((String)request.getParameter("oldRoleName"));
			String deptCode=StringUtils.trim((String)request.getParameter("regionCode"));
			String deptCodeNew=deptCode.substring(0, deptCode.length()-3)+"___";
			String companyId = request.getParameter("companyId");
			if(!deptNameInput.equals(deptNameold)){
				List<SysDepartment> sysDeptList = departmentService.checkUniqueDeptName(deptNameInput, deptCodeNew,companyId);
				if(sysDeptList!=null && sysDeptList.size()>0){
					response.getWriter().write("0");
				}else{
					response.getWriter().write("1");
				}
			}else{
				response.getWriter().write("1");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
