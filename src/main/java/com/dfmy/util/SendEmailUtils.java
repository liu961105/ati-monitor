package com.dfmy.util;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.Security;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.apache.commons.lang3.StringUtils;

/**
 * javaMail的邮件工具类
 *
 */
public class SendEmailUtils {

	/**
	 * 使用加密的方式,利用465端口进行传输邮件,开启ssl
	 * @param to  收件人
	 * @param subject   主题
	 * @param message   消息
	 * @param html      消息
	 * @param files     附件
	 * @throws Exception
	 */
	@SuppressWarnings("restriction")
	public static void sendEmil(String to, String subject, String message, String html, List<File> files)
			throws Exception {

		
		Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
		final String SSL_FACTORY = "javax.net.ssl.SSLSocketFactory";
		// 设置邮件会话参数
		Properties props = new Properties();
		// 邮箱的发送服务器地址
		props.setProperty("mail.smtp.host", "smtp.exmail.qq.com");
		props.setProperty("mail.smtp.socketFactory.class", SSL_FACTORY);
		props.setProperty("mail.smtp.socketFactory.fallback", "false");
		// 邮箱发送服务器端口,这里设置为465端口
		props.setProperty("mail.smtp.port", "465");
		props.setProperty("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.auth", "true");
		final String username = "echo@luotuowenxueshe.cn";
		final String password = "Wxdlt1314";
		// 获取到邮箱会话,利用匿名内部类的方式,将发送者邮箱用户名和密码授权给jvm
		Session session = Session.getDefaultInstance(props, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(username, password);
			}
		});
		// 通过会话,得到一个邮件,用于发送
		Message msg = new MimeMessage(session);
		// 设置发件人
		msg.setFrom(new InternetAddress("echo@luotuowenxueshe.cn"));
		// 设置收件人,to为收件人,cc为抄送,bcc为密送
		msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
		msg.setRecipients(Message.RecipientType.CC, InternetAddress.parse(to, false));
		msg.setRecipients(Message.RecipientType.BCC, InternetAddress.parse(to, false));

		// 设置发送的日期
		msg.setSentDate(new Date());

		// 设置邮件主题
		msg.setSubject(subject);

		// 设置邮件消息
		// msg.setText(message);

		/**/

		// 整封邮件的MINE消息体
		MimeMultipart msgMultipart = new MimeMultipart("mixed");// 混合的组合关系
		// 设置邮件的MINE消息体
		msg.setContent(msgMultipart);

		// related
		MimeMultipart relatedPart = new MimeMultipart("related");

		// alternative
		MimeMultipart alternativePart = new MimeMultipart("alternative");

		//
		MimeBodyPart relatedcontent = new MimeBodyPart();
		MimeBodyPart alternativecontent = new MimeBodyPart();

		//
		relatedcontent.setContent(relatedPart);
		alternativecontent.setContent(alternativePart);

		if (message != null && message != "") {
			// 纯文本消息
			BodyPart textpart = new MimeBodyPart();
			textpart.setText(message);
			alternativePart.addBodyPart(textpart);
		}

		if (html != null && html != "") {
			// html代码部分
			MimeBodyPart htmlPart = new MimeBodyPart();
			// html代码
			htmlPart.setContent(html, "text/html;charset=utf-8");
			alternativePart.addBodyPart(htmlPart);
		}

		// html中嵌套的图片部分
		// MimeBodyPart imgPart = new MimeBodyPart();
		// 正文添加图片和html代码
		// relatedPart.addBodyPart(imgPart);
		// 图片代码
		// imgPart.setHeader("Content-Location",
		// "http://www.luotuowenxueshe.cn/upload/avatar/0/13.jpg");

		// 附件
		// 添加附件的内容
		if (null != files && files.size() != 0) {
			for (File file : files) {
				MimeBodyPart attachmentBodyPart = new MimeBodyPart();
				DataSource source = new FileDataSource(file);
				attachmentBodyPart.setDataHandler(new DataHandler(source));
				// MimeUtility.encodeWord可以避免文件名乱码
				attachmentBodyPart.setFileName(MimeUtility.encodeWord(file.getName()));
				// 把附件加入到 MINE消息体中
				msgMultipart.addBodyPart(attachmentBodyPart);
			}
		}

		// 把内容加入到 MINE消息体中
		// relatedPart.addBodyPart(alternativecontent);
		msgMultipart.addBodyPart(alternativecontent);

		// 生成文件邮件
		msg.saveChanges();

		/**/
		// 调用Transport的send方法去发送邮件
		Transport.send(msg);
	}
	
	@SuppressWarnings("restriction")
	public static void sendMessage(String fromUser,String fromUserPwd,String to,String cc,String bcc,
			String subject,String content,List<String> fileList) throws MessagingException, UnsupportedEncodingException {
		// 配置发送邮件的环境属性
		final Properties props = new Properties();
		// 下面两段代码是设置ssl和端口，不设置发送不出去。
		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		// props.setProperty("mail.smtp.port", "465");
		props.setProperty("mail.smtp.socketFactory.port", "465");
		// 表示SMTP发送邮件，需要进行身份验证
		props.setProperty("mail.transport.protocol", "smtp");// 设置传输协议
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.host", "smtp.163.com");// QQ邮箱的服务器
													// 如果是企业邮箱或者其他邮箱得更换该服务器地址
		// 发件人的账号
		props.put("mail.user", fromUser);
		// 访问SMTP服务时需要提供的密码
		props.put("mail.password", fromUserPwd);

		// 构建授权信息，用于进行SMTP进行身份验证
		Authenticator authenticator = new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				// 用户名、密码
				String userName = props.getProperty("mail.user");
				String password = props.getProperty("mail.password");
				return new PasswordAuthentication(userName, password);
			}
		};
		// 使用环境属性和授权信息，创建邮件会话
		Session mailSession = Session.getInstance(props, authenticator);
		// 创建邮件消息
		MimeMessage message = new MimeMessage(mailSession);
		BodyPart messageBodyPart = new MimeBodyPart();
		Multipart multipart = new MimeMultipart();
		// 设置发件人
		InternetAddress form = new InternetAddress(props.getProperty("mail.user"));
		message.setFrom(form);
		// 发送
		if (StringUtils.isNotBlank(to)) {
			InternetAddress[] iaToList = new InternetAddress().parse(to);
			message.setRecipients(RecipientType.TO, iaToList); // 收件人
		}
		// 抄送
		if (StringUtils.isNotBlank(cc)) {
			InternetAddress[] iaToListcc = new InternetAddress().parse(cc);
			message.setRecipients(RecipientType.CC, iaToListcc); // 抄送人
		}
		// 密送
		if (StringUtils.isNotBlank(bcc)) {
			InternetAddress[] iaToListbcc = new InternetAddress().parse(bcc);
			message.setRecipients(RecipientType.BCC, iaToListbcc); // 密送人
		}
		message.setSentDate(new Date()); // 发送日期
											// 该日期可以随意写,你可以写上昨天的日期（效果很特别,亲测,有兴趣可以试试）,或者抽象出来形成一个参数。
		message.setSubject(subject); // 主题
		message.setText(content); // 内容
		// 显示以html格式的文本内容
		messageBodyPart.setContent(content, "text/html;charset=utf-8");
		multipart.addBodyPart(messageBodyPart);
		// 保存多个附件
		if (fileList != null && fileList.size() > 0) {
			addTach(fileList, multipart);
		}
		message.setContent(multipart);
		// 发送邮件
		Transport.send(message);
	}

	/**
	 * 如果传数组，则解析成逗号隔开的字符串
	 * @param mailArray
	 * @return
	 */
	private String getMailList(String[] mailArray) {
		StringBuffer toList = new StringBuffer();
		int length = mailArray.length;
		if (mailArray != null && length < 2) {
			toList.append(mailArray[0]);
		} else {
			for (int i = 0; i < length; i++) {
				toList.append(mailArray[i]);
				if (i != (length - 1)) {
					toList.append(",");
				}
			}
		}
		return toList.toString();
	}

	// 添加多个附件
	public static void addTach(List<String> fileList, Multipart multipart)
			throws MessagingException, UnsupportedEncodingException {
		for (String file : fileList) {
			MimeBodyPart mailArchieve = new MimeBodyPart();
			FileDataSource fds = new FileDataSource(file);
			mailArchieve.setDataHandler(new DataHandler(fds));
			mailArchieve.setFileName(MimeUtility.encodeText(fds.getName(), "UTF-8", "B"));
			multipart.addBodyPart(mailArchieve);
		}
	}

	public static void main(String[] args) {
		String fromUser = "hcmq@163.com";
		String fromUserPwd = "Hcmq123456";
		String to = "1321205629@qq.com";
		String subject = "123";
		String text = "123";

		List<String> files = new ArrayList<String>();
		//files.add("D:\\test.txt");

		try {
			sendMessage(fromUser, fromUserPwd, to, "", "", subject, text, null);
			System.out.println("chenggong");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void testsend() {

		String to = "737404745@qq.com";
		String subject = "测试主题";
		String text = "测试文本内容aaa111";
		String html = "<span style='color:red'>中文呵呵5464646kl;kd</span> <img src='http://www.luotuowenxueshe.cn/upload/avatar/0/13.jpg'>";
		/*File testFile = new File("D:\\test/123.txt");
		File testFileimg = new File("D:\\test/93438.jpg");
		File mydoc = new File("D:\\test/mydoc1.doc");*/

		List<File> files = new ArrayList<File>();
/*
		files.add(testFile);
		files.add(testFileimg);
		files.add(mydoc);*/

		try {
			sendEmil(to, subject, text, html, files);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}