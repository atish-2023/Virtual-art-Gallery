package in.sp.backend;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String paintingId = request.getParameter("paintingId");

        if (paintingId != null && !paintingId.isEmpty()) {
            try {
                int id = Integer.parseInt(paintingId); // Convert to integer

                // Database connection details
                String jdbcURL = "jdbc:mysql://localhost:3306/virtualart";
                String dbUser = "root";
                String dbPassword = "Atish@1193";

                try (Connection con = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                     PreparedStatement pst = con.prepareStatement("SELECT * FROM paintings WHERE id = ?")) {

                    pst.setInt(1, id);
                    ResultSet rs = pst.executeQuery();

                    if (rs.next()) {
                        HttpSession session = request.getSession();

                        // Store painting details in the cart session for better tracking
                        session.setAttribute("cart_" + paintingId, rs.getString("title"));
                        session.setAttribute("cart_price_" + paintingId, rs.getBigDecimal("price"));

                        response.sendRedirect("user.jsp?success=Item added to cart successfully.");
                    } else {
                        response.sendRedirect("user.jsp?error=Painting not found.");
                    }
                }

            } catch (NumberFormatException e) {
                response.sendRedirect("user.jsp?error=Invalid Painting ID format.");
            } catch (SQLException e) {
                response.sendRedirect("user.jsp?error=Database error: " + e.getMessage());
            }

        } else {
            response.sendRedirect("user.jsp?error=Invalid Painting ID.");
        }
    }
}
