
import com.connection.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/EmployeeProfile")
public class EmployeeProfile extends HttpServlet {
    int empId;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String userEmail = (String) request.getSession().getAttribute("userEmail");
            System.out.println(userEmail);
            if (userEmail != null) { //check if user has logged in
                System.out.println("kdfhijhn");
                Connection con = DatabaseConnection.getConnection();
                String query = "SELECT * FROM employee WHERE email=?";//select query
                PreparedStatement stmt = con.prepareStatement(query);
                stmt.setString(1, userEmail);//pass the email into the ?
                ResultSet rs;
                rs = stmt.executeQuery();//execute the query and pass result into rs
                if (rs.next()) {//now we get all the info
                empId = rs.getInt("emp_id");
                request.getSession().setAttribute("userEmail", rs.getString("email"));
                request.getSession().setAttribute("name", rs.getString("name"));
                request.getSession().setAttribute("annual", rs.getInt("annual_leave"));
                request.getSession().setAttribute("sick", rs.getInt("sick_leave"));
                request.getSession().setAttribute("role", rs.getString("position"));
                request.getSession().setAttribute("join", rs.getDate("effective"));
                    System.out.println(request.getSession().getAttribute("annual"));
                    
                    
                     List<Leave> leaveList=  getPendingLeaves(); //look at pending leave function
    request.setAttribute("leaveList", leaveList);
    List<Leave> leaveList1=  getOtherLeaves();    //look at getotherleaves
    request.setAttribute("leaveList1", leaveList1);
//                response.sendRedirect("employee-profile.jsp");
RequestDispatcher dispatcher = request.getRequestDispatcher("employee-profile.jsp");
            dispatcher.include(request, response);

                }
            }
            else{
               response.sendRedirect("home.jsp"); //redirect back to home if he noh login
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        
        
    }
  public List<Leave> getPendingLeaves() { //get pending leave
        List<Leave> leaves = new ArrayList<>();
        try {
            Connection con = DatabaseConnection.getConnection();
            String query = "SELECT l.leave_id, l.emp_id, e.name, l.start,l.type, l.end, l.action, l.dor " +
                    "FROM leavebtl l " +
                    "JOIN employee e ON l.emp_id = e.emp_id " +
                    "WHERE l.action = 'Pending' and l.emp_id = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, empId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Leave leave = new Leave();
                leave.setLeaveId(rs.getInt("leave_id"));
                leave.setEmpId(rs.getInt("emp_id"));
                leave.setType(rs.getString("type"));
                leave.setEmpName(rs.getString("name"));
                leave.setStartDate(rs.getDate("start"));
                leave.setEndDate(rs.getDate("end"));
                leave.setAction(rs.getString("action"));
                leave.setDateOfRequest(rs.getDate("dor"));
                leaves.add(leave);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return leaves;
    }


    public List<Leave> getOtherLeaves() //get approved or reject leave
    {
        List<Leave> leaves = new ArrayList<>();
        try {
            Connection con = DatabaseConnection.getConnection();
            String query = "SELECT l.leave_id, l.emp_id, e.name, l.start, l.type, l.end, l.action, l.dor " +
               "FROM leavebtl l " +
               "JOIN employee e ON l.emp_id = e.emp_id " +
               "WHERE (l.action = 'Approve' OR l.action = 'Reject') AND l.emp_id = ?";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, empId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Leave leave = new Leave();
                leave.setLeaveId(rs.getInt("leave_id"));
                leave.setEmpId(rs.getInt("emp_id"));
                leave.setType(rs.getString("type"));
                leave.setEmpName(rs.getString("name"));
                leave.setStartDate(rs.getDate("start"));
                leave.setEndDate(rs.getDate("end"));
                leave.setAction(rs.getString("action"));
                leave.setDateOfRequest(rs.getDate("dor"));
                leaves.add(leave);
            }

            rs.close();
            ps.close();
            con.close();
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return leaves;
    }
}

