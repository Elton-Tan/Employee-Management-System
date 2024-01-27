
import com.connection.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.*;
import java.util.Properties;
import java.util.Random;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Forgot")
public class Forgot extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("forgot.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Connection con = DatabaseConnection.getConnection();
            String query = "select emp_id from employee where email =?";
            PreparedStatement ps = con.prepareStatement(query);
            String email =request.getParameter("email"); //get the email from the front end
            HttpSession hs = request.getSession();
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) //check if email exist in the database
            {
               String pa = updatePassword(rs.getInt("emp_id"));
               if(sendMail(email,pa)) //if yes we send the email
               {
                String message = "sent";
                hs.setAttribute("success", message); //show success msg
                response.sendRedirect("forgot.jsp"); //redirect back to forgot.jsp
               }
             
            }
            else { //if email not in our database
                System.out.println("hi");
                String message = "Your email address is not in our database";
                hs.setAttribute("credential", message); //show error msg
                response.sendRedirect("forgot.jsp");
            }
        } catch (SQLException e) {
            System.out.println(e);
}
    }
    public String updatePassword(int id){
        String pa = null;
        try{
              Connection con = DatabaseConnection.getConnection();
            
            String query = "update employee set password = md5(?) where emp_id = ?"; //update our password
            PreparedStatement ps = con.prepareStatement(query);
            pa= generatePassword(); //look at generate password func
            ps.setString(1,pa);
            ps.setInt(2,id);
            int r = ps.executeUpdate(); //execute query and update table
            if(r>0)
            {
                System.out.println("PASSWORD UPDATED");
            }
            

        }
        catch(SQLException ex)
        {
            System.out.println(ex);
        }
        return pa;
    }
    
    public String generatePassword()
    {
        int length = 10;
        String charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()";
        String password = "";

        Random random = new Random(); //random string from the list of charset

        for (int i = 0; i < length; i++) {
            int randomIndex = random.nextInt(charset.length());
            password += charset.charAt(randomIndex);
        }
        return password;
    }
    
    public boolean sendMail(String email, String password)
    {
        // email ID of Recipient.
     
        
     String from = "ermsco1@gmail.com";

      // Assuming you are sending email from localhost
      String host = "smtp.gmail.com";

      // Get system properties
        Properties properties = System.getProperties();

        // Setup mail server
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", "465");
        properties.put("mail.smtp.ssl.enable", "true");
        properties.put("mail.smtp.auth", "true");

        // Get the Session object.// and pass username and password
        Session session = Session.getInstance(properties, new javax.mail.Authenticator() {

            @Override
            protected PasswordAuthentication getPasswordAuthentication() {

                return new PasswordAuthentication(from, "stabmqkkorkptuny");

            }

        });

        // Used to debug SMTP issues
        session.setDebug(true);

        try {
            // Create a default MimeMessage object.
            MimeMessage message = new MimeMessage(session);

            // Set From: header field of the header.
            message.setFrom(new InternetAddress(from));

            // Set To: header field of the header.
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));

            // Set Subject: header field
            message.setSubject("Forgot Password");
            String Message = "<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"color:#333;background:#fff;padding:0;margin:0;width:100%;font:15px/1.25em 'Helvetica Neue',Arial,Helvetica\"> <tbody><tr width=\"100%\"> <td valign=\"top\" align=\"left\" style=\"background:#eef0f1;font:15px/1.25em 'Helvetica Neue',Arial,Helvetica\"> <table style=\"border:none;padding:0 18px;margin:50px auto;width:500px\"> <tbody> <tr width=\"100%\" height=\"60\"> <td valign=\"top\" align=\"left\" style=\"border-top-left-radius:4px;border-top-right-radius:4px;background:#bdc3c7 "
                    + "url(https://ci5.googleusercontent.com/proxy/EX6LlCnBPhQ65bTTC5U1NL6rTNHBCnZ9p-zGZG5JBvcmB5SubDn_4qMuoJ-shd76zpYkmhtdzDgcSArG=s0-d-e1-ft#https://trello.com/images/gradient.png) bottom left repeat-x;padding:10px 18px;text-align:center\"> <img height=\"80\" width=\"auto\" "
                    + "src=\"https://media.discordapp.net/attachments/724933427110871055/1119908363506036766/Photo_1687077306144.png?width=702&height=702\" title=\"Trello\" style=\"font-weight:bold;font-size:18px;color:#fff;vertical-align:top\" class=\"CToWUd\"> </td> </tr> <tr width=\"100%\"> <td valign=\"top\" align=\"left\" style=\"background:#fff;padding:18px\">\n" +
"\n" +
" <h1 style=\"font-size:20px;margin:16px 0;color:#333;text-align:center\"> Forgot Password </h1>\n" +
"\n" +
" <p style=\"font:15px/1.25em 'Helvetica Neue',Arial,Helvetica;color:#333;text-align:center\"> Seems like you have forgot your password. But don't worry, your new password is below: </p>\n" +
"\n" +
" <div style=\"background:#f6f7f8;border-radius:3px\"> <br>\n" +
"\n" +
" <p style=\"text-align:center\"> <a href=\"#\" style=\"color:#306f9c;font:26px/1.25em 'Helvetica Neue',Arial,Helvetica;text-decoration:none;font-weight:bold\" target=\"_blank\">"+password+"</a> </p>\n" +
"\n" +
" <p style=\"font:15px/1.25em 'Helvetica Neue',Arial,Helvetica;margin-bottom:0;text-align:center\"> <a href=\"http://localhost:8080/maven_project_ERMS_v3/login.jsp\" style=\"border-radius:3px;background:#3aa54c;color:#fff;display:block;font-weight:700;font-size:16px;line-height:1.25em;margin:24px auto 6px;padding:10px 18px;text-decoration:none;width:180px\" target=\"_blank\"> Login Now</a> </p>\n" +
"\n" +
" <br><br> </div>\n" +
"\n" +
" <p style=\"font:14px/1.25em 'Helvetica Neue',Arial,Helvetica;color:#333\"> <strong>Please use this email account and the assigned password to login</strong></p>\n" +
"\n" +
" </td>\n" +
"\n" +
" </tr>\n" +
"\n" +
" </tbody> </table> </td> </tr></tbody> </table>";
            // Now set the actual message
            message.setContent(Message,"text/html");
            // Now set the actual message
            

            System.out.println("sending...");
            // Send message
            Transport.send(message);
            System.out.println("Sent message successfully....");
            
        } catch (MessagingException mex) {
        }
        return true;
        
    } 
}
