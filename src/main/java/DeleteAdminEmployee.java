
import com.connection.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.concurrent.TimeUnit;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DeleteAdminEmployee")
public class DeleteAdminEmployee extends HttpServlet{ 
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
            empId = Integer.parseInt(request.getParameter("emp_id"));
            if(empId != 0)
            {
            System.out.println(userEmail);
            System.out.println(empId+" delete me ghussa hu\n");
            Connection con = DatabaseConnection.getConnection();
            String query = "SELECT * FROM employee WHERE emp_id=?"; //get all the info of the empployee u want to delete
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, empId);
            ResultSet rs = ps.executeQuery();
            if(rs.next())
            {
                 //now we start to display the employee
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
                RequestDispatcher dispatcher = request.getRequestDispatcher("delete-admin-employee.jsp");
                dispatcher.include(request, response);   
            }

            }
            else{
                response.sendRedirect("AdminDashboard");//redirect if there is error
            }
            }
        } catch (IOException | NumberFormatException | SQLException | ServletException ex) {
            System.out.println(ex);
        }
        
        
    }

   @Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    try {
        System.out.println("DELETE PAGE\n\n\n\n" + empId);
        Connection con = DatabaseConnection.getConnection();
        String query1 = "delete from leavebtl where emp_id = ?"; //dont forget to delete the leaves he requested too
        String query = "delete from employee where emp_id = ?";
        
        PreparedStatement ps = con.prepareStatement(query);
        PreparedStatement ps1 = con.prepareStatement(query1);
        ps.setInt(1, empId);
        ps1.setInt(1, empId);
        int rowsAffected1 = ps1.executeUpdate();
        int rowsAffected = ps.executeUpdate();
        if (rowsAffected1 > 0 && rowsAffected >0) { //if u deleted 1 employee and at least 1 leave
        try{
        TimeUnit.SECONDS.sleep(3);//we let the system pause for 3 seconds to show the delete success msg
        System.out.println("DELETED");
        resp.sendRedirect("AdminDashboard");
    } 
        catch (Exception e){
        System.out.println(e);
    }     
        }
        
        else {   //if 1 employee is deleted and no leaves are deleted  
        try{
        TimeUnit.SECONDS.sleep(3);
        resp.sendRedirect("AdminDashboard");
    } 
        catch (Exception e){
        System.out.println(e);
    }
           
        }
    } catch (NumberFormatException | SQLException ex) {
        System.out.println(ex);
    }
}


}
