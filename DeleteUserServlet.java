import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/virtualart";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Atish@1193";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userId = request.getParameter("id");

        if (userId != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL driver
                Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                String sql = "DELETE FROM users WHERE user_id = ?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(userId));

                int rowsDeleted = ps.executeUpdate();
                ps.close();
                conn.close();

                if (rowsDeleted > 0) {
                    request.setAttribute("message", "User deleted successfully.");
                } else {
                    request.setAttribute("message", "User not found.");
                }

            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                request.setAttribute("message", "Error deleting user.");
            }
        }

        response.sendRedirect("manageusers.jsp");
    }
}
