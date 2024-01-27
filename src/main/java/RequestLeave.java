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
import java.time.LocalDate;
import java.util.Date;
import java.util.Properties;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/RequestLeave")
public class RequestLeave extends HttpServlet{
int emp_id,sick,annual;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String userEmail = (String) request.getSession().getAttribute("userEmail");
         if (userEmail != null) {
                System.out.println(userEmail);
        try {
            Connection con = DatabaseConnection.getConnection();
            // Getting the latest leave ID from the database
            String query = "SELECT MAX(leave_id) AS latestLeaveId FROM leavebtl";
            String query2 = "SELECT * from employee where email = ?";
            PreparedStatement statement2 = con.prepareStatement(query2);
            statement2.setString(1, userEmail);
            PreparedStatement statement = con.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();
            ResultSet resultSet1 = statement2.executeQuery();
            
            int latestEmpId = 0;
            if (resultSet.next()) {
                latestEmpId = resultSet.getInt("latestLeaveId");
                System.out.println(latestEmpId);
            }
            if(resultSet1.next())
            {
                annual = resultSet1.getInt("annual_leave");
                sick = resultSet1.getInt("sick_leave");
                request.getSession().setAttribute("name", resultSet1.getString("name"));
                request.getSession().setAttribute("annual", resultSet1.getInt("annual_leave"));
                request.getSession().setAttribute("sick", resultSet1.getInt("sick_leave"));
                request.getSession().setAttribute("role", resultSet1.getString("position"));
                emp_id = resultSet1.getInt("emp_id");
            }

            int newEmpId = latestEmpId + 1; //set new leave ID + 1 i used empID cuz i copied and paste my bad hahaha

            // Setting the newEmpId as a request attribute
            request.setAttribute("newLeaveId", newEmpId);

            // Forwarding the request to the JSP page
            request.getRequestDispatcher("employee-request-leave.jsp").forward(request, response);
        } catch (SQLException e) {
            System.out.println(e);
        }
                    }
         else{
             response.sendRedirect("Logout");//logout if user is not logged in
         }  
    }
    
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Connection con = DatabaseConnection.getConnection();
            
            String query = "insert into leavebtl(emp_id,type,start,end,nol,reason,action,"
                    + "dor,remark,contact)values(?,?,?,?,?,?,?,?,?,?)";
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String an_start=null; 
            String si_start=null;
            si_start = request.getParameter("si_start");
            an_start= request.getParameter("an_start");
            int nod = 0;
            Date si_s = null,an_s = null,an_e = null,si_e = null;
            if(an_start != null && (si_start == null|| "".equals(si_start))) //if user takes annual leave
            {
                
                try {
                     an_s = dateFormat.parse(an_start); //get leave start date
                     System.out.println(an_s);
                    String an_end = request.getParameter("an_end");
                     an_e = dateFormat.parse(an_end);//get leave end date
                    nod = Integer.parseInt(request.getParameter("an_no")); //get numbah of leaves taken
                } catch (ParseException ex) {
                    Logger.getLogger(RequestLeave.class.getName()).log(Level.SEVERE, null, ex);
                }
            
            }
            else
            {
               try {
                     si_s = dateFormat.parse(si_start);//get sick leave start date
                    String si_end = request.getParameter("si_end"); //get sick leave end date 
                    System.out.println("heree go bc");
                     si_e = dateFormat.parse(si_end); //parse it into date type
                    nod = Integer.parseInt(request.getParameter("si_no")); //get number of leaves
                } catch (ParseException ex) {
                    Logger.getLogger(RequestLeave.class.getName()).log(Level.SEVERE, null, ex);
                } 
            }
            String reason = request.getParameter("reason"); //get reason for taking leave
            String update;
            PreparedStatement psUpdate = null;
            
           
            LocalDate currentDate = LocalDate.now();
            java.util.Date utilDate = java.sql.Date.valueOf(currentDate); //get today date
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, emp_id); 
            if(si_start != null && (an_start == null|| "".equals(an_start))){ //if is sick leave
                System.out.println("hereee\n"
                        + "\n\n\n\n\n");
                ps.setString(2, "Sick");
                if(sick>=nod) //check if number of sick leaves taken is more than what user have
                {
                   ps.setDate(3, new java.sql.Date(si_s.getTime()));
                   ps.setDate(4,new java.sql.Date(si_e.getTime()));
                    
                 update = "update employee set sick_leave = ? where emp_id = ?";
                 psUpdate = con.prepareStatement(update);
                 psUpdate.setInt(1, (sick-nod)); //set sick leave - number of leave taken
                 psUpdate.setInt(2, emp_id);
                }
            }
            else{ //if user is not taking sick leave then he is taking annual leave
                ps.setString(2, "Annual");
                if(annual>=nod) //check if annual leave user has is more than what he takes
                {
                   ps.setDate(3, new java.sql.Date(an_s.getTime()));
                   ps.setDate(4,new java.sql.Date(an_e.getTime()));
                   update = "update employee set annual_leave = ? where emp_id = ?";
                   psUpdate = con.prepareStatement(update);
                   psUpdate.setInt(1, (annual-nod)); //subtract number of days taken from what he has
                   psUpdate.setInt(2, emp_id);
                }
            }
            
             ps.setInt(5, nod);
             ps.setString(6, reason);
             ps.setString(7, "Pending");
             ps.setDate(8, new java.sql.Date(utilDate.getTime()));
             ps.setString(9, "");
             ps.setString(10, request.getParameter("contact"));
            
int rowsAffected = ps.executeUpdate();

if (rowsAffected > 0) {
    System.out.println("Leave Applied successful");
    int rs = psUpdate.executeUpdate();
    if(rs>0)
    {
        System.out.println("ALL good!");
        
        try {
        TimeUnit.SECONDS.sleep(3);
        response.sendRedirect("EmployeeProfile");
        }
        
        catch(Exception e) {
        
        }
    }
    
   
} else {
    System.out.println("Insert failed");
}           
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
}
