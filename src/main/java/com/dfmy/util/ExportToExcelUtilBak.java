package com.dfmy.util;

import java.io.OutputStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.util.CellRangeAddress;
/**
 * List<Map<String,Object>>格式导出Excel工具类(多层标题合并单元格)
 * 只适用于扶贫措施导出（有序号）
 * @author jinlong
 *
 */
public class ExportToExcelUtilBak {
	public void exportMain(HttpServletResponse response,String fileName,String[] head0,String[] head1,String[] head2,
			String[] headnum0,String[] headnum1,String[] headnum2,String[] colName,List<Map<String, Object>> dataList) throws Exception {
		int startRow = 1;
        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(fileName);// 创建一个表
        // 表头标题样式
        HSSFFont headfont = workbook.createFont();
        headfont.setFontName("宋体");
        headfont.setFontHeightInPoints((short) 22);// 字体大小
        HSSFCellStyle headstyle = workbook.createCellStyle();
        headstyle.setFont(headfont);
        headstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
        headstyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
        headstyle.setLocked(true);    
        // 表头时间样式
        HSSFFont datefont = workbook.createFont();
        datefont.setFontName("宋体");
        datefont.setFontHeightInPoints((short) 12);// 字体大小
        HSSFCellStyle datestyle = workbook.createCellStyle();
        datestyle.setFont(datefont);
        datestyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
        datestyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
        datestyle.setLocked(true);
        // 列名样式
        HSSFFont font = workbook.createFont();
        font.setFontName("宋体");
        font.setFontHeightInPoints((short) 12);// 字体大小
        font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//粗体显示
        HSSFCellStyle style = workbook.createCellStyle();
        style.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
        style.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
        style.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
        style.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
        style.setFont(font);
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
        style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
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
        // 设置列宽  （第几列，宽度）
        sheet.setColumnWidth( 0, 1600);
        sheet.setColumnWidth( 1, 3600);  
        sheet.setColumnWidth( 2, 2800);  
        sheet.setColumnWidth( 3, 2800);  
        sheet.setColumnWidth( 4, 2800);  
        sheet.setColumnWidth( 5, 2800);
        sheet.setColumnWidth( 6, 4500);
        sheet.setColumnWidth( 7, 3600); 
        sheet.setDefaultRowHeight((short)360);//设置行高
        // 第一行表头标题
        HSSFRow row = sheet.createRow(0);
        row = sheet.createRow(0);
		HSSFCell cell = row.createCell(0);
        for (int i = 0; i < head0.length; i++) {
            cell = row.createCell(i);
            cell.setCellValue(head0[i]);
            cell.setCellStyle(style);
            sheet.autoSizeColumn((short)i); 
        }
        //动态合并第一行单元格
        for (int i = 0; i < headnum0.length; i++) {
            String[] temp = headnum0[i].split(",");
            Integer startrow = Integer.parseInt(temp[0]);
            Integer overrow = Integer.parseInt(temp[1]);
            Integer startcol = Integer.parseInt(temp[2]);
            Integer overcol = Integer.parseInt(temp[3]);
            sheet.addMergedRegion(new CellRangeAddress(startrow, overrow,startcol, overcol));
        }
        // 判断是否有第二行表头标题
        if(head1.length>0){
        	startRow = 2;
        	row = sheet.createRow(1);
            for (int i = 0; i < head0.length; i++) { 
                cell = row.createCell(i);
                cell.setCellStyle(style);
                for (int j = 0; j < head1.length; j++) {
                    cell = row.createCell(j);
                    cell.setCellValue(head1[j]);
                    cell.setCellStyle(style);
                    sheet.autoSizeColumn((short)j); 
                } 
            }
            //动态合并第二行单元格
            for (int i = 0; i < headnum1.length; i++) {
                String[] temp = headnum1[i].split(",");
                Integer startrow = Integer.parseInt(temp[0]);
                Integer overrow = Integer.parseInt(temp[1]);
                Integer startcol = Integer.parseInt(temp[2]);
                Integer overcol = Integer.parseInt(temp[3]);
                sheet.addMergedRegion(new CellRangeAddress(startrow, overrow,startcol, overcol));
            }
            if(head2.length>0){
            	startRow = 3;
            	//第三行表头标题头
                row = sheet.createRow(2);
                for (int i = 0; i < head0.length; i++) { 
                    cell = row.createCell(i);
                    cell.setCellStyle(style);
                    for (int j = 0; j < head2.length; j++) {
                        cell = row.createCell(j);
                        cell.setCellValue(head2[j]);
                        cell.setCellStyle(style);
                        sheet.autoSizeColumn((short)j); 
                    } 
                }
                //动态合并第三行单元格
                for (int i = 0; i < headnum2.length; i++) {
                    String[] temp = headnum2[i].split(",");
                    Integer startrow = Integer.parseInt(temp[0]);
                    Integer overrow = Integer.parseInt(temp[1]);
                    Integer startcol = Integer.parseInt(temp[2]);
                    Integer overcol = Integer.parseInt(temp[3]);
                    sheet.addMergedRegion(new CellRangeAddress(startrow, overrow,startcol, overcol));
                }
            }
        }
	    
	    // 设置列值-内容
        for (int i = 0; i < dataList.size(); i++) {
            row = sheet.createRow(i + startRow);
            //根据是否有“平均值”和“合计”添加序号
            if(dataList.size()>1){
            	cell = row.createCell(0);
            	cell.setCellValue(i+1);
             	cell.setCellStyle(style2);
                cell.setCellType(HSSFCell.CELL_TYPE_STRING);
                for (int j = 0; j < colName.length; j++) {
                 	Map<String,Object> tempmap = dataList.get(i);
                     if(tempmap!=null && tempmap.get(colName[j])!=null){
                     	String data = tempmap.get(colName[j]).toString();                
                     	cell = row.createCell(j+1);
                     	cell.setCellValue(data);
                        cell.setCellStyle(style2);
                        cell.setCellType(HSSFCell.CELL_TYPE_STRING);
                     }else{
                     	cell.setCellValue("");
                     }
                 }
            }else{
            	cell = row.createCell(0);
            	cell.setCellValue(i+1);
            	cell.setCellStyle(style2);
                cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	        	for (int j = 0; j < colName.length; j++) {
	             	Map<String,Object> tempmap = dataList.get(i);
	                 if(tempmap!=null && tempmap.get(colName[j])!=null){
	                 	String data = tempmap.get(colName[j]).toString();                
	                 	cell = row.createCell(j+1);
	                 	cell.setCellValue(data);
	                    cell.setCellStyle(style2);
	                    cell.setCellType(HSSFCell.CELL_TYPE_STRING);
	                 }else{
	                 	cell.setCellValue("");
	                 }
	             }
            }
        }
	    fileName = fileName+".xls";
	    /*String path="E:/"+fileName;
	    OutputStream out = new FileOutputStream(path);
		workbook.write(out);// 写入File
		out.flush();
		out.close();*/
	    //获取浏览器默认下载地址
		response.setContentType("application/vnd.ms-excel");    
        response.setHeader("Content-disposition", "attachment;filename="+new String(fileName.getBytes("gb2312"),"iso8859-1"));
        OutputStream ouputStream = response.getOutputStream();    
        workbook.write(ouputStream);    
        ouputStream.flush();    
        ouputStream.close();
	}
}
