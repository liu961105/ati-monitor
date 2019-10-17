package com.dfmy.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.Map;
import freemarker.template.Configuration;
import freemarker.template.Template;

import org.apache.commons.codec.binary.Base64;

import com.dfmy.entity.dataProduct.ClhzData;
/**
 * freemarker模板导出工具类
 * @author 
 *
 */
public  class FreeMarkerToWord {
	
	public static File freeMarkerToWord(String ftlFileDir, String tpath, String datamap, String outFilePath) throws IOException, Exception {
		
		/** 初始化配置文件  **/
        Configuration configuration = new Configuration();       
        configuration.setDefaultEncoding("utf-8");
        
        /** ftl文件目录**/
       String fileDirectory = ftlFileDir;
        
        /** 加载文件 **/
        configuration.setDirectoryForTemplateLoading(new File(fileDirectory));
        
        /** 加载模板 **/
        Template template = configuration.getTemplate(tpath,"UTF-8");
       
                   
        File docFile = new File(outFilePath);
        
        FileOutputStream fos = new FileOutputStream(docFile);
        Writer out = new BufferedWriter(new OutputStreamWriter(fos, "utf-8"),10240);
        
        template.process(datamap,out);
           if(out != null){
              out.close();
        }
		
        return docFile;  
	}
	public static File freeMarkerToWord(String ftlFileDir, String tpath,  Map<String,Object> datamap, String outFilePath) throws IOException, Exception {

		/** 初始化配置文件  **/
		Configuration configuration = new Configuration();
		configuration.setDefaultEncoding("utf-8");

		/** ftl文件目录**/
		String fileDirectory = ftlFileDir;

		/** 加载文件 **/
		configuration.setDirectoryForTemplateLoading(new File(fileDirectory));

		/** 加载模板 **/
		Template template = configuration.getTemplate(tpath,"UTF-8");


		File docFile = new File(outFilePath);

		FileOutputStream fos = new FileOutputStream(docFile);
		Writer out = new BufferedWriter(new OutputStreamWriter(fos, "utf-8"),10240);

		template.process(datamap,out);
		if(out != null){
			out.close();
		}

		return docFile;
	}


	public static void main(String[] args) {
		//windows
		String ftlFileDir="D:\\upload\\jtltest"; //ftl文件夹位置--用于配置freemarker
		String tpath="jtltest.ftl";
		String outFilePath="8888.doc";
		//准备数据
		Map<String, Object> dataMap=new HashMap<String, Object>();
		ClhzData sbcz = new ClhzData();
		dataMap.put("code","001");
        dataMap.put("gcbw","测试");
        dataMap.put("jcyj","检测依据");
        dataMap.put("clzyyqsb","主要设备编号");
		try {
			File word = freeMarkerToWord(ftlFileDir, tpath, dataMap, outFilePath);
			
			System.out.println("freemarker转换完成。。。。。");
			
			InputStream input = null ;    // 准备好一个输入的对象 
			input = new FileInputStream(word);    // 通过对象多态性，进行实例化
			savePic(input, outFilePath);
			
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	//保存文件
	public static void savePic(InputStream inputStream, String fileName) {

        OutputStream os = null;
        try {
        	//Windows
            String path = "F:\\upload\\abcd";
            //Mac
			//String path = "/Users/anix/Java/test/doc";
            // 2、保存到临时文件
            // 1K的数据缓冲
            byte[] bs = new byte[1024];
            // 读取到的数据长度
            int len;
            // 输出的文件流保存到本地文件

            File tempFile = new File(path);
            if (!tempFile.exists()) {
                tempFile.mkdirs();
            }
            os = new FileOutputStream(tempFile.getPath() + File.separator + fileName);
            // 开始读取
            while ((len = inputStream.read(bs)) != -1) {
                os.write(bs, 0, len);
            }
            
            System.out.println("word保存到F盘。。。");

        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 完毕，关闭所有链接
            try {
                os.close();
                inputStream.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
	
	
	
	/**
	 * @Description: 根据图片地址转换为base64编码字符串
	 * @Author: 
	 * @CreateTime: 
	 * @return
	 */
	public static String getImageStr(String imgFile) {
	    InputStream inputStream = null;
	    byte[] data = null;
	    try {
	        inputStream = new FileInputStream(imgFile);
	        data = new byte[inputStream.available()];
	        inputStream.read(data);
	        inputStream.close();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    // 加密
	    //BASE64Encoder encoder = new BASE64Encoder();
	    //return encoder.encode(data);
		//jdk8+
		return Base64.encodeBase64String(data);
	}

}
