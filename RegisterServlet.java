package in.sp.backend;  // Corrected Package Declaration

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Retrieving form data
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");

        // Password confirmation check
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=Passwords do not match");
            return;
        }

        // Database credentials and URL
        String jdbcURL = "jdbc:mysql://localhost:3306/virtualart?useSSL=false&serverTimezone=UTC";
        String dbUser = "root";
        String dbPassword = "Atish@1193";

        Connection con = null;
        PreparedStatement pst = null;

        try {
            // Load MySQL Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish Database Connection
            con = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Check if email is already registered
            String checkUserQuery = "SELECT * FROM users WHERE email = ?";
            pst = con.prepareStatement(checkUserQuery);
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                response.sendRedirect("register.jsp?error=Email already registered");
                return;
            }

            // Insert new user data
            String insertQuery = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, 'User')";
            pst = con.prepareStatement(insertQuery);
            pst.setString(1, username);
            pst.setString(2, email);
            pst.setString(3, password);

            int rowCount = pst.executeUpdate();

            // Success or failure response
            if (rowCount > 0) {
                response.sendRedirect("login.jsp?success=Registration successful. Please login.");
            } else {
                response.sendRedirect("register.jsp?error=Registration failed. Try again.");
            }

        } catch (ClassNotFoundException e) {
            out.println("<h3 style='color: red;'>Error: MySQL Driver not found. Ensure the JAR is added.</h3>");
        } catch (SQLException e) {
            out.println("<h3 style='color: red;'>Database Error: " + e.getMessage() + "</h3>");
        } catch (Exception e) {
            out.println("<h3 style='color: red;'>Unexpected Error: " + e.getMessage() + "</h3>");
        } finally {
            try {
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
