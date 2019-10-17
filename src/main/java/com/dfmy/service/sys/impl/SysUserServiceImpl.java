package com.dfmy.service.sys.impl;

import java.net.SocketException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfmy.dao.sys.SysUserDao;
import com.dfmy.entity.sys.SysUser;
import com.dfmy.service.sys.SysUserService;
import com.dfmy.util.TimeHelper;

@Service
@Transactional
public class SysUserServiceImpl implements SysUserService{

	@Resource
	private SysUserDao sysUserDao;
	
	@Override
	public SysUser saveUser(SysUser user) {
		return sysUserDao.save(user);
	}

	@Override
	public SysUser findUser(String userId) {
		return sysUserDao.findOne(userId);
	}

	@Override
	public void deleteUser(String userId) {
		sysUserDao.delete(userId);
	}

	@Override
	public Page<SysUser> pageList(int pageNumber,int pageSize,String sortColom,final SysUser user,final String deptId,final String selpostid) throws SocketException{
		Pageable pageable = new PageRequest(pageNumber-1, pageSize, Sort.Direction.ASC,sortColom); 
		Page<SysUser> sysUser = sysUserDao.findAll(new Specification<SysUser>(){  
	            @Override  
	            public Predicate toPredicate(Root<SysUser> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {  
	            	 List<Predicate> list = new ArrayList<Predicate>();  
	                 if(StringUtils.isNotBlank(user.getUserName())){
	                	 list.add(criteriaBuilder.or(
	                			 criteriaBuilder.like(root.get("userName").as(String.class), "%" +user.getUserName()+"%"),
	                			 criteriaBuilder.like(root.get("rolename").as(String.class), "%" +user.getUserName()+"%")
                			 ));
	                 }
	                 if(StringUtils.isNotBlank(deptId)){ 
	                	 Path<String> dpt = root.get("sysDept").get("deptId");  
	                     list.add(criteriaBuilder.equal(dpt, deptId));  
	                 }
	                 if(StringUtils.isNotBlank(selpostid)){  
	                     list.add(criteriaBuilder.equal(root.get("postId").as(String.class), selpostid));  
	                 } 
	                /* if(null!=user.getCreatetime() && !"".equals(user.getCreatetime())){  
	                     list.add(criteriaBuilder.like(root.get("createtime").as(String.class),"%"+ user.getCreatetime()+"%"));  
	                 }*/
//	                 if(StringUtils.isNotBlank(user.DE)){  
//	                	 Path<String> org=root.get("parentMenu").get("name");  
//                         list.add(criteriaBuilder.like(org,"%"+menu.getpName()+"%"));
//	                 }  
	                 list.add(criteriaBuilder.equal(root.get("isVisual").as(String.class),"1"));  
	                 Predicate[] p = new Predicate[list.size()];  
	                 return criteriaBuilder.and(list.toArray(p));
	            }  
	        },pageable); 
		 return sysUser;
	}

	@Override
	public SysUser findByUserName(String userName) {
		return sysUserDao.findByUserName(userName);
	}

	@Override
	public SysUser login(String userName, String password) {
		return sysUserDao.findByUserNameAndPassword(userName,password);
	}

	@Override
	public List<SysUser> findUserBydeptId(String iD) {
		
		return sysUserDao.findUserBydeptId(iD);
	}

	@Override
	public List<SysUser> findAll() {
		return (List<SysUser>) sysUserDao.findAll();
	}

	@Override
	public HSSFWorkbook exportExcel(List<SysUser> userList) {
		String[] head = {"序号","工号","姓名","部门","工序","岗位","性别","出生日期","年龄",
				         "学历","专业","毕业学校","毕业时间","是否实习生","就读形式",
				         "婚姻状态","生育情况","名族","身份证","户口所在地","户别",
				         "员工状态","转正情况","转正日期","联系电话","鞋码","入职时间",
				         "合同类型","合同起","合同止","社保","公积金","社保备注",
				         "社会工龄入职时间","紧急联系人","关系","联系人电话","介绍人",
				         "是否党员（必填项）","政治面貌","离职原因","离职时间","备注"
				         }; 
		
		
		//int thead=head.length;
		
		
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = workbook.createSheet("sheet1");// 创建一个表   
		
		
		
		
		// 列名样式
        HSSFFont font = workbook.createFont();
        font.setFontName("宋体");
        font.setFontHeightInPoints((short) 12);// 字体大小
        HSSFCellStyle style = workbook.createCellStyle();
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
        style.setFont(font);
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
        style.setLocked(true);
        // 普通单元格样式（中文）
        HSSFFont font2 = workbook.createFont();
        font2.setFontName("宋体");
        font2.setFontHeightInPoints((short) 12);
        HSSFCellStyle style2 = workbook.createCellStyle();
        style2.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
        style2.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
        style2.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
        style2.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
        style2.setFont(font2);
        style2.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
		style2.setWrapText(true); // 换行
		style2.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
		
		
		sheet.setColumnWidth(0, 2500);
		sheet.setColumnWidth(1, 5500);
		sheet.setColumnWidth(2, 5500);
		sheet.setColumnWidth(3, 5500);
		sheet.setColumnWidth(4, 5500);
		sheet.setColumnWidth(5, 5500);
		sheet.setColumnWidth(6, 5500);
		sheet.setColumnWidth(7, 5500);
		sheet.setColumnWidth(8, 5500);
		sheet.setColumnWidth(9, 5500);
		sheet.setColumnWidth(10, 5500);
		sheet.setColumnWidth(11, 5500);
		sheet.setColumnWidth(12, 5500);
		sheet.setColumnWidth(13, 5500);
		sheet.setColumnWidth(14, 5500);
		sheet.setColumnWidth(15, 5500);
		sheet.setColumnWidth(16, 5500);
		sheet.setColumnWidth(17, 5500);
		sheet.setColumnWidth(18, 5500);
		sheet.setColumnWidth(19, 5500);
		sheet.setColumnWidth(20, 5500);
		sheet.setColumnWidth(21, 5500);
		sheet.setColumnWidth(22, 5500);
		sheet.setColumnWidth(23, 5500);
		sheet.setColumnWidth(24, 5500);
		sheet.setColumnWidth(25, 5500);

		
		sheet.setColumnWidth(26, 5500);
		sheet.setColumnWidth(27, 5500);
		sheet.setColumnWidth(28, 5500);
		sheet.setColumnWidth(29, 5500);
		sheet.setColumnWidth(30, 5500);
		sheet.setColumnWidth(31, 5500);
		sheet.setColumnWidth(32, 5500);
		sheet.setColumnWidth(33, 5500);
		sheet.setColumnWidth(34, 5500);
		sheet.setColumnWidth(36, 5500);
		sheet.setColumnWidth(37, 5500);
		sheet.setColumnWidth(38, 5500);
		sheet.setColumnWidth(39, 5500);
		sheet.setColumnWidth(40, 5500);
		
		sheet.setColumnWidth(41, 5500);
		sheet.setColumnWidth(42, 5500);
		sheet.setColumnWidth(43, 5500);
		
		// 设置列宽 （第几列，宽度）
		sheet.setDefaultRowHeight((short) 720);// 设置行高
		
		
		
		HSSFRow row = sheet.createRow(0);
		HSSFCell cell = row.createCell(0);
        for (int i = 0; i < head.length; i++) {
        	sheet.autoSizeColumn(i, true);// 根据字段长度自动调整列的宽度
            cell = row.createCell(i);
            cell.setCellValue(head[i]);
            cell.setCellStyle(style);
        }
        
        for (int i = 0; i < userList.size(); i++) {
        	row = sheet.createRow(i + 1);
        	SysUser orderInfo = userList.get(i);
	          /*{"序号","工号","姓名","部门","工序","岗位","性别","出生日期","年龄",
		         "学历","专业","毕业学校","毕业时间","是否实习生","就读形式",
		         "婚姻状态","生育情况","名族","身份证","户口所在地","户别",
		         "员工状态","转正情况","转正日期","联系电话","鞋码","入职时间",
		         "合同类型","合同起","合同止","社保","公积金","备注",
		         "社会工龄入职时间","紧急联系人","关系","联系电话","介绍人",
		         "是否党员（必填项）","政治面貌","离职原因","离职时间","备注"
		         }*/
        	row.createCell(0).setCellValue(i+1);
        	row.createCell(1).setCellValue(orderInfo.getUserName()); //账号-->工号--->登录用
        	row.createCell(2).setCellValue(orderInfo.getRolename());
        	row.createCell(3).setCellValue(orderInfo.getDeptName()); 
        	row.createCell(4).setCellValue(orderInfo.getPrcdure()); 
        	row.createCell(5).setCellValue(orderInfo.getPostName()); 
        	row.createCell(6).setCellValue(orderInfo.getSex()); 
        	row.createCell(7).setCellValue(orderInfo.getBrithday()); 
        	row.createCell(8).setCellValue(TimeHelper.getAgeByBirth(orderInfo.getBrithday())); 

        	
        	row.createCell(9).setCellValue(orderInfo.getEducation()); 
        	row.createCell(10).setCellValue(orderInfo.getMajor()); 
        	row.createCell(11).setCellValue(orderInfo.getGraduateSchool()); 
        	row.createCell(12).setCellValue(orderInfo.getGraduateTime()); 
        	row.createCell(13).setCellValue(orderInfo.getIsStudent()); 
        	row.createCell(14).setCellValue(orderInfo.getEduMode()); 
        	
        	row.createCell(15).setCellValue(orderInfo.getMarStatus()); 
        	row.createCell(16).setCellValue(orderInfo.getFetStatus()); 
        	row.createCell(17).setCellValue(orderInfo.getMinority()); 
        	row.createCell(18).setCellValue(orderInfo.getIdcardno()); 
        	row.createCell(19).setCellValue(orderInfo.getDomicile()); 
        	row.createCell(20).setCellValue(orderInfo.getDmcType()); 

        	row.createCell(21).setCellValue(orderInfo.getJobstatus()); 
        	row.createCell(22).setCellValue(orderInfo.getIsRegular()); 
        	row.createCell(23).setCellValue(orderInfo.getRegularDate()); 
        	row.createCell(24).setCellValue(orderInfo.getPhoneNum()); 
        	row.createCell(25).setCellValue(orderInfo.getShoeSize()); 
        	row.createCell(26).setCellValue(orderInfo.getJoindate()); 
    
        	row.createCell(27).setCellValue(orderInfo.getSigncontractNum()); 
        	row.createCell(28).setCellValue(orderInfo.getContractSigningDate()); 
        	row.createCell(29).setCellValue(orderInfo.getContractExpirationDate()); 
        	row.createCell(30).setCellValue(orderInfo.getIsSocialsecurity()); 
        	row.createCell(31).setCellValue(orderInfo.getIsAccumulationfund()); 
        	row.createCell(32).setCellValue(orderInfo.getSosRemark()); 

        	row.createCell(33).setCellValue(orderInfo.getSosJobdate()); 
        	row.createCell(34).setCellValue(orderInfo.getLinkman()); 
        	row.createCell(35).setCellValue(orderInfo.getLinkmanRtp()); 
        	row.createCell(36).setCellValue(orderInfo.getLinkmanPhone()); 
        	row.createCell(37).setCellValue(orderInfo.getIntroducer()); 
 
        	row.createCell(38).setCellValue(orderInfo.getIsCommunist()); 
        	row.createCell(39).setCellValue(orderInfo.getIsMember()); 
        	row.createCell(40).setCellValue(orderInfo.getLeavingReasons()); 
        	row.createCell(41).setCellValue(orderInfo.getLeavingTime()); 
        	row.createCell(42).setCellValue(orderInfo.getRemark()); 
        	
        	
        	
        	 /*{"序号","工号","姓名","部门","工序","岗位","性别","出生日期","年龄",
	         "学历","专业","毕业学校","毕业时间","是否实习生","就读形式",
	         "婚姻状态","生育情况","名族","身份证","户口所在地","户别",
	         "员工状态","转正情况","转正日期","联系电话","鞋码","入职时间",
	         "合同类型","合同起","合同止","社保","公积金","备注",
	         "社会工龄入职时间","紧急联系人","关系","联系电话","介绍人",
	         "是否党员（必填项）","政治面貌","离职原因","离职时间","备注"
	         }*/
        	
        	
        	for (int k = 0; k < 43; k++) {
                row.getCell(k).setCellStyle(style2);
    		}
        }
		return workbook;
	}

	@Override
	public SysUser getUserByGh(String gh) {
		return sysUserDao.findByUserName(gh);
	}
}
