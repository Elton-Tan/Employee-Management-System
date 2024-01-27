
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.connection.DatabaseConnection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;

@WebServlet("/AdminDashboard")
public class AdminDashboard extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String userEmail = (String) request.getSession().getAttribute("userEmail");
            //see if user is logged in
            if(userEmail != null){
            // if user is logged in, print out the email in console log for debug
            System.out.println(userEmail);
            
            //look at getEmployeeList function
            List<Employee> employeeList = getEmployeeList();
            
            // Set the employee list in the request scope
            request.setAttribute("employeeList", employeeList);
           //look at get leave function
            List<Leave> leaveList=  getPendingLeaves();
            request.setAttribute("leaveList", leaveList);
            //get the html from admin-dashboard.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("admin-dashboard.jsp");
            dispatcher.include(request, response);
            }
            else{
                //force admin to logout and return to homepage if unable to obtain session
                response.sendRedirect("Logout");
            }
        } catch (IOException | ServletException ex) {
            System.out.println(ex);
        }
        
    }
public List<Employee> getEmployeeList() {
    List<Employee> employees = new ArrayList<>();
    try {
        Connection con = DatabaseConnection.getConnection(); //get Database connection;
        String query = "SELECT * FROM employee"; //select query
        PreparedStatement ps = con.prepareStatement(query); //pass query into connection
        ResultSet rs = ps.executeQuery();//execute the query and pass the result into variable rs;
        
        while (rs.next()) {
            Employee employee = new Employee(); //create new Obj called employee
            employee.setEmployeeID(rs.getInt("emp_id")); //get employee ID and pass into the OBJ
            employee.setName(rs.getString("name")); //get the name
            employee.setEffectiveDate(rs.getDate("effective"));//the date
            employee.setPosition(rs.getString("position")); //position
            employees.add(employee); //add the obj into the list
        }
        
        rs.close(); //close result
        ps.close(); //close query
        con.close();//close connection
    } catch (SQLException ex) {
        System.out.println(ex);
    }
    return employees;
}


public List<Leave> getPendingLeaves() {
        List<Leave> leaves = new ArrayList<>();
        try {
            Connection con = DatabaseConnection.getConnection();
            String query = "SELECT l.leave_id, l.emp_id, e.name, l.start, l.end, l.action, l.dor " +
                    "FROM leavebtl l " +
                    "JOIN employee e ON l.emp_id = e.emp_id " + 
                    "WHERE l.action = 'Pending'";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Leave leave = new Leave();
                leave.setLeaveId(rs.getInt("leave_id"));
                leave.setEmpId(rs.getInt("emp_id"));
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
