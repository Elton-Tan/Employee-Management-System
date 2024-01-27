import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.connection.DatabaseConnection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.swing.JOptionPane;

@WebServlet("/AddEmployee")
public class AddEmployee extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection con = DatabaseConnection.getConnection(); //get database connection
            // Getting the latest employee ID from the database
            String query = "SELECT MAX(emp_id) AS latestEmpId FROM employee"; 
            PreparedStatement statement = con.prepareStatement(query); //pass query into the connection
            ResultSet resultSet = statement.executeQuery(); //execute query and pass result into variable resultSet

            int latestEmpId = 0;
            if (resultSet.next()) { /*if we can return at least one result
                which we defi can cause we are selecting the empId*/
                latestEmpId = resultSet.getInt("latestEmpId"); //we get the emp ID
            }

            int newEmpId = latestEmpId + 1; //now we add 1 for the auto generated ID

            //now we set the new ID into the newEmpId string in the jsp page
            //u can see it in the jsp it looks like smth like {%newEmpId%}
            request.setAttribute("newEmpId", newEmpId); 
           
          
            //Now we send the value to the jsp page
            request.getRequestDispatcher("add-employee-admin.jsp").forward(request, response);
          
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection con = DatabaseConnection.getConnection(); //connecting to database
            
            // SQL query
            String query = "insert into employee(name,email,dob,gender,address,effective,"
                    + "position,salary,term,password)values(?,?,?,?,?,?,?,?,?,md5(?))";
            
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, request.getParameter("fullname")); //pass fullname into parameter 1
           String email =request.getParameter("fullemail"); 
            
           ps.setString(2, email); /*pass the email var into second parameter
           aka we pass the email value into the second ? in the SQL query*/
          ps.setString(6, request.getParameter("fulldoj"));
            
            
//            int rs = ps.executeUpdate();
String dobString = request.getParameter("fulldob");
String dojString = request.getParameter("fulldoj");
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
Date dob,doj;
            try {
                dob = dateFormat.parse(dobString);
                ps.setDate(3, new java.sql.Date(dob.getTime()));
                ps.setString(4, request.getParameter("fullgender"));
                ps.setString(5, request.getParameter("fulladdress"));
                doj = dateFormat.parse(dojString);
                ps.setDate(6, new java.sql.Date(doj.getTime()));
                ps.setString(7, request.getParameter("fullposition"));
                ps.setInt(8, Integer.parseInt(request.getParameter("fullsalary").substring(1)));
           
           ps.setInt(9, Integer.parseInt( request.getParameter("fullterm").substring(0, request.getParameter("fullterm").length() - 5)));
           
            } catch (ParseException ex) {
                System.out.println(ex);
            }
            String password = request.getParameter("fullpassword");
           ps.setString(10, password);
// Set the date of birth for the ps object
int rowsAffected = ps.executeUpdate();

if (rowsAffected > 0) {
    System.out.println("Insert successful");
    sendMail(email,password);
    request.getSession().setAttribute("successMessage", "Employee has been added successfully");
        response.sendRedirect("add-employee-admin.jsp");
} else {
    System.out.println("Insert failed");
}           
        } catch (SQLException e) {
            //if employee email already exist! SHow error msg
    request.getSession().setAttribute("errorMessage", e.getMessage()+". Rebuilding Form...");
    //redirect to the form
    response.sendRedirect("add-employee-admin.jsp");
}

    }
    
    
    public void sendMail(String email, String password)
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
            message.setSubject("Welcome to the Family");
            
            String Message = "<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" style=\"color:#333;background:#fff;padding:0;margin:0;width:100%;font:15px/1.25em 'Helvetica Neue',Arial,Helvetica\"> <tbody><tr width=\"100%\"> <td valign=\"top\" align=\"left\" style=\"background:#eef0f1;font:15px/1.25em 'Helvetica Neue',Arial,Helvetica\"> <table style=\"border:none;padding:0 18px;margin:50px auto;width:500px\"> <tbody> <tr width=\"100%\" height=\"60\"> <td valign=\"top\" align=\"left\" style=\"border-top-left-radius:4px;border-top-right-radius:4px;background:#bdc3c7 "
                    + "url(https://ci5.googleusercontent.com/proxy/EX6LlCnBPhQ65bTTC5U1NL6rTNHBCnZ9p-zGZG5JBvcmB5SubDn_4qMuoJ-shd76zpYkmhtdzDgcSArG=s0-d-e1-ft#https://trello.com/images/gradient.png) bottom left repeat-x;padding:10px 18px;text-align:center\"> <img height=\"80\" width=\"auto\" "
                    + "src=\"https://media.discordapp.net/attachments/724933427110871055/1119908363506036766/Photo_1687077306144.png?width=702&height=702\" title=\"Trello\" style=\"font-weight:bold;font-size:18px;color:#fff;vertical-align:top\" class=\"CToWUd\"> </td> </tr> <tr width=\"100%\"> <td valign=\"top\" align=\"left\" style=\"background:#fff;padding:18px\">\n" +
"\n" +
" <h1 style=\"font-size:20px;margin:16px 0;color:#333;text-align:center\"> Welcome to ERMS! </h1>\n" +
"\n" +
" <p style=\"font:15px/1.25em 'Helvetica Neue',Arial,Helvetica;color:#333;text-align:center\"> Welcome to our family! Your Account Password is Below: </p>\n" +
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

            System.out.println("sending...");
            // Send message
            Transport.send(message);
            System.out.println("Sent message successfully....");
        } catch (MessagingException mex) {
        }
        
        
    }
    
    
}
