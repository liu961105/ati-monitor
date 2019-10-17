package com.dfmy.controller.sys;

import org.jeecgframework.poi.excel.annotation.Excel;
import org.jeecgframework.poi.handler.inter.IExcelModel;

public class UserImport implements IExcelModel{
	
	/*{"序号","工号（必填项）","真实姓名（必填项）","性别（必填项）","手机号码（必填项）","出生日期（必填项）","身份证号（必填项）","紧急联系人（必填项）","岗位（必填项）","入职日期（必填项）",
        "是否缴纳社保（必填项）","是否缴纳公积金（必填项）","劳动合同签订日期（必填项）","劳动合同到期时间（必填项）","合同签订次数（必填项）",
        "毕业院校","专业","毕业时间","学历","职称","是否党员（必填项）","是否团员（必填项）",
        "在岗/离职状态（必填项）","离职原因","离职时间","备注"}*/
	
	
	@Excel(name="工号")
	String gh;
	@Excel(name="姓名")
	String yhm;
	@Excel(name="部门")
	String bm;
	@Excel(name="工序")
	String gx;
	@Excel(name="岗位")
	String gw;
	@Excel(name="性别")
	String xb;
	@Excel(name="出生日期")
	String csrq;
	

	@Excel(name="毕业学校")
	String byyx;
	@Excel(name="学历")
	String xl;
	@Excel(name="专业")
	String zy;
	@Excel(name="毕业时间")
	String bysj;
	@Excel(name="是否实习生")
	String sxs;
	@Excel(name="就读形式")
	String jdxs;
	
	
	@Excel(name="婚姻状态")
	String hyzt;
	@Excel(name="生育情况")
	String syqk;
	@Excel(name="名族")
	String mz;
	@Excel(name="身份证")
	String sfz;
	@Excel(name="户口所在地")
	String hkd;
	@Excel(name="户别")
	String hb;
	

	
	@Excel(name="员工状态")
	String ygzt;
	@Excel(name="转正情况")
	String zzqk;
	@Excel(name="转正日期")
	String zzrq;
	@Excel(name="联系电话")
	String lxdh;
	@Excel(name="鞋码")
	String xm;
	@Excel(name="入职时间")
	String rzsj;
	
	 
	
	@Excel(name="合同类型")
	String htlx;
	@Excel(name="合同起")
	String htq;
	@Excel(name="合同止")
	String htz;
	@Excel(name="社保")
	String sb;
	@Excel(name="公积金")
	String gjj;
	@Excel(name="社保备注")
	String sbbz;
	
	
	@Excel(name="社会工龄入职时间")
	String shgl;
	@Excel(name="紧急联系人")
	String jjlxr;
	@Excel(name="关系")
	String jjlxrgx;
	@Excel(name="联系人电话")
	String lxrdh;
	@Excel(name="介绍人")
	String jsr;
	@Excel(name="是否党员（必填项）")
	String sfdy;
	@Excel(name="政治面貌")
	String zzmm;
	@Excel(name="离职原因")
	String lzyy;
	@Excel(name="离职时间")
	String lzsj;
	@Excel(name="备注")
	String bz;
	
	
	//导入错误信息
    private String errorMsg;
    
    
    /*{"序号","工号","姓名","部门","工序","岗位","性别","出生日期","年龄",
	  "学历","专业","毕业学校","毕业时间","是否实习生","就读形式",
	  "婚姻状态","生育情况","名族","身份证","户口所在地","户别",
	  "员工状态","转正情况","转正日期","联系电话","鞋码","入职时间",
	  "合同类型","合同起","合同止","社保","公积金","备注",
	  "社会工龄入职时间","紧急联系人","关系","联系电话","介绍人",
	  "是否党员（必填项）","政治面貌","离职原因","离职时间","备注"
	  }*/
    
    
	public String getErrorMsg() {
		return errorMsg;
	}
	public String getBm() {
		return bm;
	}
	public void setBm(String bm) {
		this.bm = bm;
	}
	public String getGx() {
		return gx;
	}
	public void setGx(String gx) {
		this.gx = gx;
	}
	public String getSxs() {
		return sxs;
	}
	public void setSxs(String sxs) {
		this.sxs = sxs;
	}
	public String getJdxs() {
		return jdxs;
	}
	public void setJdxs(String jdxs) {
		this.jdxs = jdxs;
	}
	public String getHyzt() {
		return hyzt;
	}
	public void setHyzt(String hyzt) {
		this.hyzt = hyzt;
	}
	public String getSyqk() {
		return syqk;
	}
	public void setSyqk(String syqk) {
		this.syqk = syqk;
	}
	public String getMz() {
		return mz;
	}
	public void setMz(String mz) {
		this.mz = mz;
	}
	public String getSfz() {
		return sfz;
	}
	public void setSfz(String sfz) {
		this.sfz = sfz;
	}
	public String getHkd() {
		return hkd;
	}
	public void setHkd(String hkd) {
		this.hkd = hkd;
	}
	public String getHb() {
		return hb;
	}
	public void setHb(String hb) {
		this.hb = hb;
	}
	public String getYgzt() {
		return ygzt;
	}
	public void setYgzt(String ygzt) {
		this.ygzt = ygzt;
	}
	public String getZzqk() {
		return zzqk;
	}
	public void setZzqk(String zzqk) {
		this.zzqk = zzqk;
	}
	public String getZzrq() {
		return zzrq;
	}
	public void setZzrq(String zzrq) {
		this.zzrq = zzrq;
	}
	public String getLxdh() {
		return lxdh;
	}
	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}
	public String getXm() {
		return xm;
	}
	public void setXm(String xm) {
		this.xm = xm;
	}
	public String getRzsj() {
		return rzsj;
	}
	public void setRzsj(String rzsj) {
		this.rzsj = rzsj;
	}
	public String getHtlx() {
		return htlx;
	}
	public void setHtlx(String htlx) {
		this.htlx = htlx;
	}
	public String getHtq() {
		return htq;
	}
	public void setHtq(String htq) {
		this.htq = htq;
	}
	public String getHtz() {
		return htz;
	}
	public void setHtz(String htz) {
		this.htz = htz;
	}
	public String getSb() {
		return sb;
	}
	public void setSb(String sb) {
		this.sb = sb;
	}
	public String getGjj() {
		return gjj;
	}
	public void setGjj(String gjj) {
		this.gjj = gjj;
	}
	public String getShgl() {
		return shgl;
	}
	public void setShgl(String shgl) {
		this.shgl = shgl;
	}
	public String getJjlxrgx() {
		return jjlxrgx;
	}
	public void setJjlxrgx(String jjlxrgx) {
		this.jjlxrgx = jjlxrgx;
	}
	public String getJsr() {
		return jsr;
	}
	public void setJsr(String jsr) {
		this.jsr = jsr;
	}
	public String getZzmm() {
		return zzmm;
	}
	public void setZzmm(String zzmm) {
		this.zzmm = zzmm;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	public String getGh() {
		return gh;
	}
	public void setGh(String gh) {
		this.gh = gh;
	}
	public String getYhm() {
		return yhm;
	}
	public void setYhm(String yhm) {
		this.yhm = yhm;
	}
	public String getCsrq() {
		return csrq;
	}
	public void setCsrq(String csrq) {
		this.csrq = csrq;
	}
	
	public String getGw() {
		return gw;
	}
	public void setGw(String gw) {
		this.gw = gw;
	}
	
	public String getJjlxr() {
		return jjlxr;
	}
	public void setJjlxr(String jjlxr) {
		this.jjlxr = jjlxr;
	}
	public String getXl() {
		return xl;
	}
	public void setXl(String xl) {
		this.xl = xl;
	}
	public String getZy() {
		return zy;
	}
	public void setZy(String zy) {
		this.zy = zy;
	}
	
	public String getSfdy() {
		return sfdy;
	}
	public void setSfdy(String sfdy) {
		this.sfdy = sfdy;
	}
	public String getBz() {
		return bz;
	}
	public void setBz(String bz) {
		this.bz = bz;
	}

	
	
	public String getXb() {
		return xb;
	}
	public void setXb(String xb) {
		this.xb = xb;
	}
	
	public String getByyx() {
		return byyx;
	}
	public void setByyx(String byyx) {
		this.byyx = byyx;
	}
	public String getBysj() {
		return bysj;
	}
	public void setBysj(String bysj) {
		this.bysj = bysj;
	}
	
	public String getLzyy() {
		return lzyy;
	}
	public void setLzyy(String lzyy) {
		this.lzyy = lzyy;
	}
	public String getLzsj() {
		return lzsj;
	}
	public void setLzsj(String lzsj) {
		this.lzsj = lzsj;
	}
	
	public String getSbbz() {
		return sbbz;
	}
	public void setSbbz(String sbbz) {
		this.sbbz = sbbz;
	}
	public String getLxrdh() {
		return lxrdh;
	}
	public void setLxrdh(String lxrdh) {
		this.lxrdh = lxrdh;
	}
}



