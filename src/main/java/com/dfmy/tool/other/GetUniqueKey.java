package com.dfmy.tool.other;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;

/**
 * 创建序列编号
 * @author wang
 *20160229
 */
public class GetUniqueKey {

	 private static String count = "000";
	 private static String dateValue = "20160101";
	 private final static String PREFIX="WW";
	 
	 /**
	  * 获取两种日期序列号
	  * @return
	  */
	 public synchronized static String getTimeMillisSequence(){
	        long nanoTime = System.nanoTime();
	        String preFix="";
	        if (nanoTime<0){
	            preFix="A";//负数补位A保证负数排在正数Z前面,解决正负临界值(如A9223372036854775807至Z0000000000000000000)问题。
	            nanoTime = nanoTime+Long.MAX_VALUE+1;
	        }else{
	            preFix="Z";
	        }
	        String nanoTimeStr = String.valueOf(nanoTime);
	         
	        int difBit=String.valueOf(Long.MAX_VALUE).length()-nanoTimeStr.length();
	        for (int i=0;i<difBit;i++){
	            preFix = preFix+"0";
	        }
	        nanoTimeStr = preFix+nanoTimeStr;
	        SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMddHHmmssSSS"); 
	        String timeMillisSequence=sdf.format(System.currentTimeMillis())+"-"+nanoTimeStr; 
	        return timeMillisSequence;      
	    }

	 public static String getCurrentDateTime(String format)
	 {
		 //"yyyyMMddHHmmssSSS"
		    SimpleDateFormat sdf=new SimpleDateFormat(format); 
	        String timeMillisSequence=sdf.format(System.currentTimeMillis()); 
	        return timeMillisSequence;      
		 
	 }
	 
	    public static void main(String[] args){
	    	
	    System.out.println(GetUniqueKey.getTimeMillisSequence());
	    System.out.println(GetUniqueKey.getCurrentDateTime("yyyy-MM-dd HH: mm ss"));
	    System.out.println(GetUniqueKey.getMoveOrderNo());
	    System.out.println(GetUniqueKey.getMoveOrderNo("WW20160229010"));
	    }
	    /**
	     * 产生流水号
	     */
	    public synchronized static String getMoveOrderNo() {
	     long No = 0;
	     SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
	     String nowdate = sdf.format(new Date());
	     No = Long.parseLong(nowdate);
	     if (!(String.valueOf(No)).equals(dateValue)) {
	      count = "000";
	      dateValue = String.valueOf(No);
	     }
	     String num = String.valueOf(No);
	     num += getNo(count);
	     num =PREFIX + num;
	     return num;
	    }
	    /**
	     * 获取当前并生成下一序列号
	     */
	    public synchronized static String getMoveOrderNo(String serialNum) {
	     String nyr = StringUtils.substring(serialNum, 2, 10); // 获取年月日字符串
	     String countV = StringUtils.substring(serialNum, 10); // 获取流水号
	     if (Integer.valueOf(countV) > Integer.valueOf(count)) {
	      dateValue = nyr;
	      count = String.valueOf(countV);
	     }
	     return getMoveOrderNo();
	    }
	    /**
	     * 返回当天的订单数+1
	     */
	    public static String getNo(String s) {
	     String rs = s;
	     int i = Integer.parseInt(rs);
	     i += 1;
	     rs = "" + i;
	     for (int j = rs.length(); j < 3; j++) {
	      rs = "0" + rs;
	     }
	     count = rs;
	     return rs;
	    }
}
