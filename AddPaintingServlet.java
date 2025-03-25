package in.sp.backend;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.*;
import jakarta.servlet.http.*;

@MultipartConfig
@WebServlet("/AddPaintingServlet")
public class AddPaintingServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Collect Form Data
        String title = request.getParameter("title");
        String artistName = request.getParameter("artist_name");
        String price = request.getParameter("price");
        String description = request.getParameter("description");
        String category = request.getParameter("category");  // Added category
        String stock = request.getParameter("stock");        // Added stock

        // Image Upload Logic
        Part filePart = request.getPart("image");
        String imageName = filePart.getSubmittedFileName();

        // File Type Validation (Allow only JPG, JPEG, PNG)
        if (!imageName.toLowerCase().matches(".*\\.(jpg|jpeg|png)$")) {
            response.sendRedirect("addPainting.jsp?error=Invalid image format. Only JPG, JPEG, PNG allowed.");
            return;
        }

        // Save Image in Project's WebApp Folder
        String uploadPath = getServletContext().getRealPath("/") + "images";
        File fileSaveDir = new File(uploadPath);

        // Create 'images' folder if it doesn't exist
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }

        // Final File Path
        String filePath = uploadPath + File.separator + imageName;
        filePart.write(filePath);

        // Database Connection
        String jdbcURL = "jdbc:mysql://localhost:3306/virtualart";
        String dbUser = "root";
        String dbPassword = "Atish@1193";

        try (Connection con = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
            String sql = "INSERT INTO paintings (title, artist_name, price, image_path, description, category, stock) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement pst = con.prepareStatement(sql)) {

                pst.setString(1, title);
                pst.setString(2, artistName);
                pst.setString(3, price);
                pst.setString(4, "images/" + imageName);
                pst.setString(5, description);
                pst.setString(6, category);
                pst.setInt(7, Integer.parseInt(stock));  // Convert stock to integer

                int rowCount = pst.executeUpdate();

                if (rowCount > 0) {
                    response.sendRedirect("adminindex.jsp?success=Painting added successfully.");
                } else {
                    response.sendRedirect("addPainting.jsp?error=Failed to add painting.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("addPainting.jsp?error=Database error: " + e.getMessage());
        } catch (NumberFormatException e) {
            response.sendRedirect("addPainting.jsp?error=Invalid stock value. Please enter a valid number.");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color: red;'>Error: " + e.getMessage() + "</h3>");
        }
    }
}
