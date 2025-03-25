<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Paintings</title>
    <style>
        body { text-align: center; font-family: Arial, sans-serif; }
        table { width: 80%; border-collapse: collapse; margin: 20px auto; }
        th, td { padding: 10px; border: 1px solid black; text-align: left; }
        th { background-color: #f4f4f4; }
        .delete-btn { color: white; background: red; padding: 5px 10px; border-radius: 4px; text-decoration: none; }
        .painting-img { width: 80px; height: 80px; object-fit: cover; border-radius: 5px; }
    </style>
</head>
<body>
    <h2>Paintings List</h2>

    <%-- Display success or error message --%>
    <% if (request.getParameter("message") != null) { %>
        <p style="color: green;"><%= request.getParameter("message") %></p>
    <% } %>

    <table>
        <tr>
            <th>ID</th><th>Title</th><th>Artist</th><th>Price (₹)</th><th>Image</th><th>Action</th>
        </tr>
        <%
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL driver
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/virtualart", "root", "Atish@1193");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM paintings");

            while (rs.next()) { %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("title") %></td>
                    <td><%= rs.getString("artist_name") %></td>
                    <td><%= rs.getDouble("price") %></td>
                    <td><img src="<%= rs.getString("image_path") %>" class="painting-img"></td>
                    <td>
                        <a href="DeletePaintingServlet?id=<%= rs.getInt("id") %>" class="delete-btn" 
                           onclick="return confirm('Are you sure you want to delete this painting?');">
                            Delete
                        </a>
                    </td>
                </tr>
        <%  }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) { 
            e.printStackTrace(); 
        } %>
    </table>
</body>
</html>
