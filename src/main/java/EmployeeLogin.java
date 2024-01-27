
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
import javax.servlet.RequestDispatcher;

@WebServlet("/EmployeeLogin")
public class EmployeeLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            //Getting all the parameters from the frontend (admin)
            String email = request.getParameter("email");
            String pass = request.getParameter("password");
            System.out.println(email);

            //Retriving our session
            HttpSession hs = request.getSession();

            //Calling Connection method
            Connection con = DatabaseConnection.getConnection();

           String query = "SELECT * FROM employee WHERE email=? AND password=md5(?)";
            PreparedStatement stmt = con.prepareStatement(query);
            stmt.setString(1, email);
            stmt.setString(2, pass);
            ResultSet rs;
            
            rs = stmt.executeQuery();
            //If all the details are correct
            if (rs.next()) {
                request.getSession().setAttribute("userEmail", email);
                response.sendRedirect("EmployeeProfile");
            } else {
                 String message = "You have enter wrong credentials";
                hs.setAttribute("credential", message);
                response.sendRedirect("login.jsp");
            }
            rs.close();
            stmt.close();
            con.close();
        } catch (IOException | SQLException e) {
            System.out.println(e);
        }
        
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       String userEmail = (String) req.getSession().getAttribute("userEmail");
if (userEmail != null) {
    resp.sendRedirect("EmployeeProfile");
}
else{
   RequestDispatcher dispatcher = req.getRequestDispatcher("login.jsp");
            dispatcher.include(req, resp);
}
    }
    
    
}
