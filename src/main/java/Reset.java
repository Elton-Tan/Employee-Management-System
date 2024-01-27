
import com.connection.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.*;
import java.util.Properties;
import java.util.Random;
import java.util.concurrent.TimeUnit;
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

@WebServlet("/Reset")
public class Reset extends HttpServlet{
String userEmail;
String newP,confirm;
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       //checking session see if user logged in... again
        userEmail = (String) req.getSession().getAttribute("userEmail"); 
        if(userEmail == null)
        {
            resp.sendRedirect("Logout");//if no login then logout him
        }else{
        resp.sendRedirect("reset.jsp");
        }
        }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Connection con = DatabaseConnection.getConnection();
            String pass = request.getParameter("current"); //get current pass value
            HttpSession hs = request.getSession();
            userEmail = (String) request.getSession().getAttribute("userEmail");  //get their email
            newP = request.getParameter("newpass"); //get new pass
            confirm = request.getParameter("confirm");/// get their cfm pass
            String query = "SELECT * FROM employee WHERE email=? AND password=md5(?)";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, userEmail);
            stmt.setString(2, pass);
            System.out.println(pass);
            ResultSet rs;
            
            rs = stmt.executeQuery();
            if(rs.next()) // if current password entered is correctt
            {
               if(checkedPassword()) //if cfm password = new pass
               {
                   if(updatePassword(userEmail,confirm)) //we update the sql
                   {
                       String message = "success";
                       hs.setAttribute("success", message);//show success msg
                       response.sendRedirect("reset.jsp");
                       sendMail(userEmail);// and send a mail to tell them they reset password recently
                       try {
                           
                       }
                       
                       catch (Exception e) {
                           System.out.println("ERROR FAIL DEBUG MEEE");
                       }
                       
                   }
               }
            }
            else{ //if their password is not correct
                String message = "Your Current Password is incorrect"; 
                hs.setAttribute("credential", message); //we show error msg
                response.sendRedirect("reset.jsp");
          
            }
        } catch (SQLException e) {
            System.out.println(e);
}
    }
    public boolean updatePassword(String email, String pa){
        boolean done = false;
        try{
            Connection con = DatabaseConnection.getConnection();
            String query = "update employee set password = md5(?) where email = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1,pa);
            ps.setString(2,email);
            int r = ps.executeUpdate();
            if(r>0)
            {
                System.out.println("PASSWORD UPDATED");
                done = true;
            }
            else{
                done = false;
            }
            return done;
        }
        catch(SQLException ex)
        {
            System.out.println(ex);
        }
        return done;
    }
    
    public boolean checkedPassword()
    {
        boolean check = false;//we are checking if new pass = cfm pass
       if((newP != null & confirm != null) && newP.equals(confirm)){ //our frontend will have validate
           check = true; //but is always good to catch errors in backend too
       }
       else{
           check = false;
       }
        return check;
    }
    
    public boolean sendMail(String email)
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
            message.setSubject("Reset Password Successful");

            // Now set the actual message with the EMAIL TEMPLATE
                        String Message = "<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"color:#333;background:#fff;padding:0;margin:0;width:100%;font:15px/1.25em 'Helvetica Neue',Arial,Helvetica\"> <tbody><tr width=\"100%\"> <td valign=\"top\" align=\"left\" style=\"background:#eef0f1;font:15px/1.25em 'Helvetica Neue',Arial,Helvetica\"> <table style=\"border:none;padding:0 18px;margin:50px auto;width:500px\"> <tbody> <tr width=\"100%\" height=\"60\"> <td valign=\"top\" align=\"left\" style=\"border-top-left-radius:4px;border-top-right-radius:4px;background:#bdc3c7 "
                    + "url(https://ci5.googleusercontent.com/proxy/EX6LlCnBPhQ65bTTC5U1NL6rTNHBCnZ9p-zGZG5JBvcmB5SubDn_4qMuoJ-shd76zpYkmhtdzDgcSArG=s0-d-e1-ft#https://trello.com/images/gradient.png) bottom left repeat-x;padding:10px 18px;text-align:center\"> <img height=\"80\" width=\"auto\" "
                    + "src=\"https://media.discordapp.net/attachments/724933427110871055/1119908363506036766/Photo_1687077306144.png?width=702&height=702\" title=\"Trello\" style=\"font-weight:bold;font-size:18px;color:#fff;vertical-align:top\" class=\"CToWUd\"> </td> </tr> <tr width=\"100%\"> <td valign=\"top\" align=\"left\" style=\"background:#fff;padding:18px\">\n" +
"\n" +
" <h1 style=\"font-size:20px;margin:16px 0;color:#333;text-align:center\"> Password Reset </h1>\n" +
"\n" +
" <p style=\"font:15px/1.25em 'Helvetica Neue',Arial,Helvetica;color:#333;text-align:center\"> Hi! You have recently reset your password! </p>\n" +
"\n" +
" <div style=\"background:#f6f7f8;border-radius:3px\"> <br>\n" +
"\n" +
" <p style=\"text-align:center\"> <a href=\"#\" style=\"color:#306f9c;font:26px/1.25em 'Helvetica Neue',Arial,Helvetica;text-decoration:none;font-weight:bold\" target=\"_blank\"></a> </p>\n" +
"\n" +
" <p style=\"font:15px/1.25em 'Helvetica Neue',Arial,Helvetica;margin-bottom:0;text-align:center\"> <a href=\"http://localhost:8080/maven_project_ERMS_v3/login.jsp\" style=\"border-radius:3px;background:#3aa54c;color:#fff;display:block;font-weight:700;font-size:16px;line-height:1.25em;margin:24px auto 6px;padding:10px 18px;text-decoration:none;width:180px\" target=\"_blank\"> Login Now</a> </p>\n" +
"\n" +
" <br><br> </div>\n" +
"\n" +
" <p style=\"font:14px/1.25em 'Helvetica Neue',Arial,Helvetica;color:#333\"> <strong>If you did not reset the password, please contact <a>+63 987 654 3211 </a> immediately</strong></p>\n" +
"\n" +
" </td>\n" +
"\n" +
" </tr>\n" +
"\n" +
" </tbody> </table> </td> </tr></tbody> </table>";
            // Now set the actual message
            message.setContent(Message,"text/html");

            System.out.println("sending...");
            // Send message
            Transport.send(message);
            System.out.println("Sent message successfully....");
            
        } catch (MessagingException mex) {
        }
        return true;
        
    } 
}
