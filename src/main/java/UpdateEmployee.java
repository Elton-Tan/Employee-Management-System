import com.connection.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.RequestDispatcher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateEmployee")
public class UpdateEmployee extends HttpServlet{ //get all of the employee info
    int empId;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String userEmail = (String) request.getSession().getAttribute("userEmail");
            if(userEmail == null)
            {
                response.sendRedirect("Logout");
            }
            else{
            empId = 0;
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
                request.getSession().setAttribute("annual", rs.getInt("annual_leave"));
                request.getSession().setAttribute("sick", rs.getInt("sick_leave"));
                request.getSession().setAttribute("role", rs.getString("position"));
                request.getSession().setAttribute("salary", rs.getInt("salary"));
                request.getSession().setAttribute("term", rs.getInt("term"));
                request.getSession().setAttribute("id", rs.getInt("emp_id"));
                RequestDispatcher dispatcher = request.getRequestDispatcher("update-employee-detail.jsp");
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

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
         try {
             System.out.println(empId);
            Connection con = DatabaseConnection.getConnection();
            
            String query = "update employee set name=?, email=?, dob=?, gender=?, "
                    + "address=?, effective=?,"
                    + " position=?, salary=?, term = ? where emp_id=?";
            
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, req.getParameter("fullname"));
            String email =req.getParameter("fullemail"); 
            ps.setString(2, email);

//            int rs = ps.executeUpdate();
String dobString = req.getParameter("fulldob");
String dojString = req.getParameter("fulldoj");
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
java.util.Date dob,doj;
            try {
                dob = dateFormat.parse(dobString); //convert into date format
                
                ps.setDate(3, new java.sql.Date(dob.getTime()));
                ps.setString(4, req.getParameter("fullgender"));
                ps.setString(5, req.getParameter("fulladdress"));
                doj = dateFormat.parse(dojString); //convert into date format;
                ps.setDate(6, new java.sql.Date(doj.getTime()));
                ps.setString(7, req.getParameter("fullposition"));
                ps.setInt(8, Integer.parseInt(req.getParameter("fullsalary")));
           
           ps.setInt(9, Integer.parseInt( req.getParameter("fullterm")));
           ps.setInt(10, empId);
            } catch (ParseException ex) {
                System.out.println(ex);
            }

int rowsAffected = ps.executeUpdate();

if (rowsAffected > 0) {
    System.out.println("Update successful");
    resp.sendRedirect("AdminDashboard");
} else {
    System.out.println("Insert failed");
}           
        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    
}
