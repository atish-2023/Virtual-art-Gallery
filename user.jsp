<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*" %>

<%
    // Session check for logged-in user
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj == null || sessionObj.getAttribute("username") == null) {
        response.sendRedirect("login.jsp?error=Please login first.");
        return;
    }

    String username = (String) sessionObj.getAttribute("username");

    // Database connection details
    String jdbcURL = "jdbc:mysql://localhost:3306/virtualart?useSSL=false&serverTimezone=UTC";
    String dbUser = "root";
    String dbPassword = "Atish@1193";

    Connection con = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

        // Fetch user details
        String userQuery = "SELECT * FROM users WHERE username = ?";
        pst = con.prepareStatement(userQuery);
        pst.setString(1, username);
        rs = pst.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Dashboard - Virtual Art Gallery</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: violet;
            padding: 15px;
            color: #fff;
            text-align: center;
            font-size: 24px;
        }

        .container {
            padding: 20px;
        }

        .user-info {
            background-color: #ffffff;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .user-details {
            text-align: left;
            margin-top: 15px;
        }

        .actions {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 20px;
        }

        .action-btn {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
        }

        .action-btn:hover {
            background-color: #0056b3;
        }

        .logout-btn {
            background-color: #e74c3c;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }

        .gallery-section {
            margin-top: 40px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            text-align: center;
            padding: 10px;
        }

        th {
            background-color: #4CAF50;
            color: #fff;
        }

        img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
        }

        .add-to-cart-btn {
            background-color: #ff9800;
            color: #fff;
            border: none;
            padding: 6px 12px;
            border-radius: 5px;
            cursor: pointer;
        }

        .add-to-cart-btn:hover {
            background-color: #e68900;
        }
    </style>
</head>
<body>

    <div class="navbar">
        User Dashboard - Virtual Art Gallery
    </div>

    <div class="container">

        <!-- User Info Section -->
        <div class="user-info">
            <h2>Welcome, <%= username %>!</h2>

            <div class="user-details">
            <% if (rs.next()) { %>
                <p><strong>Username:</strong> <%= rs.getString("username") %></p>
                <p><strong>Email:</strong> <%= rs.getString("email") %></p>
                <p><strong>Role:</strong> <%= rs.getString("role") %></p>
                <p><strong>Account Created On:</strong> <%= rs.getTimestamp("created_at") %></p>
            <% } else { %>
                <p style="color: red;">User details not found!</p>
            <% } %>
            </div>

            <!-- User Actions -->
            <div class="actions">
                <a href="viewOrders.jsp" class="action-btn">View Orders</a>
                <a href="searchPaintings.jsp" class="action-btn">Search Paintings</a>
                <a href="index.jsp" class="action-btn logout-btn">Logout</a>
            </div>
        </div>

        <!-- Display Paintings -->
        <div class="gallery-section">
            <h2>Available Paintings</h2>

            <table>
                <tr>
                    <th>Image</th>
                    <th>Title</th>
                    <th>Artist</th>
                    <th>Price</th>
                    <th>Description</th>
                    <th>Action</th>
                </tr>

                <%
                    PreparedStatement pst2 = con.prepareStatement("SELECT * FROM paintings");
                    ResultSet rs2 = pst2.executeQuery();

                    while (rs2.next()) {
                %>
                    <tr>
                        <td>
                            <img src="<%= rs2.getString("image_path") %>" alt="Painting Image">
                        </td>
                        <td><%= rs2.getString("title") %></td>
                        <td><%= rs2.getString("artist_name") %></td>
                        <td>₹<%= rs2.getBigDecimal("price") %></td>
                        <td><%= rs2.getString("description") %></td>
                        <td>
                            <form action="AddToCartServlet" method="POST">
                                <input type="hidden" name="paintingId" value="<%= rs2.getInt("id") %>">
                                <input type="submit" class="add-to-cart-btn" value="Add to Cart">
                            </form>
                        </td>
                    </tr>
                <%
                    }
                %>
            </table>
        </div>
    </div>

</body>
</html>

<%
    } catch (Exception e) {
        out.println("<h3 style='color: red;'>Error: " + e.getMessage() + "</h3>");
    } finally {
        if (rs != null) rs.close();
        if (pst != null) pst.close();
        if (con != null) con.close();
    }
%>
