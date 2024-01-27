import com.connection.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.sql.*;
import javax.servlet.RequestDispatcher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ReadEmployeeAdmin")
public class ReadEmployeeAdmin extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String userEmail = (String) request.getSession().getAttribute("userEmail");
            if(userEmail == null) //check if session has email aka user has logged in
            {
                response.sendRedirect("Logout");
            }
            else{
            int empId = 0; //just ignore this line
                    empId = Integer.parseInt(request.getParameter("emp_id"));
            if(empId != 0)
            {
               
            System.out.println(userEmail);
            System.out.println(empId+"fsfsfasf\n");
            Connection con = DatabaseConnection.getConnection();
            String query = "SELECT * FROM employee WHERE emp_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, empId);
            ResultSet rs = ps.executeQuery();
            if(rs.next())
            {
                request.getSession().setAttribute("userEmail", rs.getString("email"));
                request.getSession().setAttribute("name", rs.getString("name"));
                request.getSession().setAttribute("dob", rs.getString("dob"));
                request.getSession().setAttribute("gender", rs.getString("gender"));
                request.getSession().setAttribute("address", rs.getString("address"));
                request.getSession().setAttribute("effective", rs.getDate("effective"));
                request.getSession().setAttribute("annual", (rs.getInt("annual_leave")+" Days"));
                request.getSession().setAttribute("sick", (rs.getInt("sick_leave")+" Days"));
                request.getSession().setAttribute("role", rs.getString("position"));
                request.getSession().setAttribute("salary", "$"+rs.getInt("salary"));
                request.getSession().setAttribute("term", rs.getInt("term")+"years");
                request.getSession().setAttribute("id", rs.getInt("emp_id"));
                RequestDispatcher dispatcher = request.getRequestDispatcher("read-employee-admin.jsp");
                dispatcher.include(request, response);   
            }

            }
            else{
                response.sendRedirect("AdminDashboard");
            }
            }
        } catch (IOException | NumberFormatException | SQLException | ServletException ex) {
            System.out.println(ex);
        }
        
        
    }
}
