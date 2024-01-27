
import com.connection.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;

@WebServlet("/ViewLeaveEmployee")
public class ViewLeaveEmployee extends HttpServlet{
    int leaveId;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String userEmail = (String) request.getSession().getAttribute("userEmail");
            if(userEmail == null)
            {
                response.sendRedirect("Logout");
            }
            else{
            leaveId = Integer.parseInt(request.getParameter("leave_id"));
            if(leaveId != 0)
            {  
            Connection con = DatabaseConnection.getConnection();
            String query = "SELECT e.name, lb.leave_id, lb.contact, e.position AS employee_role, "
                        + "e.annual_leave AS annual_balance,e.sick_leave AS sick_balance, "
                        + "lb.type AS leave_type, lb.start, lb.end, lb.nol, lb.reason,  "
                        + "lb.action,lb.remark,lb.doa FROM employee e JOIN leavebtl lb ON e.emp_id = lb.emp_id "
                        + "WHERE lb.leave_id = ?";
                PreparedStatement ps = con.prepareStatement(query);
                ps.setInt(1, leaveId);
                ResultSet rs = ps.executeQuery();
                
                if(rs.next())
                {  
                request.getSession().setAttribute("name", rs.getString("name"));
                request.getSession().setAttribute("leaveid", rs.getInt("leave_id"));
                request.getSession().setAttribute("contact", rs.getString("contact"));
                request.getSession().setAttribute("role", rs.getString("employee_role"));
                request.getSession().setAttribute("reason", rs.getString("reason"));
                String a_start = null, a_end = null, s_start = null, s_end = null;
                int a_n = 0,s_n = 0, a_b = 0,s_b = 0;
                if(rs.getString("leave_type").equals("Annual")) //check if employee took annual leave
                {
                    a_start = rs.getString("start");
                    a_end = rs.getString("end");
                    a_n = rs.getInt("nol");
                    a_b = rs.getInt("annual_balance");
                    s_b = rs.getInt("sick_balance");
                }
                else{ //if not annual then is sick leave
                    s_start = rs.getString("start");
                    s_end = rs.getString("end");
                    s_n = rs.getInt("nol");
                    s_b = rs.getInt("sick_balance");
                    a_b = rs.getInt("annual_balance");
                }
                request.getSession().setAttribute("annual_start", a_start);
                request.getSession().setAttribute("annual_end", a_end);
                request.getSession().setAttribute("sick_start", s_start);
                request.getSession().setAttribute("sick_end", s_end);
                request.getSession().setAttribute("annual_nol", a_n);
                request.getSession().setAttribute("action", rs.getString("action"));
                request.getSession().setAttribute("doa", rs.getString("doa"));
                request.getSession().setAttribute("remark", rs.getString("remark"));
                request.getSession().setAttribute("sick_nol", s_n);
                request.getSession().setAttribute("annual_balance", a_b);
                request.getSession().setAttribute("sick_balance", s_b);
                }
                RequestDispatcher dispatcher = request.getRequestDispatcher("pending-employee-view.jsp");
                dispatcher.include(request, response); 
             }
            }
        } catch (IOException | NumberFormatException | SQLException | ServletException ex) {
            System.out.println(ex);
        }
        
        
    }
}
