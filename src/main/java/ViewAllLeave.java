
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


@WebServlet("/ViewAllLeave")
public class ViewAllLeave extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    List<Leave> leaveList=  getPendingLeaves();
    req.setAttribute("leaveList", leaveList);
    RequestDispatcher dispatcher = req.getRequestDispatcher("view-all-leave-admin.jsp");
    dispatcher.include(req, resp);
    }
    
    
    public List<Leave> getPendingLeaves() {
        List<Leave> leaves = new ArrayList<>();
        try {
            Connection con = DatabaseConnection.getConnection();
            String query = "SELECT l.leave_id, l.emp_id, e.name, l.start, l.end, l.action, l.dor, l.reason, l.contact " +
                    "FROM leavebtl l " +
                    "JOIN employee e ON l.emp_id = e.emp_id";
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
                leave.setReason(rs.getString("reason"));
                leave.setContact(rs.getString("contact"));
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
