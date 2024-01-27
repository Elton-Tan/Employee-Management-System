
import com.connection.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.List;
import java.util.concurrent.TimeUnit;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/LeaveRequestAdmin")
public class LeaveRequestAdmin extends HttpServlet {
    int leaveId = 0;
    int empId;
    int a_n = 0,s_n = 0, a_b = 0,s_b = 0;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String userEmail = (String) request.getSession().getAttribute("userEmail");
            System.out.println(userEmail);
             if(userEmail == null)
            {
                response.sendRedirect("Logout"); //if admin is not logged in
            }
            else{
                 LocalDate currentDate = LocalDate.now(); //get today date
                leaveId = Integer.parseInt(request.getParameter("leave_id")); //get the leave id from jsp
                System.out.println(leaveId);
            
                Connection con = DatabaseConnection.getConnection();
                  String query = "SELECT e.name, e.emp_id, lb.leave_id, lb.remark, lb.contact, e.position AS employee_role, "
                        + "e.annual_leave AS annual_balance,e.sick_leave AS sick_balance, "
                        + "lb.type AS leave_type, lb.start, lb.end, lb.nol, lb.reason, lb.action "
                        + "FROM employee e JOIN leavebtl lb ON e.emp_id = lb.emp_id "
                        + "WHERE lb.leave_id = ?";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setInt(1, leaveId);
                ResultSet rs = ps.executeQuery();
                
                if(rs.next())
                {  
                request.getSession().setAttribute("current", currentDate);
                request.getSession().setAttribute("name", rs.getString("name"));
                request.getSession().setAttribute("remark", rs.getString("remark"));
                request.getSession().setAttribute("leaveid", rs.getInt("leave_id"));
                request.getSession().setAttribute("contact", rs.getString("contact"));
                request.getSession().setAttribute("role", rs.getString("employee_role"));
                request.getSession().setAttribute("reason", rs.getString("reason"));
                request.getSession().setAttribute("action", rs.getString("action"));
                String a_start = null, a_end = null, s_start = null, s_end = null;
                empId= rs.getInt("emp_id");
                request.getSession().setAttribute("annual_nol", 0);
                request.getSession().setAttribute("sick_nol", 0);
                
                if(rs.getString("leave_type").equals("Annual"))
                {
                    a_start = rs.getString("start");
                    a_end = rs.getString("end");
                    a_n = rs.getInt("nol");
                    a_b = rs.getInt("annual_balance");
                    s_b = rs.getInt("sick_balance");
                    request.getSession().setAttribute("annual_nol", a_n);
                }
                else{
                    s_start = rs.getString("start");
                    s_end = rs.getString("end");
                    s_n = rs.getInt("nol");
                    s_b = rs.getInt("sick_balance");
                    request.getSession().setAttribute("sick_nol", s_n);
                    a_b = rs.getInt("annual_balance");
                }
                request.getSession().setAttribute("annual_start", a_start);
                request.getSession().setAttribute("annual_end", a_end);
                request.getSession().setAttribute("sick_start", s_start);
                request.getSession().setAttribute("sick_end", s_end);
                request.getSession().setAttribute("annual_balance", a_b);
                request.getSession().setAttribute("sick_balance", s_b);
                }
                RequestDispatcher dispatcher = request.getRequestDispatcher("leave-request-admin.jsp");
                dispatcher.include(request, response); 
             }
            
        } catch (IOException | NumberFormatException | SQLException | ServletException ex) {
            System.out.println(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
             System.out.println(leaveId);
            Connection con = DatabaseConnection.getConnection();
            
             String query = "update leavebtl set action=?, remark=?, doa=? where leave_id=?";
            
            PreparedStatement ps = con.prepareStatement(query);
            String act = req.getParameter("action");
            if(act.equals("Reject"))
            {
                PreparedStatement PS;
                String q;
               if(a_n==0) //if annual leave day is 0 means user took sick leave
               {
                   q = "update employee set sick_leave =? where emp_id = ?";
                   PS = con.prepareStatement(q);
                   System.out.println("sick" + s_n);
                   PS.setInt(1, (s_n+s_b)); //sick number of leaves + sick balance
                   PS.setInt(2, empId);
               }
               else{
                   System.out.println(a_n);
                  q = "update employee set annual_leave =? where emp_id = ?";
                   System.out.println("annual" + a_n);
                   PS = con.prepareStatement(q);
                   PS.setInt(1, (a_n+a_b));//annual number + annual balane
                   PS.setInt(2, empId); 
               }
               int r = PS.executeUpdate();
               if(r>0)
               {
                   System.out.println("Leaves UPDATED AS WELL");
               
               }
            }
            
             LocalDate currentDate = LocalDate.now();
            java.util.Date utilDate = java.sql.Date.valueOf(currentDate);
            a_n = 0; //we reset both the a_n
            s_n =0; // and s_n number
            ps.setString(1, req.getParameter("action"));
            String email =req.getParameter("remark"); 
            ps.setString(2, email);
            ps.setDate(3, new java.sql.Date(utilDate.getTime()));//get today day for date of action
            ps.setInt(4, leaveId);
// Set the date of birth for the ps object
int rowsAffected = ps.executeUpdate();

if (rowsAffected > 0) {
    System.out.println("Update successful");
    try{
        TimeUnit.SECONDS.sleep(3);
        resp.sendRedirect("AdminDashboard");
    } 
    catch (Exception e){
      System.out.println(e);
    }
} else {
    System.out.println("Insert failed");
}           
                      }
            catch (SQLException e) {
            System.out.println(e);
        }
    }
        
    
    
}
