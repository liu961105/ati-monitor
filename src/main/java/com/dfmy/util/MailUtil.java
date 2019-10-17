package com.dfmy.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailUtil {
	private static final String MAIL_HOST = "smtp.163.com";
	private static final String MAIL_TRANSPORT_PROTOCOL = "smtp";
	private static final String USER = "hcmq@163.com";
	// 这个秘密不是邮箱的密码，是要去163邮箱开通申请得到的
	private static final String PASSWORD = "Hcmq123456";

	private MailUtil() {
	}

	public static void main(String[] args) {
		try {
			MailUtil.testSendMail("hcmq@163.com","Hcmq123456","737404745@qq.com","主题", "内容");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void testSendMail(String fromUser,String fromUserPwd,String to,String subject, String content) throws Exception {
		Properties prop = new Properties();
		prop.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		prop.setProperty("mail.smtp.socketFactory.port", "465");
		prop.setProperty("mail.host", MAIL_HOST);
		prop.setProperty("mail.transport.protocol", MAIL_TRANSPORT_PROTOCOL);
		prop.setProperty("mail.smtp.auth", "true");
		Session session = Session.getInstance(prop);
		// 开启debug模式，方便看程序发送Email的运行状态
		session.setDebug(true);
		Transport ts = session.getTransport();
		ts.connect(MAIL_HOST, fromUser, fromUserPwd);
		Message message = simpleMail(session,to, subject, content);
		ts.sendMessage(message, message.getAllRecipients());
		ts.close();
	}

	/** * 一封简单的只包含文本的邮件 */
	public static MimeMessage simpleMail(Session session,String to, String subject, String content) throws Exception {
		MimeMessage message = new MimeMessage(session);
		message.setFrom(new InternetAddress(USER));
		message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
		message.setSubject(subject);
		message.setContent(content, "text/html;charset=UTF-8");
		return message;
	}

}
