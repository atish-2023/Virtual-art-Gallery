<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*" %>
<%@ page import="jakarta.servlet.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Virtual Art Gallery</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
        }

        .navbar {
            background-color: #4CAF50;
            padding: 15px;
            color: #fff;
            text-align: center;
            font-size: 24px;
        }

        .container {
            padding: 20px;
        }

        .welcome {
            text-align: center;
            font-size: 20px;
            margin-bottom: 30px;
        }

        .actions {
            display: flex;
            gap: 20px;
            justify-content: center;
        }

        .action-btn {
            background-color: #007bff;
            color: #fff;
            border: none;
            padding: 12px 20px;
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
    </style>
</head>
<body>

    <div class="navbar">
        Admin Dashboard - Virtual Art Gallery
    </div>

    <div class="container">

        <!-- Welcome Message -->
        <div class="welcome">
            Welcome, Admin!
        </div>

        <!-- Admin Actions -->
        <div class="actions">
            <a href="addPainting.jsp" class="action-btn">Add Painting</a>
            <a href="managepaintings.jsp" class="action-btn">Manage Paintings</a>
            <a href="manageusers.jsp" class="action-btn">Manage Users</a>
             <a href="manageUsers.jsp" class="action-btn">Orders & Sales</a>
             <a href="manageUsers.jsp" class="action-btn">Manage Artist</a>
             <a href="manageUsers.jsp" class="action-btn">Search & Filter</a>
            <a href="index.jsp" class="action-btn logout-btn">Logout</a>
        </div>

        <!-- Display Paintings -->
        <div class="gallery-section">
            <h2>All Paintings in Gallery</h2>

            <table>
                <tr>
                    <th>Image</th>
                    <th>Title</th>
                    <th>Artist</th>
                    <th>Price</th>
                    <th>Description</th>
                </tr>

                <%
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/virtualart", "root", "Atish@1193");

                        PreparedStatement pst = con.prepareStatement("SELECT * FROM paintings");
                        ResultSet rs = pst.executeQuery();

                        while (rs.next()) {
                %>
                    <tr>
                        <td>
                            <img src="<%= rs.getString("image_path") %>" alt="Painting Image">
                        </td>
                        <td><%= rs.getString("title") %></td>
                        <td><%= rs.getString("artist_name") %></td>
                        <td>$<%= rs.getBigDecimal("price") %></td>
                        <td><%= rs.getString("description") %></td>
                    </tr>
                <%
                        }
                        con.close();
                    } catch (Exception e) {
                        out.println("<p style='color: red;'>Error loading paintings: " + e.getMessage() + "</p>");
                    }
                %>
            </table>
        </div>
    </div>

</body>
</html>
