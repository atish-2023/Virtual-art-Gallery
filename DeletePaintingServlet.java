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

@WebServlet("/DeletePaintingServlet")
public class DeletePaintingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/virtualart";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "Atish@1193";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String paintingId = request.getParameter("id");

        if (paintingId != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); 
                try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                     PreparedStatement ps = conn.prepareStatement("DELETE FROM paintings WHERE id = ?")) {
                    
                    ps.setInt(1, Integer.parseInt(paintingId));
                    int rowsDeleted = ps.executeUpdate();

                    if (rowsDeleted > 0) {
                        response.sendRedirect("ManagePaintings.jsp?message=Painting deleted successfully.");
                    } else {
                        response.sendRedirect("ManagePaintings.jsp?message=Painting not found.");
                    }
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                response.sendRedirect("ManagePaintings.jsp?message=Error deleting painting.");
            }
        } else {
            response.sendRedirect("ManagePaintings.jsp?message=Invalid painting ID.");
        }
    }
}
