/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sample.huytq.utils;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;

import javax.mail.internet.MimeMessage;

/**
 *
 * @author HuyRaw
 */
public class MailUtils {

    public static boolean sendMail(String toMail, String content, String informmationShipping, String inforOrder) {
        try {
            final String fromEmail = "trieuhuy19.09@gmail.com";

            final String password = "0963518859w";
            final String subject = "SUPERSTAR - SuperMarket - Your order has been placed!";
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
            props.put("mail.smtp.port", "587"); //TLS Port
            props.put("mail.smtp.auth", "true"); //enable authentication
            props.put("mail.smtp.starttl s.enable", "true"); //enable STARTTLS
            Authenticator auth = new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            };

            Session session = Session.getInstance(props, auth);

            MimeMessage msg = new MimeMessage(session);
            //set message headers
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.addHeader("format", "flowed");
            msg.addHeader("Content-Transfer-Encoding", "8bit");
            msg.setFrom(new InternetAddress(fromEmail, "NoReply-JD"));
            msg.setReplyTo(InternetAddress.parse(fromEmail, false));
            msg.setSubject(subject, "UTF-8");

            msg.setText(informmationShipping +  inforOrder + ". Thong tin don hang: " + content, "UTF-8");

            msg.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(toMail));
            Transport.send(msg);
            System.out.println("Succesfully!!");
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }
}
