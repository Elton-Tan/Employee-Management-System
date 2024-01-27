import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;
@WebServlet("/Logout")
public class Logout extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the current session
        System.out.println("jkfdskj");
        String email = (String) request.getSession().getAttribute("userEmail"); //remove email from session

        // Invalidate the session if it exists
            request.getSession().removeAttribute("userEmail");
            response.sendRedirect("home.jsp");
 

        // Redirect the user to the login page
        
    }
}
