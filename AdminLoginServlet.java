package in.sp.backend;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            System.out.println("Connecting to Database...");

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/virtualart", "root", "Atish@1193");

            System.out.println("Connection Successful!");

            PreparedStatement pst = con.prepareStatement(
                "SELECT * FROM admin WHERE email = ? AND password = ?");
            pst.setString(1, email);
            pst.setString(2, password);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                System.out.println("Login Successful for Admin: " + email);
                HttpSession session = request.getSession();
                session.setAttribute("admin_email", email);
                response.sendRedirect("adminindex.jsp");
            } else {
                System.out.println("Invalid Credentials!");
                response.sendRedirect("adminlogin.jsp?error=Invalid Credentials");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
